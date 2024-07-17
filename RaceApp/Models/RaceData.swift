//
//  RaceData.swift
//  RaceApp
//
//  Created by James Abanto on 15/7/2024.
//

import Foundation

struct RaceData: Codable {
    let raceSummaries: [RaceSummary]
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let raceSummariesDict = try container.decode([String:RaceSummary].self, forKey: .raceSummaries)
        var newRaceSummary: [RaceSummary] = []
        for (_, raceSummary) in raceSummariesDict {
            newRaceSummary.append(raceSummary)
        }
        
        self.raceSummaries = newRaceSummary
    }
    
    enum CodingKeys: String, CodingKey {
        case raceSummaries = "race_summaries"
    }
}
