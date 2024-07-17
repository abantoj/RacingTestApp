//
//  RaceFilterModel.swift
//  RaceApp
//
//  Created by James Abanto on 17/7/2024.
//

import Foundation

struct RaceFilterModel: CategoryTypeImageNameProvidable, Equatable {
    let categoryType: RaceSummary.RaceCategoryType
    var isChecked: Bool
    
    var imageName: String {
        getImageName(forCategory: categoryType)
    }
    
    init(categoryType: RaceSummary.RaceCategoryType, isChecked: Bool) {
        self.categoryType = categoryType
        self.isChecked = isChecked
    }
}
