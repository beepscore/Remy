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
                Button("+", action: {})
                    .buttonStyle(BigButtonStyle())

                Button("+", action: {})
                    .buttonStyle(BigButtonStyle())

                Button("+", action: {})
                    .buttonStyle(BigButtonStyle())

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
