//
//  ContentView.swift
//  Remy
//
//  Created by Steve Baker on 7/3/21.
//

import SwiftUI

struct ContentView: View {

    let tvService = TVService(timeoutSeconds: 10.0)

    @State var statusText = ""

    func updateStatusText(result: Result<TVResponse, Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let tvResponse):
                self.statusText = tvResponse.message
            case .failure(let error):
                // error may be type Error or any subclass e.g. DecodingError or TVServiceError
                // error just needs to have a localizedDescription.
                // e.g.
                // "unsupported URL"
                // "Could not connect to the server."
                // "The request timed out."
                // "404 Not Found"
                self.statusText = error.localizedDescription
            }
        }
    }

    var body: some View {
        VStack {

            Text(statusText)
                .font(.title2)

            HStack {
                VStack {
                    Button("+", action: {
                        tvService.volumeIncrease() { res in
                            self.updateStatusText(result: res)
                        }
                    })
                    .buttonStyle(BigButtonStyle())
                    Text("VOLUME")
                    Button("-", action: {
                        tvService.volumeDecrease() { res in
                            self.updateStatusText(result: res)
                        }
                    })
                    .buttonStyle(BigButtonStyle())
                }

                VStack {
                    Button("+", action: {
                        tvService.voiceIncrease() { res in
                            self.updateStatusText(result: res)
                        }
                    })
                    .buttonStyle(BigButtonStyle())
                    Text("VOICE")
                    Button("-", action: {
                        tvService.voiceDecrease() { res in
                            self.updateStatusText(result: res)
                        }
                    })
                    .buttonStyle(BigButtonStyle())
                }

                VStack {
                    Button("+", action: {
                        tvService.bassIncrease() { res in
                            self.updateStatusText(result: res)
                        }
                    })
                    .buttonStyle(BigButtonStyle())
                    Text("BASS")
                    Button("-", action: {
                        tvService.bassDecrease() { res in
                            self.updateStatusText(result: res)
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
