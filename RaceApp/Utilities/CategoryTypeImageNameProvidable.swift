//
//  CategoryTypeImageNameProvidable.swift
//  RaceApp
//
//  Created by James Abanto on 17/7/2024.
//

import Foundation

protocol CategoryTypeImageNameProvidable {
    /**
    Retrieves the image name for the corresponding category type
     Current category type that are covered in this method:
        - greyhoundRacing, harnessRacing, horseRacing
     - Parameters:
        - category: `RaceSummary.RaceCategoryType` - the category that we want to grab the image name of
            
     - Returns:
            A `String`(image name) that matches with the given category type
     */
    func getImageName(forCategory category: RaceSummary.RaceCategoryType) -> String
}

extension CategoryTypeImageNameProvidable {
    func getImageName(forCategory category: RaceSummary.RaceCategoryType) -> String {
        switch category {
        case .greyhoundRacing:
            "greyhound"
        case .harnessRacing:
            "harness"
        case .horseRacing:
            "horse"
        }
    }
}
