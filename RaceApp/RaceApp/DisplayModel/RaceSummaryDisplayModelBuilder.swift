//
//  RaceSummaryDisplayModelBuilder.swift
//  RaceApp
//
//  Created by James Abanto on 15/7/2024.
//

import Foundation

protocol RaceSummaryListRowBuildable {
    /**
    Retrieves the row model for the corresponding race summary object
     - Parameters:
        - raceSummary: `RaceSummary` - the race summary that we want to build `RaceListRowModel` out of
     - Returns:
            A `RaceListRowModel`
     */
    func buildRaceRowModel(_ raceSummary: RaceSummary) -> RaceListRowModel
}

struct RaceSummaryDisplayModelBuilder: RaceSummaryListRowBuildable, CategoryTypeImageNameProvidable {
    func buildRaceRowModel(_ raceSummary: RaceSummary) -> RaceListRowModel {
        let model = RaceListRowModel(id: raceSummary.id, 
                                     imageName: getImageName(forCategory: raceSummary.categoryType),
                                     categoryType: raceSummary.categoryType,
                                     advertisedStart: raceSummary.advertisedStart,
                                     raceTitleText: "\(raceSummary.meetingName) R\(raceSummary.raceNumber)",
                                     distanceText: "\(raceSummary.raceForm.distance)\(raceSummary.raceForm.distanceType.shortName)")
        return model
    }
}
