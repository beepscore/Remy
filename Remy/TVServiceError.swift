//
//  TVServiceError.swift
//  Remy
//
//  Created by Steve Baker on 9/21/19.
//  Copyright © 2019 Beepscore LLC. All rights reserved.
//

import Foundation

enum TVServiceError: Error {
    case dataNil
    case decodingError
    // httpError has associated value String
    case httpError(String)
    case responseNil
    case urlNil
}
