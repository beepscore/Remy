//
//  BigButtonStyle.swift
//  Remy
//
//  Created by Steve Baker on 7/3/21.
//

import SwiftUI

struct BigButtonStyle: ButtonStyle {

    /// https://serialcoder.dev/text-tutorials/swiftui/creating-custom-button-styles-in-swiftui/
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        .font(.largeTitle)
        .frame(minWidth: 30,
               idealWidth: 80,
               maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
               minHeight: 30,
               idealHeight: 60,
               maxHeight: 60,
               alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color(.lightGray))
        .cornerRadius(16)
    }
}
