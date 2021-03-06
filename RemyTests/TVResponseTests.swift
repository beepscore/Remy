//
//  TVResponseTests.swift
//  RemyTests
//
//  Created by Steve Baker on 1/19/19.
//  Copyright © 2019 Beepscore LLC. All rights reserved.
//

import XCTest
@testable import Remy

class TVResponseTests: XCTestCase {

    func testTVResponseInit() {
        let response = TVResponse(api_name: "foo",
                                  message: "bar",
                                  version: "3.5")

        XCTAssertEqual(response.api_name, "foo")
        XCTAssertEqual(response.message, "bar")
        XCTAssertEqual(response.version, "3.5")
    }

}
