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

    func testHttpError() {
        do {
            throw TVServiceError.httpError(status: 999, message: "wow")
        } catch let error {
            XCTAssertEqual(error.localizedDescription, "999 wow")
        }
    }

    func testDataNil() {
        do {
            throw TVServiceError.dataNil
        } catch let error {
            XCTAssertEqual(error.localizedDescription, "Data nil")
        }
    }

    func testResponseNil() {
        do {
            throw TVServiceError.responseNil
        } catch let error {
            XCTAssertEqual(error.localizedDescription, "Response nil")
        }
    }

    func testUrlNil() {
        do {
            throw TVServiceError.urlNil
        } catch let error {
            XCTAssertEqual(error.localizedDescription, "URL nil")
        }
    }

}
