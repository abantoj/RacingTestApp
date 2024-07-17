//
//  CheckBoxView.swift
//  RaceApp
//
//  Created by James Abanto on 17/7/2024.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var isChecked: Bool
    let imageName: String
    var body: some View {
        Toggle(isOn: $isChecked) {
            Image(imageName)
                .resizable()
                .frame(width: 30, height: 36)
        }
        .frame(width: 50)
        .toggleStyle(CheckboxToggleStyle())
        .padding()
    }
}

struct CheckboxToggleStyle: ToggleStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    HStack {
      configuration.label
      Spacer()
      Image(systemName: configuration.isOn ? "checkmark.square" : "square")
        .resizable()
        .frame(width: 18, height: 18)
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
  }
}
