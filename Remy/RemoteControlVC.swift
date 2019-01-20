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

        let isLoudString = isLoud ? NSLocalizedString(" is loud", comment: "is loud") : ""

        // quick hack. Apple recommends against concatenating localized strings
        volumeLabel.text = NSLocalizedString("Volume", comment: "Volume")
            + " " + String(audioLevel) + isLoudString
    }

    func configureUI() {
        volumeLabel.text = NSLocalizedString("Volume", comment: "Volume")
    }

    // MARK: - IBActions

    @IBAction func volumeDecreaseButtonTapped(_ sender: Any) {
        tvService.volumeDecrease()
    }

    @IBAction func volumeIncreaseButtonTapped(_ sender: Any) {
        tvService.volumeIncrease()
    }

}
