//
//  TVServiceErrorTests.swift
//  RemyTests
//
//  Created by Steve Baker on 10/12/19.
//  Copyright © 2019 Beepscore LLC. All rights reserved.
//

import XCTest
@testable import Remy

class TVServiceErrorTests: XCTestCase {


//    func testDecodingError() {
//        do {
//            throw DecodingError()
//            // DecodingError cannot be constructed because it has no accessible initializers
//        } catch let error {
//            XCTAssertEqual(error.localizedDescription, "The data couldn't be read because it is missing")
//        }
//    }

    func testResponseNil() {
        do {
            throw TVServiceError.responseNil
        } catch let error {
            XCTAssertEqual(error.localizedDescription, "Response nil")
        }
    }

}
