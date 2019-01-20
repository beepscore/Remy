//
//  TVServiceTests.swift
//  RemyTests
//
//  Created by Steve Baker on 1/19/19.
//  Copyright © 2019 Beepscore LLC. All rights reserved.
//

import XCTest
@testable import Remy

class TVServiceTests: XCTestCase {


    func testBaseURLPortApiVersionString() {
        XCTAssertEqual(TVService.baseURLPortApiVersionString(),
                       "http://10.0.0.4:5000/api/v1")
    }

    func testCommandURLVolumeDecrease() {
        let url = TVService.commandURL(tvCommand: .volumeDecrease)
        let expected = "Optional(http://10.0.0.4:5000/api/v1/tv/volume-decrease/)"
        XCTAssertEqual(String(describing: url), expected)
    }

    func testCommandURLVolumeIncrease() {
        let url = TVService.commandURL(tvCommand: .volumeIncrease)
        let expected = "Optional(http://10.0.0.4:5000/api/v1/tv/volume-increase/)"
        XCTAssertEqual(String(describing: url), expected)
    }


}
