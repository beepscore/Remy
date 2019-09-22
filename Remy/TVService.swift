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

    /// - Parameter timeoutSeconds: type TimeInterval matches URLSessionConfiguration property type
    init(timeoutSeconds: TimeInterval) {
        // https://stackoverflow.com/questions/23428793/nsurlsession-how-to-increase-time-out-for-url-requests
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = TimeInterval(timeoutSeconds)
        config.timeoutIntervalForResource = TimeInterval(timeoutSeconds)
        urlSession = URLSession(configuration: config)
    }

    /// implementation uses urlComponents, more reliable than String concatenation
    static func commandURL(tvCommand: TVCommand) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "10.0.0.4"
        urlComponents.port = 5000
        // path must start with "/"
        urlComponents.path = "/api/v1/tv/\(tvCommand.rawValue)/"
        return urlComponents.url
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
                completion(.failure(TVServiceError.httpError(status: httpResponse.statusCode,
                                                             message: HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))))
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
            } catch let error {
                // use Swift DecodingError, not custom TVServiceError
                // e.g. "The data couldn't be read because it is missing"
                completion(.failure(error))
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
