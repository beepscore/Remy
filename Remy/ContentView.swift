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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
