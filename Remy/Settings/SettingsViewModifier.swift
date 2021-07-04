//
//  SettingsViewModifier.swift
//  Remy
//
//  Created by Steve Baker on 7/4/21.
//

import SwiftUI

/// https://useyourloaf.com/blog/swiftui-custom-view-modifiers/
struct SettingsViewModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.title)
            .padding()
    }
}
