//
//  ContentView.swift
//  Remy
//
//  Created by Steve Baker on 7/3/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            HStack {
                VStack {
                    Button("+", action: {})
                        .buttonStyle(BigButtonStyle())
                    Text("VOLUME")
                    Button("-", action: {})
                        .buttonStyle(BigButtonStyle())
                }

                VStack {
                    Button("+", action: {})
                        .buttonStyle(BigButtonStyle())
                    Text("VOICE")
                    Button("-", action: {})
                        .buttonStyle(BigButtonStyle())
                }

                VStack {
                    Button("+", action: {})
                        .buttonStyle(BigButtonStyle())
                    Text("BASS")
                    Button("-", action: {})
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
