//
//  ContentView.swift
//  Remy
//
//  Created by Steve Baker on 7/3/21.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var tvService = TVService(timeoutSeconds: 10.0)

    @State var showSettingsView = false

    var body: some View {
        VStack {

            AudioView()

            Spacer()

            Text(tvService.statusText)
                .font(.title2)
                .foregroundColor(.accentColor)

            Spacer()

            PowerMuteButtonsView(tvService: tvService)

            Spacer()

            PlusMinusButtonsView(tvService: tvService)

            Spacer()

            HStack {
                Spacer()
                Button("Settings", action: {
                    showSettingsView = true
                })
            }
        }
        .padding()
        .sheet(isPresented: $showSettingsView) {
            SettingsView(isPresented: $showSettingsView,
                         hostTextFieldText: "",
                         portTextFieldText: "")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
