//
//  TVResponse.swift
//  Remy
//
//  Created by Steve Baker on 1/19/19.
//  Copyright © 2019 Beepscore LLC. All rights reserved.
//

import Foundation

/// response from TVService
struct TVResponse: Codable {
    var api_name: String
    var response: String
    var status: String
    var version: String
}
