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

    func testCommandURLMute() {
        let url = TVService.commandURL(tvCommand: .mute)
        let expected = "Optional(http://10.0.0.4:5000/api/v1/tv/mute/)"
        XCTAssertEqual(String(describing: url), expected)
    }

    func testCommandURLPower() {
        let url = TVService.commandURL(tvCommand: .power)
        let expected = "Optional(http://10.0.0.4:5000/api/v1/tv/power/)"
        XCTAssertEqual(String(describing: url), expected)
    }

    func testCommandURLBassDecrease() {
        let url = TVService.commandURL(tvCommand: .bassDecrease)
        let expected = "Optional(http://10.0.0.4:5000/api/v1/tv/bass-decrease/)"
        XCTAssertEqual(String(describing: url), expected)
    }

    func testCommandURLBassIncrease() {
        let url = TVService.commandURL(tvCommand: .bassIncrease)
        let expected = "Optional(http://10.0.0.4:5000/api/v1/tv/bass-increase/)"
        XCTAssertEqual(String(describing: url), expected)
    }

    func testCommandURLVoiceDecrease() {
        let url = TVService.commandURL(tvCommand: .voiceDecrease)
        let expected = "Optional(http://10.0.0.4:5000/api/v1/tv/voice-decrease/)"
        XCTAssertEqual(String(describing: url), expected)
    }

    func testCommandURLVoiceIncrease() {
        let url = TVService.commandURL(tvCommand: .voiceIncrease)
        let expected = "Optional(http://10.0.0.4:5000/api/v1/tv/voice-increase/)"
        XCTAssertEqual(String(describing: url), expected)
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
