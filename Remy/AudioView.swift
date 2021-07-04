//
//  AudioView.swift
//  Remy
//
//  Created by Steve Baker on 7/3/21.
//

import SwiftUI

struct AudioView: View {
    @EnvironmentObject var audioMonitor: AudioMonitor

    // levelMaxDb == 0 and levelMinDb is < 0, so use levelMinDb/2
    @State var audioLimit = AudioMonitor.levelMinDb / 2

    var body: some View {
        VStack {
            VStack() {
                Text("audio level dB: \(Int(audioMonitor.level))")
                Slider(value: $audioMonitor.level, in: AudioMonitor.levelMinDb...AudioMonitor.levelMaxDb)
                    // allowsHitTesting false disables user interaction
                    .allowsHitTesting(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
            }

            VStack() {
                Text("limit dB: \(Int(audioLimit))")
                Slider(value: $audioLimit, in: AudioMonitor.levelMinDb...AudioMonitor.levelMaxDb)
            }
        }
    }
}

struct AudioView_Previews: PreviewProvider {
    static var previews: some View {
        AudioView()
    }
}
