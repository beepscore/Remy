//
//  SettingsView.swift
//  Remy
//
//  Created by Steve Baker on 7/3/21.
//

import SwiftUI

struct SettingsView: View {

    var settingsModel = SettingsModel()

    /// https://kristaps.me/blog/swiftui-modal-view/
    @Binding var isPresented: Bool

    @State var hostTextFieldText: String {
        willSet {
            settingsModel.host = hostTextFieldText
        }
    }

    @State var portTextFieldText: String {
        willSet {
            settingsModel.port = portTextFieldText
        }
    }

    var body: some View {
        Spacer()

        HStack {
            Text("host:")
            TextField("\(settingsModel.defaultHost)", text: $hostTextFieldText)
                .keyboardType(.decimalPad)
        }

        Spacer()

        HStack {
            Text("port:")
            TextField("\(settingsModel.defaultPort)", text: $portTextFieldText)
                .keyboardType(.decimalPad)
        }

        Spacer()

        Button("Done", action: { isPresented = false })

        Spacer()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settingsModel: SettingsModel(),
                     isPresented: .constant(true),
                     hostTextFieldText: "",
                     portTextFieldText: "")
    }
}
