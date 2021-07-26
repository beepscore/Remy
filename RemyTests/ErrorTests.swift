//
//  ErrorTests.swift
//  RemyTests
//
//  Created by Steve Baker on 10/13/19.
//  Copyright © 2019 Beepscore LLC. All rights reserved.
//

import XCTest
import OSLog
@testable import Remy

class ErrorTests: XCTestCase {

    let logger = Logger(subsystem: SettingsModel.loggerSubsytem, category: "ErrorTests")

    /// This test is not intended to check if Apple's implementation is correct,
    /// just to check the English localizedDescription.
    /// DecodingError() cannot be constructed because it has no accessible initializers.
    /// Instead, purposely throw a DecodingError so test can check it.
    func testDecodingErrorLocalizedDescription() {

        struct Dog: Codable, CustomStringConvertible {
            let breed: String?

            var description: String {
                // could add an extension to convert Codable to dictionary, but not needed for this test.
                // https://stackoverflow.com/questions/52922889/converting-codable-encodable-to-json-object-swift
                return "breed: \(breed ?? "nil")"
            }
        }

        /// Cat is incompatible with Dog
        struct Cat: Codable, CustomStringConvertible {
            // non-optional so decode will fail
            let weight: Double

            var description: String {
                // could add an extension to convert Codable to dictionary, but not needed for this test.
                // https://stackoverflow.com/questions/52922889/converting-codable-encodable-to-json-object-swift
                return "weight: \(weight)"
            }

        }

        let dog = Dog(breed: "Labrador Retriever")
        logger.error("testDecodingError dog: \(dog, privacy: .public)")
        guard let dogData = try? JSONEncoder().encode(dog) else {
            XCTFail("couldn't encode dogData to setup test")
            return
        }

        do {
            // purposely throw DecodingError. Can't decode dogData as a cat
            let cat = try JSONDecoder().decode(Cat.self, from: dogData)
            XCTFail("decode should have thrown a DecodingError preventing execution from reaching here.")
            logger.error("testDecodingError cat: \(cat, privacy: .public)")

        } catch let error {
            // test the intentionally thrown error
            logger.error("testDecodingError error: \(error.localizedDescription)")
            // most callers can simply use localizedDescription
            XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it is missing.")
        }
    }

}
