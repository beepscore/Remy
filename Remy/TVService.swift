//
//  TVService.swift
//  Remy
//
//  Created by Steve Baker on 1/19/19.
//  Copyright © 2019 Beepscore LLC. All rights reserved.
//

import Foundation
import OSLog

class TVService: ObservableObject {

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

    /// logger for TVService. One app can have multiple loggers.
    let logger = Logger(subsystem: SettingsModel.loggerSubsytem, category: "TVService")

    let urlSession: URLSession

    /// Use shared because TVService isn't a SwiftUI View, can't use @EnvironmentObject or @ObservedObject
    static var settingsModel = SettingsModel.shared

    @Published var statusText = ""

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

        urlComponents.host = settingsModel.host
        urlComponents.port = Int(settingsModel.port)
        
        // path must start with "/"
        urlComponents.path = "/api/v1/tv/\(tvCommand.rawValue)/"
        return urlComponents.url
    }

    /// make a web request to a service
    func requestCommand(tvCommand: TVCommand,
                        completion: @escaping (Result<TVResponse, Error>) -> Void) {

        guard let url = TVService.commandURL(tvCommand: tvCommand) else {
            logger.error("requestCommand TVServiceError.urlNil")
            completion(.failure(TVServiceError.urlNil))
            return
        }

        // https://stackoverflow.com/questions/26364914/http-request-in-swift-with-post-method#26365148
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        logger.debug("requestCommand \(String(describing: request), privacy: .public)")

        // dataTask will pass data, response, error to its completionHandler
        let task = urlSession.dataTask(with: request) { data, response, error in

            // https://stackoverflow.com/questions/55847474/how-to-use-new-result-type-introduced-in-swift-5-urlsession

            if let error = error {
                self.logger.error("requestCommand \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                self.logger.error("requestCommand TVServiceError.responseNil")
                completion(.failure(TVServiceError.responseNil))
                return
            }

            if !(200...299).contains(httpResponse.statusCode)
                && (httpResponse.statusCode != 304) {
                let message = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)

                self.logger.error("requestCommand TVServiceError.httpError status \(httpResponse.statusCode, privacy: .public), message \(message, privacy: .public)")

                completion(.failure(TVServiceError.httpError(status: httpResponse.statusCode, message: message)))
                return
            }

            guard let data = data else {
                self.logger.error("requestCommand TVServiceError.dataNil")
                completion(.failure(TVServiceError.dataNil))
                return
            }

            let decoder = JSONDecoder()
            do {
                let tvResponse = try decoder.decode(TVResponse.self, from: data)
                completion(.success(tvResponse))
            } catch let error {
                // catch Swift DecodingError
                // use DecodingError "as is", don't create a custom TVServiceError.
                self.logger.error("requestCommand \(error.localizedDescription, privacy: .public)")
                
                // caller can use error.localizedDescription e.g. English localizedDescription
                // "The data couldn't be read because it is missing"
                completion(.failure(error))
            }
        }
        task.resume()
    }

    // TODO: consider change request functions from using a completion to using Combine to publish a result
    // https://www.hackingwithswift.com/books/ios-swiftui/sending-and-receiving-codable-data-with-urlsession-and-swiftui

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

    func updateStatusText(result: Result<TVResponse, Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let tvResponse):
                self.statusText = tvResponse.message
            case .failure(let error):
                // error may be type Error or any subclass e.g. DecodingError or TVServiceError
                // error just needs to have a localizedDescription.
                // e.g.
                // "unsupported URL"
                // "Could not connect to the server."
                // "The request timed out."
                // "404 Not Found"
                self.statusText = error.localizedDescription
            }
        }
    }

}
