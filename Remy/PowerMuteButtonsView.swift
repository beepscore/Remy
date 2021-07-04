//
//  PowerMuteButtonsView.swift
//  Remy
//
//  Created by Steve Baker on 7/3/21.
//

import SwiftUI

struct PowerMuteButtonsView: View {
    var tvService: TVService

    var body: some View {
        HStack {
            Button("POWER", action: {
                tvService.power() { res in
                    tvService.updateStatusText(result: res)
                }
            })
            .buttonStyle(WideButtonStyle())

            Button("MUTE", action: {
                tvService.mute() { res in
                    tvService.updateStatusText(result: res)
                }
            })
            .buttonStyle(WideButtonStyle())
        }
    }
}

struct PowerMuteButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        PowerMuteButtonsView(tvService: TVService(timeoutSeconds: 10.0))
    }
}
