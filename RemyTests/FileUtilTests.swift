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

    func testBaseFilenameFoo() {
        let path = "bar/foo.swift"
        XCTAssertEqual(FileUtil.baseFilename(path: path), "foo")
    }

    func testBaseFilenameFile() {
        let path = #file
        // "/Users/stevebaker/Documents/projects/iOSProjects/Remy/RemyTests/FileUtilTests.swift"
        
        XCTAssertEqual(FileUtil.baseFilename(path: path), "FileUtilTests")
    }

}
