//
//  ContentView.swift
//  RaceApp
//
//  Created by James Abanto on 15/7/2024.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject
    var viewModel = RaceListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                RaceFilterView(filters: $viewModel.raceCategoryFilters)
                List(viewModel.filteredRaceSummaries) { raceSummary in
                    RaceListRowView(rowModel: viewModel.buildRowModel(raceSummary), 
                                 expiredRaceCompletion: {
                        viewModel.removeExpiredRaces()
                    })
                }.listStyle(.plain)
                    .onAppear {
                    Task {
                        try await viewModel.onAppear()
                    }
                }
                .padding(.horizontal, -8)
            }.navigationBarTitle("Next Races")
        }
    }
}

#Preview {
    ContentView()
}
