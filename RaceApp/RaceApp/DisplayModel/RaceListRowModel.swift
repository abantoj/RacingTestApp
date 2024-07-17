//
//  RaceListRowModel.swift
//  RaceApp
//
//  Created by James Abanto on 17/7/2024.
//

import Foundation

struct RaceListRowModel: Identifiable, CountDownTextFormattable {
    let id: String
    let imageName: String
    let categoryType: RaceSummary.RaceCategoryType
    let advertisedStart: Date
    let raceTitleText: String
    let distanceText: String
}
