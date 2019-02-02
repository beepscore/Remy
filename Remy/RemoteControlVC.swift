//
//  RemoteControlVC.swift
//  Remy
//
//  Created by Steve Baker on 1/19/19.
//  Copyright © 2019 Beepscore LLC. All rights reserved.
//

import UIKit

class RemoteControlVC: UIViewController {

    @IBOutlet weak var bassDecreaseButton: UIButton!
    @IBOutlet weak var bassIncreaseButton: UIButton!
    @IBOutlet weak var voiceDecreaseButton: UIButton!
    @IBOutlet weak var voiceIncreaseButton: UIButton!
    @IBOutlet weak var volumeDecreaseButton: UIButton!
    @IBOutlet weak var volumeIncreaseButton: UIButton!
    @IBOutlet weak var bassLabel: UILabel!
    @IBOutlet weak var voiceLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!

    @IBOutlet weak var audioLevelLabel: UILabel!
    @IBOutlet weak var audioLevelSlider: UISlider!
    @IBOutlet weak var audioLimitSlider: UISlider!

    var audioMonitor: AudioMonitor?

    let tvService = TVService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        NotificationCenter.default.addObserver(self, selector: #selector(audioLevelNotification(_:)),
                                               name: AudioMonitor.audioLevelNotificationName,
                                               object: .none)
        audioMonitor = AudioMonitor.shared
        configureUI()
    }

    @objc func audioLevelNotification(_ notification: Notification) {
        guard let audioLevel = notification.userInfo?[AudioMonitor.audioLevelKey] as? Float,
            let _ = notification.userInfo?[AudioMonitor.isLoudKey] as? Bool else {
                return
        }

        audioLevelLabel.text = String(Int(audioLevel))
        audioLevelSlider.setValue(audioLevel, animated: true)
        if let audioThreshold = audioMonitor?.levelDbThreshold {
            tintAudioLevelSlider(audioLevel: audioLevel, audioThreshold: audioThreshold)
        }
    }

    func configureUI() {
        configureSliders()

        let cornerRadius = CGFloat(8.0)
        bassDecreaseButton.layer.cornerRadius = cornerRadius
        bassIncreaseButton.layer.cornerRadius = cornerRadius
        voiceDecreaseButton.layer.cornerRadius = cornerRadius
        voiceIncreaseButton.layer.cornerRadius = cornerRadius
        volumeDecreaseButton.layer.cornerRadius = cornerRadius
        volumeIncreaseButton.layer.cornerRadius = cornerRadius

        bassLabel.text = NSLocalizedString("Bass", comment: "Bass")
        voiceLabel.text = NSLocalizedString("Voice", comment: "Voice")
        volumeLabel.text = NSLocalizedString("Volume", comment: "Volume")
    }

    func configureSliders() {
        audioLevelSlider.isUserInteractionEnabled = false
        audioLevelSlider.minimumValue = AudioMonitor.levelMinDb
        audioLevelSlider.maximumValue = AudioMonitor.levelMaxDb
        // levelMaxDb == 0 and levelMinDb is < 0, so use levelMinDb/2
        audioLevelSlider.value = AudioMonitor.levelMinDb / 2
        audioLevelSlider.tintColor = .green
        audioLevelSlider.thumbTintColor = .green

        audioLimitSlider.isUserInteractionEnabled = true
        audioLimitSlider.minimumValue = AudioMonitor.levelMinDb
        audioLimitSlider.maximumValue = AudioMonitor.levelMaxDb
        audioLimitSlider.value = audioMonitor?.levelDbThreshold ?? 0.0
        audioLimitSlider.tintColor = .black
        audioLimitSlider.thumbTintColor = .black
    }

    func tintAudioLevelSlider(audioLevel: Float, audioThreshold: Float) {
        let tintColor: UIColor = (audioLevel > audioThreshold) ? .red : .green
        audioLevelSlider.tintColor = tintColor
        audioLevelSlider.thumbTintColor = tintColor
    }

    // MARK: - IBActions
    @IBAction func audioLimitSlider(_ sender: UISlider) {
        audioMonitor?.levelDbThreshold = sender.value
    }

    @IBAction func voiceDecreaseButtonTapped(_ sender: Any) {
        tvService.voiceDecrease()
    }

    @IBAction func voiceIncreaseButtonTapped(_ sender: Any) {
        tvService.voiceIncrease()
    }

    @IBAction func volumeDecreaseButtonTapped(_ sender: Any) {
        tvService.volumeDecrease()
    }

    @IBAction func volumeIncreaseButtonTapped(_ sender: Any) {
        tvService.volumeIncrease()
    }

}
