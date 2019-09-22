//
//  TVServiceError.swift
//  Remy
//
//  Created by Steve Baker on 9/21/19.
//  Copyright © 2019 Beepscore LLC. All rights reserved.
//

import Foundation

enum TVServiceError: LocalizedError {
    case dataNil
    case decodingError
    // https://stackoverflow.com/questions/39176196/how-to-provide-a-localized-description-with-an-error-type-in-swift
    // httpError has associated values
    case httpError(status: Int, message: String)
    case responseNil
    case urlNil
}

extension TVServiceError {

    public var errorDescription: String? {
        switch self {
        case let .httpError(status, message):
            return "\(status) \(message)"
        default:
            return self.localizedDescription
        }
    }
}
