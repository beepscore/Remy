//
//  PlusMinusButtonsView.swift
//  Remy
//
//  Created by Steve Baker on 7/3/21.
//

import SwiftUI

struct PlusMinusButtonsView: View {

    var tvService: TVService

    var body: some View {
        HStack {
            VStack {
                Button("+", action: {
                    tvService.volumeIncrease() { res in
                        tvService.updateStatusText(result: res)
                    }
                })
                .buttonStyle(BigButtonStyle())
                Text("VOLUME")
                    .foregroundColor(.accentColor)
                Button("-", action: {
                    tvService.volumeDecrease() { res in
                        tvService.updateStatusText(result: res)
                    }
                })
                .buttonStyle(BigButtonStyle())
            }

            VStack {
                Button("+", action: {
                    tvService.voiceIncrease() { res in
                        tvService.updateStatusText(result: res)
                    }
                })
                .buttonStyle(BigButtonStyle())
                Text("VOICE")
                    .foregroundColor(.accentColor)
                Button("-", action: {
                    tvService.voiceDecrease() { res in
                        tvService.updateStatusText(result: res)
                    }
                })
                .buttonStyle(BigButtonStyle())
            }

            VStack {
                Button("+", action: {
                    tvService.bassIncrease() { res in
                        tvService.updateStatusText(result: res)
                    }
                })
                .buttonStyle(BigButtonStyle())
                Text("BASS")
                    .foregroundColor(.accentColor)
                Button("-", action: {
                    tvService.bassDecrease() { res in
                        tvService.updateStatusText(result: res)
                    }
                })
                .buttonStyle(BigButtonStyle())
            }
        }
        .padding()
    }
}

struct PlusMinusButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        PlusMinusButtonsView(tvService: TVService(timeoutSeconds: 10.0))
    }
}
