//
//  ContentView.swift
//  Remy
//
//  Created by Steve Baker on 7/3/21.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var tvService = TVService(timeoutSeconds: 10.0)

    var body: some View {
        VStack {

            Text(tvService.statusText)
                .font(.title2)
                .foregroundColor(.accentColor)

            Spacer()

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

            Spacer()

            PlusMinusButtonsView(tvService: tvService)

            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
