//
//  ErrorTests.swift
//  RemyTests
//
//  Created by Steve Baker on 10/13/19.
//  Copyright © 2019 Beepscore LLC. All rights reserved.
//

import XCTest
@testable import Remy

class ErrorTests: XCTestCase {

    /// This test is not intended to check if Apple's implementation is correct,
    /// just to check the English localizedDescription.
    /// DecodingError() cannot be constructed because it has no accessible initializers.
    /// Instead, purposely throw a DecodingError so test can check it.
    func testDecodingErrorLocalizedDescription() {

        struct Dog: Codable {
            let breed: String?
        }

        /// Cat is incompatible with Dog
        struct Cat: Codable {
            // non-optional so decode will fail
            let weight: Double
        }

        let dog = Dog(breed: "Labrador Retriever")
        print("testDecodingError dog: \(dog)")
        guard let dogData = try? JSONEncoder().encode(dog) else {
            XCTFail("couldn't encode dogData to setup test")
            return
        }

        do {
            // purposely throw DecodingError. Can't decode dogData as a cat
            let cat = try JSONDecoder().decode(Cat.self, from: dogData)
            XCTFail("decode should have thrown a DecodingError preventing execution from reaching here.")
            print("testDecodingError cat: \(cat)")

        } catch let error {
            // test the intentionally thrown error
            print("testDecodingError error: \(error)")
            // most callers can simply use localizedDescription
            XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it is missing.")
        }
    }

}
