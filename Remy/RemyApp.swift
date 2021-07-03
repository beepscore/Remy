//
//  RemyApp.swift
//  Remy
//
//  Created by Steve Baker on 7/3/21.
//

import SwiftUI

@main
struct RemyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                // adding this starts AudioMonitor running, which logs to Xcode console e.g.
                // levelTimerCallback sound level: -52.11492 decibel, isLoud: false...
                .environmentObject(AudioMonitor.shared)
                .preferredColorScheme(.dark)
        }
    }
}
