//
//  TVService.swift
//  Remy
//
//  Created by Steve Baker on 1/19/19.
//  Copyright © 2019 Beepscore LLC. All rights reserved.
//

import Foundation

class TVService {

    enum TVCommand: String {
        case volumeDecrease = "volume_decrease"
        case volumeIncrease = "volume_increase"
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
    func requestCommand(tvCommand: TVCommand) {

        guard let url = TVService.commandURL(tvCommand: tvCommand) else {
            return
        }

        // https://stackoverflow.com/questions/26364914/http-request-in-swift-with-post-method#26365148
        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            guard let data = data, error == nil else {
                // fundamental networking error
                print("error=\(String(describing: error))")
                return
            }

            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // http error
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                return
            }

            let decoder = JSONDecoder()
            do {
                let tvResponse = try decoder.decode(TVResponse.self, from: data)
                print("tvResponse", tvResponse)

                if tvResponse.status == "SUCCESS" {
                    // TODO: consider post notification, a visible view controller
                    // can opt to show toast similar to Android toast
                }
            } catch {
                print("error trying to convert data to JSON")
                print(error)
            }
        }
        task.resume()
    }

    /// make a web request to a service to decrease volume
    func volumeDecrease() {
        requestCommand(tvCommand: .volumeDecrease)
    }

    /// make a web request to a service to decrease volume
    func volumeIncrease() {
        requestCommand(tvCommand: .volumeIncrease)
    }

}
