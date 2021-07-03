//
//  ContentView.swift
//  Remy
//
//  Created by Steve Baker on 7/3/21.
//

import SwiftUI

struct ContentView: View {

    let tvService = TVService(timeoutSeconds: 10.0)

    var body: some View {
        ZStack {
            HStack {
                VStack {
                    Button("+", action: {
                        tvService.volumeIncrease() { res in
                            //self.updateStatusLabel(result: res)
                        }
                    })
                    .buttonStyle(BigButtonStyle())
                    Text("VOLUME")
                    Button("-", action: {
                        tvService.volumeDecrease() { res in
                            //self.updateStatusLabel(result: res)
                        }
                    })
                    .buttonStyle(BigButtonStyle())
                }

                VStack {
                    Button("+", action: {
                        tvService.voiceIncrease() { res in
                            //self.updateStatusLabel(result: res)
                        }
                    })
                    .buttonStyle(BigButtonStyle())
                    Text("VOICE")
                    Button("-", action: {
                        tvService.voiceDecrease() { res in
                            //self.updateStatusLabel(result: res)
                        }
                    })
                    .buttonStyle(BigButtonStyle())
                }

                VStack {
                    Button("+", action: {
                        tvService.bassIncrease() { res in
                            //self.updateStatusLabel(result: res)
                        }
                    })
                    .buttonStyle(BigButtonStyle())
                    Text("BASS")
                    Button("-", action: {
                        tvService.bassDecrease() { res in
                            //self.updateStatusLabel(result: res)
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
