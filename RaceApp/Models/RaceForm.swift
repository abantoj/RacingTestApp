//
//  RaceForm.swift
//  RaceApp
//
//  Created by James Abanto on 15/7/2024.
//

import Foundation

struct RaceForm: Codable {
    let distance: Int
    let distanceType: DistanceType
    
    init(distance: Int, distanceType: DistanceType) {
        self.distance = distance
        self.distanceType = distanceType
    }
    
    enum CodingKeys: String, CodingKey {
        case distance
        case distanceType = "distance_type"
    }
    
    struct DistanceType: Codable {
        let id: String
        let name: String
        let shortName: String
        
        init(id: String, name: String, shortName: String) {
            self.id = id
            self.name = name
            self.shortName = shortName
        }
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case shortName = "short_name"
        }
    }
}
