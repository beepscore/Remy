//
//  RemyApp.swift
//  Remy
//
//  Created by Steve Baker on 7/3/21.
//

import SwiftUI
import OSLog

@main
struct RemyApp: App {

    let logger = Logger(subsystem: SettingsModel.loggerSubsytem, category: "RemyApp")

    /// https://developer.apple.com/documentation/swiftui/scenephase
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView()
                // adding this starts AudioMonitor running, which logs to Xcode console e.g.
                // levelTimerCallback sound level: -52.11492 decibel, isLoud: false...
                .environmentObject(AudioMonitor.shared)
                .environmentObject(SettingsModel.shared)
                .preferredColorScheme(.dark)
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {

            case .background:
                logger.debug("phase: .background")
            case .inactive:
                logger.debug("phase: .inactive")
            case .active:
                logger.debug("phase: .active")
            @unknown default:
                logger.debug("phase: default")
            }
        }
    }
}
