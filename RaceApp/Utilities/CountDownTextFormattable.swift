//
//  CountDownTextFormattable.swift
//  RaceApp
//
//  Created by James Abanto on 17/7/2024.
//

import Foundation

protocol CountDownTextFormattable {
    /**
    Retrieves the count down time for the corresponding time interval
     - Parameters:
        - timeRemaining: we expect an Int type here that we get from the conversion of Time interval between advertised start and current date
     - Returns:
            A `String` that is formatted to be displayed in our count down text
     */
    func formatCountdownTime(timeRemaining: Int) -> String
}

extension CountDownTextFormattable {
    func formatCountdownTime(timeRemaining: Int) -> String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        
        if minutes >= 5 {
            // If 5 minutes or more, show only minutes
            return "\(minutes)m"
        } else if minutes > 0 {
            // If less than 5 minutes, show minutes and seconds
            return "\(minutes)m \(seconds)s"
        } else {
            // If less than a minute, show only seconds
            return "\(seconds)s"
        }
    }
}
