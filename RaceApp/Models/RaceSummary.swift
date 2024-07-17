//
//  RaceSummary.swift
//  RaceApp
//
//  Created by James Abanto on 15/7/2024.
//

import Foundation

struct RaceSummary: Codable, Identifiable, Equatable {
    let id: String
    let advertisedStart: Date
    let categoryType: RaceCategoryType
    let meetingName: String
    let raceNumber: Int
    let raceForm: RaceForm
    
    init(id: String,
         advertisedStart: Date,
         categoryType: RaceCategoryType,
         meetingName: String,
         raceNumber: Int,
         raceForm: RaceForm) {
        self.id = id
        self.advertisedStart = advertisedStart
        self.categoryType = categoryType
        self.meetingName = meetingName
        self.raceNumber = raceNumber
        self.raceForm = raceForm
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        let advertisedStartObject = try container.decode(AdvertisedStart.self, forKey: .advertisedStart)
        self.advertisedStart = Date(timeIntervalSince1970: TimeInterval(advertisedStartObject.seconds))
        
        self.categoryType = try container.decode(RaceCategoryType.self, forKey: .categoryType)
        self.meetingName = try container.decode(String.self, forKey: .meetingName)
        self.raceForm = try container.decode(RaceForm.self, forKey: .raceForm)
        self.id = try container.decode(String.self, forKey: .id)
        self.raceNumber = try container.decode(Int.self, forKey: .raceNumber)
    }
    
    enum RaceCategoryType: String, Codable {
        case greyhoundRacing = "9daef0d7-bf3c-4f50-921d-8e818c60fe61"
        case harnessRacing = "161d9be2-e909-4326-8c2c-35ed71fb460b"
        case horseRacing = "4a2788f8-e825-4d36-9894-efd4baf1cfae"
    }

    enum CodingKeys: String, CodingKey {
        case advertisedStart = "advertised_start"
        case categoryType = "category_id"
        case meetingName = "meeting_name"
        case raceForm = "race_form"
        case id = "race_id"
        case raceNumber = "race_number"
    }
}

extension RaceSummary {
    static func == (lhs: RaceSummary, rhs: RaceSummary) -> Bool {
        lhs.id == rhs.id && lhs.advertisedStart == rhs.advertisedStart
    }
}
