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
    // don't implement case decodingError, use Swift DecodingError instead
    // https://stackoverflow.com/questions/39176196/how-to-provide-a-localized-description-with-an-error-type-in-swift
    // httpError has associated values
    case httpError(status: Int, message: String)
    case responseNil
    case urlNil
}

extension TVServiceError {

    public var errorDescription: String? {
        switch self {
        case .dataNil:
            return NSLocalizedString("Data nil", comment: "Response nil")
        case let .httpError(status, message):
            // e.g. "404 Not Found"
            return "\(status) \(message)"
        case .responseNil:
            return NSLocalizedString("Response nil", comment: "Response nil")
        default:
            return self.localizedDescription
        }
    }
}
