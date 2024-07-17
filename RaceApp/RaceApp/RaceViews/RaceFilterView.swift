//
//  RaceFilterView.swift
//  RaceApp
//
//  Created by James Abanto on 17/7/2024.
//

import SwiftUI

struct RaceFilterView: View {
    @Binding var filters: [RaceFilterModel]
    var body: some View {
        HStack(spacing: -20) {
            ForEach(filters.indices, id: \.self) { index in
                CheckBoxView(isChecked: $filters[index].isChecked, 
                             imageName: filters[index].imageName)
            }
            Spacer()
        }
    }
}

#Preview {
    RaceFilterView(filters: .constant([RaceFilterModel(categoryType: .greyhoundRacing, isChecked: true)]))
}
