//
//  RaceListViewModelTest.swift
//  RaceAppTests
//
//  Created by James Abanto on 17/7/2024.
//

import XCTest
@testable import RaceApp

final class RaceListViewModelTest: XCTestCase {
    func testBuildRowModel() {
        let mockViewModel = RaceListViewModel(raceService: MockRaceService())
        let raceSummary = mockRaceSummary(id: "test_id",
                                          advertisedStart: Date(timeIntervalSince1970: 1_640_141_851),
                                          categoryType: .greyhoundRacing,
                                          meetingName: "Test MeetingName",
                                          raceNumber: 1,
                                          distance: 300)
        let rowModel = mockViewModel.buildRowModel(raceSummary)
        XCTAssertEqual(rowModel.advertisedStart, Date(timeIntervalSince1970: 1_640_141_851))
        XCTAssertEqual(rowModel.imageName, "greyhound")
        XCTAssertEqual(rowModel.distanceText, "300m")
        XCTAssertEqual(rowModel.raceTitleText, "Test MeetingName R1")
    }
    
    func testRaceCategoryFiltersOnAppear() async throws {
        let mockViewModel = RaceListViewModel(raceService: MockRaceService())
        XCTAssertEqual(mockViewModel.raceCategoryFilters, [])
        try await mockViewModel.onAppear()
        XCTAssertEqual(mockViewModel.raceCategoryFilters.count, 3)
    }
    
    func testRaceSummariesUpdatedOnAppear() async throws {
        let raceSummary = mockRaceSummary(id: "test_id",
                                          advertisedStart: Date(timeIntervalSince1970: 1_640_141_851),
                                          categoryType: .greyhoundRacing,
                                          meetingName: "Test MeetingName",
                                          raceNumber: 1,
                                          distance: 300)
        let mockViewModel = RaceListViewModel(raceService: MockRaceService(raceSummaries: [raceSummary]))
        XCTAssertEqual(mockViewModel.raceSummaries, [])
        try await mockViewModel.onAppear()
        XCTAssertEqual(mockViewModel.raceSummaries.count, 1)
        XCTAssertEqual(mockViewModel.raceSummaries.first?.id, "test_id")
        XCTAssertEqual(mockViewModel.raceSummaries.first?.advertisedStart, Date(timeIntervalSince1970: 1_640_141_851))
    }
    
    func testRaceSummariesUpdatedWhenExpired() async throws {
        let date = Date(timeIntervalSince1970: 1_640_141_851)
        let raceSummary = mockRaceSummary(id: "test_id",
                                          advertisedStart: date,
                                          categoryType: .greyhoundRacing,
                                          meetingName: "Test MeetingName",
                                          raceNumber: 1,
                                          distance: 300)
        let mockViewModel = RaceListViewModel(raceService: MockRaceService(raceSummaries: [raceSummary]))
        XCTAssertEqual(mockViewModel.raceSummaries, [])
        try await mockViewModel.onAppear()
        XCTAssertEqual(mockViewModel.raceSummaries.count, 1)
        
        let currentDate = date.addingTimeInterval(61)
        await mockViewModel.removeExpiredRaces(fromDate: currentDate)
        XCTAssertEqual(mockViewModel.raceSummaries, [])
    }
    
    func mockRaceSummary(id: String,
                         advertisedStart: Date,
                         categoryType: RaceSummary.RaceCategoryType,
                         meetingName: String,
                         raceNumber: Int,
                         distance: Int) -> RaceSummary {
        RaceSummary(id: id,
                    advertisedStart: advertisedStart,
                    categoryType: categoryType,
                    meetingName: meetingName,
                    raceNumber: raceNumber,
                    raceForm: .init(distance: distance,
                                    distanceType: .init(id: "123",
                                                        name: "Metres",
                                                        shortName: "m")))
    }
}

private struct MockRaceService: RaceServiceProtocol {
    let raceSummaries: [RaceSummary]
    
    init(raceSummaries: [RaceSummary] = []) {
        self.raceSummaries = raceSummaries
    }
    
    func getNextRaceSummaries(withCount count: Int) async throws -> [RaceApp.RaceSummary] {
        raceSummaries
    }
}
