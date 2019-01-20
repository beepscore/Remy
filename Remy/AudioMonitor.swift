//
//  AudioMonitor.swift
//  Remy
//
//  Created by Steve Baker on 1/19/19.
//  Copyright © 2019 Beepscore LLC. All rights reserved.
//

import Foundation
import AVFoundation

/// https://stackoverflow.com/questions/31230854/ios-detect-blow-into-mic-and-convert-the-results-swift
/// https://stackoverflow.com/questions/35929989/how-to-monitor-audio-input-on-ios-using-swift-example
class AudioMonitor {

    var recorder: AVAudioRecorder?
    var levelTimer = Timer()

    // decibels (dbA?)
    // 0 dB indicates full scale, or maximum power
    // -160 dB indicates minimum power (that is, near silence)
    let LEVEL_THRESHOLD: Float = -10.0

    init() {

        let documents = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])

        // NOTE: on simulator, file extension .m4a prevents recording from starting.
        // Also using .m4a may lead to call to deinit()
        // Didn't check on device.
        // let url = documents.appendingPathComponent("recording.m4a")
        let url = documents.appendingPathComponent("record.caf")

        let recordSettings: [String: Any] = [
            AVFormatIDKey:              kAudioFormatAppleIMA4,
            AVSampleRateKey:            44100.0,
            AVNumberOfChannelsKey:      2,
            AVEncoderBitRateKey:        12800,
            AVLinearPCMBitDepthKey:     16,
            AVEncoderAudioQualityKey:   AVAudioQuality.max.rawValue
        ]

        let audioSession = AVAudioSession.sharedInstance()
        do {
            // https://github.com/lionheart/openradar-mirror/issues/20118
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord,
                                                            mode: AVAudioSession.Mode.default,
                                                            options: [AVAudioSession.CategoryOptions.mixWithOthers])
            try audioSession.setActive(true)
            try recorder = AVAudioRecorder(url:url, settings: recordSettings)
            // TODO: consider if want to set recorder.delegate

        } catch {
            return
        }

        guard let recorder = recorder else { return }

        recorder.prepareToRecord()
        recorder.isMeteringEnabled = true

        // recorder.record()
        let recordingDurationMinute = 30
        let secondPerMinute = 60
        let recordingDurationSecond = TimeInterval(secondPerMinute * recordingDurationMinute)
        recorder.record(forDuration: recordingDurationSecond)

        // let timeIntervalSecond = 0.2
        let timeIntervalSecond = 2.0

        levelTimer = Timer.scheduledTimer(timeInterval: timeIntervalSecond,
                                          target: self,
                                          selector: #selector(levelTimerCallback),
                                          userInfo: nil,
                                          repeats: true)
    }


    @objc func levelTimerCallback() {
        guard let recorder = recorder else { return }

        // To obtain a current average power value,
        // you must call the updateMeters() method before calling averagePower.
        recorder.updateMeters()
        let level = recorder.averagePower(forChannel: 0)

        let isLoud = level > LEVEL_THRESHOLD

        // do whatever you want with isLoud
        print("levelTimerCallback sound level: \(level) decibel, isLoud: \(isLoud)")
    }

    @objc func stopRecordingAndDelete() {
        print("stopRecordingAndDelete")
        recorder?.stop()
        // The audio recorder must be stopped before you call deleteRecording.
        recorder?.deleteRecording()
        levelTimer.invalidate()
    }

    deinit {
        stopRecordingAndDelete()
    }

}
