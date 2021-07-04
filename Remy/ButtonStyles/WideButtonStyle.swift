//
//  WideButtonStyle.swift
//  Remy
//
//  Created by Steve Baker on 7/3/21.
//

import SwiftUI

struct WideButtonStyle: ButtonStyle {

    /// https://serialcoder.dev/text-tutorials/swiftui/creating-custom-button-styles-in-swiftui/
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        .font(.headline)
        .frame(minWidth: 30,
               idealWidth: 80,
               maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
               minHeight: 20,
               idealHeight: 20,
               maxHeight: 40,
               alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color(.lightGray))
        .cornerRadius(8)
    }
}
