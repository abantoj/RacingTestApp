//
//  RaceListRowView.swift
//  RaceApp
//
//  Created by James Abanto on 15/7/2024.
//

import SwiftUI

struct RaceListRowView: View {
    let rowModel: RaceListRowModel
    @State private var timeRemaining: Int
    let expiredRaceCompletion: (() -> Void)
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(rowModel: RaceListRowModel, expiredRaceCompletion: @escaping (() -> Void)) {
        self.rowModel = rowModel
        self.expiredRaceCompletion = expiredRaceCompletion
        _timeRemaining = State(initialValue: Int(rowModel.advertisedStart.timeIntervalSinceNow))
    }
    
    var body: some View {
        HStack {
            Image(rowModel.imageName)
                .resizable()
                .frame(width: 40, height: 40)
            VStack(alignment: .leading) {
                Text(rowModel.raceTitleText)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                Text(rowModel.distanceText)
                    .font(.caption2)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            Spacer()
            Text(rowModel.formatCountdownTime(timeRemaining: timeRemaining))
                .onReceive(timer) { _ in
                    /// on receive of timer updates, we will update the time interval between advertised start and the current time
                    let timeInterval = Int(rowModel.advertisedStart.timeIntervalSinceNow)
                    /// check if the advertised start is past one minute
                    if timeInterval <= -60 {
                        /// cancel the timer and fire the completion handler to notify the parent view to filter out the expired race row
                        timer.upstream.connect().cancel()
                        expiredRaceCompletion()
                    } else {
                        /// set the time remaining to current time interval
                        timeRemaining = timeInterval
                    }
                }
            Image(systemName: "chevron.right")
                .font(.subheadline)
        }
    }
}
