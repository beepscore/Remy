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
        case mute = "mute"
        case power = "power"
        case bassDecrease = "bass-decrease"
        case bassIncrease = "bass-increase"
        case voiceDecrease = "voice-decrease"
        case voiceIncrease = "voice-increase"
        case volumeDecrease = "volume-decrease"
        case volumeIncrease = "volume-increase"
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

        // dataTask will pass data, response, error to its completionHandler
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            guard let data = data, error == nil else {
                // fundamental networking error
                print("error=\(String(describing: error))")
                // e.g. nw_socket_connect [C3:2] connect failed (fd 10) [64: Host is down]
                //   - some : Error Domain=NSURLErrorDomain Code=-1005 "The network connection was lost." UserInfo={NSUnderlyingError=0x6000000f1da0 {Error Domain=kCFErrorDomainCFNetwork Code=-1005 "(null)" UserInfo={_kCFStreamErrorCodeKey=57, _kCFStreamErrorDomainKey=1}}, NSErrorFailingURLStringKey=http://10.0.0.4:5000/api/v1/tv/volume_decrease/, NSErrorFailingURLKey=http://10.0.0.4:5000/api/v1/tv/volume_decrease/, _kCFStreamErrorDomainKey=1, _kCFStreamErrorCodeKey=57, NSLocalizedDescription=The network connection was lost.}

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
                // TODO: consider post notification, a visible view controller
                // can opt to show toast similar to Android toast

            } catch {
                print("error trying to convert data to JSON")
                print(error)
            }
        }
        task.resume()
    }

    /// make a web request to a service to mute sound
    func mute() {
        requestCommand(tvCommand: .mute)
    }

    /// make a web request to a service to turn power off or on
    func power() {
        requestCommand(tvCommand: .power)
    }

    /// make a web request to a service to decrease bass
    func bassDecrease() {
        requestCommand(tvCommand: .bassDecrease)
    }

    /// make a web request to a service to increase bass
    func bassIncrease() {
        requestCommand(tvCommand: .bassIncrease)
    }
    
    /// make a web request to a service to decrease voice
    func voiceDecrease() {
        requestCommand(tvCommand: .voiceDecrease)
    }

    /// make a web request to a service to increase voice
    func voiceIncrease() {
        requestCommand(tvCommand: .voiceIncrease)
    }

    /// make a web request to a service to decrease volume
    func volumeDecrease() {
        requestCommand(tvCommand: .volumeDecrease)
    }

    /// make a web request to a service to increase volume
    func volumeIncrease() {
        requestCommand(tvCommand: .volumeIncrease)
    }

}
