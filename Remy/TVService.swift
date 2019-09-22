//
//  TVService.swift
//  Remy
//
//  Created by Steve Baker on 1/19/19.
//  Copyright © 2019 Beepscore LLC. All rights reserved.
//

import Foundation
import os.log

class TVService {

    enum TVCommand: String {
        case mute = "mute"
        case power = "power"
        case bassDecrease = "bass-decrease"
        case bassIncrease = "bass-increase"
        case voiceDecrease = "voice-decrease"
        case voiceIncrease = "voice-increase"
        case volumeDecrease = "volume-decrease"
        case volumeIncrease = "volume-increase"
    }

    let urlSession: URLSession

    init(timeoutSeconds: Int) {
        // https://stackoverflow.com/questions/23428793/nsurlsession-how-to-increase-time-out-for-url-requests
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = TimeInterval(timeoutSeconds)
        config.timeoutIntervalForResource = TimeInterval(timeoutSeconds)
        urlSession = URLSession(configuration: config)
    }

    static func baseURLPortApiVersionString() -> String {
        let baseURL = "http://10.0.0.4"
        let port = 5000
        let api = "api"
        let version = "v1"

        return baseURL + ":" + String(port) + "/" + api + "/" + version
    }

    static func commandURL(tvCommand: TVCommand) -> URL? {
        let urlString = TVService.baseURLPortApiVersionString() + "/tv/" + tvCommand.rawValue + "/"
        let url = URL(string: urlString)
        return url
    }

    /// make a web request to a service
    func requestCommand(tvCommand: TVCommand,
                        completion: @escaping (Result<TVResponse, Error>) -> Void) {

        guard let url = TVService.commandURL(tvCommand: tvCommand) else {
            completion(.failure(TVServiceError.urlNil))
            return
        }

        // https://stackoverflow.com/questions/26364914/http-request-in-swift-with-post-method#26365148
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        // Apple suggests "Don’t include symbol information or source file line numbers in messages. The system automatically captures this information."
        // https://developer.apple.com/documentation/os/logging
        // https://stackoverflow.com/questions/52366951/apple-unified-logging-how-to-get-file-name-and-line-number
        os_log("file: %s function: %s %s",
               log: Logger.shared.log,
               type: .debug,
               FileUtil.baseFilename(path: #file), #function,
               String(describing: request))

        // dataTask will pass data, response, error to its completionHandler
        let task = urlSession.dataTask(with: request) { data, response, error in

            // https://stackoverflow.com/questions/55847474/how-to-use-new-result-type-introduced-in-swift-5-urlsession

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(TVServiceError.responseNil))
                return
            }

            if !(200...299).contains(httpResponse.statusCode)
                && (httpResponse.statusCode != 304) {
                // print("error=\(String(describing: error))")
                // e.g. nw_socket_connect [C3:2] connect failed (fd 10) [64: Host is down]
                //   - some : Error Domain=NSURLErrorDomain Code=-1005 "The network connection was lost." UserInfo={NSUnderlyingError=0x6000000f1da0 {Error Domain=kCFErrorDomainCFNetwork Code=-1005 "(null)" UserInfo={_kCFStreamErrorCodeKey=57, _kCFStreamErrorDomainKey=1}}, NSErrorFailingURLStringKey=http://10.0.0.4:5000/api/v1/tv/volume_decrease/, NSErrorFailingURLKey=http://10.0.0.4:5000/api/v1/tv/volume_decrease/, _kCFStreamErrorDomainKey=1, _kCFStreamErrorCodeKey=57, NSLocalizedDescription=The network connection was lost.}

                completion(.failure(TVServiceError.httpError(String(httpResponse.statusCode))))
                return
            }

            guard let data = data else {
                completion(.failure(TVServiceError.dataNil))
                return
            }

            let decoder = JSONDecoder()
            do {
                let tvResponse = try decoder.decode(TVResponse.self, from: data)
                completion(.success(tvResponse))
            } catch {
                completion(.failure(TVServiceError.decodingError))
            }
        }
        task.resume()
    }

    /// make a web request to a service to mute sound
    /// - Parameter completion: passed along to requestCommand
    func mute(completion: @escaping (Result<TVResponse, Error>) -> Void) {
        requestCommand(tvCommand: .mute,  completion: completion)
    }

    /// make a web request to a service to turn power off or on
    /// - Parameter completion: passed along to requestCommand
    func power(completion: @escaping (Result<TVResponse, Error>) -> Void) {
        requestCommand(tvCommand: .power,  completion: completion)
    }

    /// make a web request to a service to decrease bass
    /// - Parameter completion: passed along to requestCommand
    func bassDecrease(completion: @escaping (Result<TVResponse, Error>) -> Void) {
        requestCommand(tvCommand: .bassDecrease,  completion: completion)
    }

    /// make a web request to a service to increase bass
    /// - Parameter completion: passed along to requestCommand
    func bassIncrease(completion: @escaping (Result<TVResponse, Error>) -> Void) {
        requestCommand(tvCommand: .bassIncrease,  completion: completion)
    }
    
    /// make a web request to a service to decrease voice
    /// - Parameter completion: passed along to requestCommand
    func voiceDecrease(completion: @escaping (Result<TVResponse, Error>) -> Void) {
        requestCommand(tvCommand: .voiceDecrease,  completion: completion)
    }

    /// make a web request to a service to increase voice
    /// - Parameter completion: passed along to requestCommand
    func voiceIncrease(completion: @escaping (Result<TVResponse, Error>) -> Void) {
        requestCommand(tvCommand: .voiceIncrease,  completion: completion)
    }

    /// make a web request to a service to decrease volume
    /// - Parameter completion: passed along to requestCommand
    func volumeDecrease(completion: @escaping (Result<TVResponse, Error>) -> Void) {
        requestCommand(tvCommand: .volumeDecrease,  completion: completion)
    }

    /// make a web request to a service to increase volume
    /// - Parameter completion: passed along to requestCommand
    func volumeIncrease(completion: @escaping (Result<TVResponse, Error>) -> Void) {
        requestCommand(tvCommand: .volumeIncrease,  completion: completion)
    }

}
