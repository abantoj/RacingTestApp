//
//  RaceListViewModel.swift
//  RaceApp
//
//  Created by James Abanto on 16/7/2024.
//

import Foundation
import Combine

final class RaceListViewModel: ObservableObject {
    
    init(raceService: RaceServiceProtocol = RaceService(),
         displayModelBuilder: RaceSummaryListRowBuildable = RaceSummaryDisplayModelBuilder()) {
        self.raceService = raceService
        self.displayModelBuilder = displayModelBuilder
    }
    private var cancellables = Set<AnyCancellable>()
    private let raceService: RaceServiceProtocol
    private let displayModelBuilder: RaceSummaryListRowBuildable
    @Published private(set) var raceSummaries: [RaceSummary] = []
    @Published var raceCategoryFilters: [RaceFilterModel] = []
    
    /// this gets updated whenever the raceSummaries or raceCategoryFilters arrays get changed
    var filteredRaceSummaries: [RaceSummary] {
        raceSummaries.filter { raceSummary in
            raceCategoryFilters.contains { filterModel in
                return filterModel.isChecked && filterModel.categoryType == raceSummary.categoryType
            }
        }.prefix(5).map { $0 }
    }
    
    /// we call this method when the Race List View appears
    /// make an api call to update the list of the next races
    @MainActor
    func onAppear() async throws {
        try await refreshRaces()
        resetFilters()
        observeFilterChanges()
    }
    
    /// this method makes the api call to get the next races,
    /// by default, we maximize to get the next 50 races
    @MainActor
    func refreshRaces() async throws {
        let sortedRaces = try await raceService.getNextRaceSummaries(withCount: 50).sorted { $0.advertisedStart < $1.advertisedStart }
        raceSummaries = sortedRaces
    }
    
    /// we call this method whenever we get notified by the row view that the race is past one minute
    @MainActor
    func removeExpiredRaces(fromDate currentDate: Date = Date.now) {
        /// filter out logic to remove expired races
        raceSummaries = raceSummaries.filter { raceSummary in
            let expiryTime = raceSummary.advertisedStart.addingTimeInterval(60)
            return expiryTime > currentDate
        }
        checkForEnoughRaceSummaries()
    }
    
    func buildRowModel(_ raceSummary: RaceSummary) -> RaceListRowModel {
        displayModelBuilder.buildRaceRowModel(raceSummary)
    }
    
    /// we call this method every time we get notified that a race has expired
    /// or the filtering of category types gets changed
    private func checkForEnoughRaceSummaries() {
        if filteredRaceSummaries.count < 5 {
            Task {
                try await refreshRaces()
            }
        }
    }
    
    /// reset the filters on appear or whenever all the filter gets unticked
    private func resetFilters() {
        raceCategoryFilters = [RaceFilterModel(categoryType: .greyhoundRacing, isChecked: true),
                               RaceFilterModel(categoryType: .harnessRacing, isChecked: true),
                               RaceFilterModel(categoryType: .horseRacing, isChecked: true)]
    }
    
    /// here is a setup to listen to the filter changes
    private func observeFilterChanges() {
        $raceCategoryFilters.receive(on: DispatchQueue.main).sink { [weak self] categoryFilters in
            guard let self else { return }
            if !categoryFilters.contains(where: { $0.isChecked == true }) {
                self.resetFilters()
            }
            self.checkForEnoughRaceSummaries()
        }.store(in: &cancellables)
    }
}
