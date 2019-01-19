//
//  TVService.swift
//  Remy
//
//  Created by Steve Baker on 1/19/19.
//  Copyright © 2019 Beepscore LLC. All rights reserved.
//

import Foundation

class TVService {

    static func urlBasePortApiVersion() -> String {

        let baseURL = "http://10.0.0.4"
        let port = 5000
        let api = "api"
        let version = "v1"

        return baseURL + ":" + String(port) + "/" + api + "/" + version
    }

    /// make a web request to a service to end the phone call
    func endCall() {

        // https://stackoverflow.com/questions/26364914/http-request-in-swift-with-post-method#26365148
        let urlString = "http://10.0.0.4:5000/api/v1/gpio/end-phone-call/"
        let url = URL(string: urlString)!
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
                let endCallResponse = try decoder.decode(EndCallResponse.self, from: data)
                print("endCallResponse", endCallResponse)

                if endCallResponse.status == "SUCCESS" {
                    // NOTE: expectServerResponseStatusSuccess.fulfill
                    // just shows the server processed the endCall request.
                    // It doesn't guarantee that a phone call connected or ended
                    // expectServerResponseStatusSuccess.fulfill()
                }
            } catch {
                print("error trying to convert data to JSON")
                print(error)
            }
        }
        task.resume()
    }

}
