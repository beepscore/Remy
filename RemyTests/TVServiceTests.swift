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


    func testUrlBasePortApiVersion() {
        XCTAssertEqual(TVService.urlBasePortApiVersion(),
                       "http://10.0.0.4:5000/api/v1")
    }

}
