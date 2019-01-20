//
//  RemoteControlVC.swift
//  Remy
//
//  Created by Steve Baker on 1/19/19.
//  Copyright © 2019 Beepscore LLC. All rights reserved.
//

import UIKit

class RemoteControlVC: UIViewController {

    @IBOutlet weak var volumeDecreaseButton: UIButton!
    @IBOutlet weak var volumeIncreaseButton: UIButton!
    @IBOutlet weak var volumeLabel: UILabel!

    @IBOutlet weak var audioLevelSlider: UISlider!

    let tvService = TVService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        NotificationCenter.default.addObserver(self, selector: #selector(audioLevelNotification(_:)),
                                               name: AudioMonitor.audioLevelNotificationName,
                                               object: .none)
        configureUI()
    }

    @objc func audioLevelNotification(_ notification: Notification) {
        guard let audioLevel = notification.userInfo?[AudioMonitor.audioLevelKey] as? Float,
            let isLoud = notification.userInfo?[AudioMonitor.isLoudKey] as? Bool else {
                return
        }

        audioLevelSlider.setValue(audioLevel, animated: true)
        
        let isLoudString = isLoud ? NSLocalizedString(" is loud", comment: "is loud") : ""

        // quick hack. Apple recommends against concatenating localized strings
        volumeLabel.text = NSLocalizedString("Volume", comment: "Volume")
            + " " + String(Int(audioLevel)) + isLoudString
    }

    func configureUI() {
        let cornerRadius = CGFloat(8.0)
        volumeDecreaseButton.layer.cornerRadius = cornerRadius
        volumeIncreaseButton.layer.cornerRadius = cornerRadius
        volumeLabel.text = NSLocalizedString("Volume", comment: "Volume")

        audioLevelSlider.isUserInteractionEnabled = false
        // https://stackoverflow.com/questions/29731891/how-can-i-make-a-vertical-slider-in-swift
        audioLevelSlider.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
    }

    // MARK: - IBActions

    @IBAction func volumeDecreaseButtonTapped(_ sender: Any) {
        tvService.volumeDecrease()
    }

    @IBAction func volumeIncreaseButtonTapped(_ sender: Any) {
        tvService.volumeIncrease()
    }

}
