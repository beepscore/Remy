//
//  Logger.swift
//  Remy
//
//  Created by Steve Baker on 7/7/19.
//  Copyright © 2019 Beepscore LLC. All rights reserved.
//

import UIKit
import os.log

/// https://stackoverflow.com/questions/25951195/swift-print-vs-println-vs-nslog
class Logger {

    static let shared = Logger()

    let log: OSLog

    private init() {
        log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "remy")
    }

}
