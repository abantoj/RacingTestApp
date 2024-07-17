//
//  RaceService.swift
//  RaceApp
//
//  Created by James Abanto on 15/7/2024.
//

import Foundation

protocol RaceServiceProtocol {
    func getNextRaceSummaries(withCount count: Int) async throws -> [RaceSummary]
}

struct RaceService: RaceServiceProtocol, APIManageable {
    func getNextRaceSummaries(withCount count: Int) async throws -> [RaceSummary] {
        let url = URL(string: "https://api.neds.com.au/rest/v1/racing/?method=nextraces&count=\(count)")
        let raceResponse: RaceResponse = try await request(url: url)
        return raceResponse.raceData.raceSummaries
    }
}

