//
//  SettingsView.swift
//  Remy
//
//  Created by Steve Baker on 7/3/21.
//

import SwiftUI

struct SettingsView: View {

    @EnvironmentObject var settingsModel: SettingsModel

    /// https://kristaps.me/blog/swiftui-modal-view/
    @Binding var isPresented: Bool

    var body: some View {
        Spacer()

        HStack {
            Text("host:")
            TextField("\(settingsModel.host)", text: $settingsModel.host)
                .keyboardType(.decimalPad)
        }

        Spacer()

        HStack {
            Text("port:")
            TextField("\(settingsModel.port)", text: $settingsModel.port)
                .keyboardType(.decimalPad)
        }

        Spacer()

        Button("Done", action: { isPresented = false })

        Spacer()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isPresented: .constant(true))
    }
}
