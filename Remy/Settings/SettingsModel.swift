//
//  SettingsModel.swift
//  Remy
//
//  Created by Steve Baker on 6/17/21.
//  Copyright © 2021 Beepscore LLC. All rights reserved.
//

import Foundation

class SettingsModel {

    let userDefaults = UserDefaults.standard
    let defaultsHostKey = "defaultsHostKey"
    let defaultsPortKey = "defaultsPortKey"
    let defaultHost = "10.0.0.179"

    // use object String instead of primitive Int so we can check if key exists
    // https://stackoverflow.com/questions/1964873/nsuserdefaults-how-to-tell-if-a-key-exists
    let defaultPort = "5000"

    let scheme = "http"

    var host: String {
        get {
            return userDefaults.string(forKey: defaultsHostKey) ?? defaultHost
        }
        set(newValue) {
            userDefaults.set(newValue, forKey: defaultsHostKey)
        }
    }

    var port: String {
        get {
            return userDefaults.string(forKey: defaultsPortKey) ?? defaultPort
        }
        set(newValue) {
            userDefaults.set(newValue, forKey: defaultsPortKey)
        }
    }

}
