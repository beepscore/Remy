//
//  FileUtilTests.swift
//  RemyTests
//
//  Created by Steve Baker on 7/7/19.
//  Copyright © 2019 Beepscore LLC. All rights reserved.
//

import XCTest
@testable import Remy


class FileUtilTests: XCTestCase {

    func testBaseFileName() {
        let path = "bar/foo.swift"
        XCTAssertEqual(FileUtil.baseFileName(path: path), "foo")
    }

}
