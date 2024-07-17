//
//  RaceResponse.swift
//  RaceApp
//
//  Created by James Abanto on 15/7/2024.
//

import Foundation

struct RaceResponse: Codable {
    let status: Int
    let raceData: RaceData
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case raceData = "data"
        case message
    }
}
