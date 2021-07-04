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

            AudioView()

            Text(tvService.statusText)
                .font(.title2)
                .foregroundColor(.accentColor)

            Spacer()

            PowerMuteButtonsView(tvService: tvService)

            Spacer()

            PlusMinusButtonsView(tvService: tvService)

            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
