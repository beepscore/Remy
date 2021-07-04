//
//  AudioViewTests.swift
//  RemyTests
//
//  Created by Steve Baker on 7/3/21.
//

import XCTest
@testable import Remy

class AudioViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testaudioLevelSliderAccentColorAudioLevelLessThanAudioLimit() throws {
        let actual = AudioView.audioLevelSliderAccentColor(audioLevel: -60, audioLimit: -40)
        XCTAssertEqual(actual, .green)
    }

    func testaudioLevelSliderAccentColorAudioLevelEqualToAudioLimit() throws {
        let actual = AudioView.audioLevelSliderAccentColor(audioLevel: -40, audioLimit: -40)
        XCTAssertEqual(actual, .green)
    }

    func testaudioLevelSliderAccentColorAudioLevelGreaterThanAudioLimit() throws {
        let actual = AudioView.audioLevelSliderAccentColor(audioLevel: -30, audioLimit: -40)
        XCTAssertEqual(actual, .red)
    }

}
