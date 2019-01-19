//
//  EndCallResponseTests.swift
//  RemyTests
//
//  Created by Steve Baker on 1/19/19.
//  Copyright © 2019 Beepscore LLC. All rights reserved.
//

import XCTest
@testable import Remy

class EndCallResponseTests: XCTestCase {

    func testEndCallResponse() {
        let response = EndCallResponse(api_name: "foo",
                                       response: "bar",
                                       status: "SUCCESS",
                                       version: "3.5")

        XCTAssertEqual(response.api_name, "foo")
        XCTAssertEqual(response.response, "bar")
        XCTAssertEqual(response.status, "SUCCESS")
        XCTAssertEqual(response.version, "3.5")
    }

}
