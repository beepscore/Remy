//
//  TVResponse.swift
//  Remy
//
//  Created by Steve Baker on 1/19/19.
//  Copyright © 2019 Beepscore LLC. All rights reserved.
//

import Foundation

/// decodes response from TVService e.g. remy_python service.py
struct TVResponse: Codable {
    let api_name: String
    let message: String
    let version: String
}
