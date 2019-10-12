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

    // case decodingError Don't implement, use Swift DecodingError instead

    // https://stackoverflow.com/questions/39176196/how-to-provide-a-localized-description-with-an-error-type-in-swift
    // httpError has associated values
    case httpError(status: Int, message: String)

    case responseNil
    case urlNil
}

extension TVServiceError {

    // LocalizedError errorDescription supplies info for error.localizedDescription
    // for examples see TVServiceErrorTests.
    // option click to see original documentation comment
    // "A localized message describing what error occurred"
    public var errorDescription: String? {
        switch self {
            
        case .dataNil:
            return NSLocalizedString("Data nil", comment: "Response nil")

        case let .httpError(status, message):
            // use the associated values status and message
            // e.g. status 404 and message "Not Found" yields "404 Not Found"
            return "\(status) \(message)"

        case .responseNil:
            return NSLocalizedString("Response nil", comment: "Response nil")

        case .urlNil:
            return NSLocalizedString("URL nil", comment: "URL nil")
        }
    }
}
