//
//  City.swift
//  CitiesSearch
//
//  Created by abuzeid on 03.11.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation
struct City: Decodable {
    let name: String
    let id: Int
    let country: String
    let coord: Coordinate?

    enum CodingKeys: String, CodingKey {
        case country, name
        case id = "_id"
        case coord
    }
}

struct Coordinate: Codable {
    let lon, lat: Double
}

extension City {
    var address: String { "\(name), \(country)" }
    var location: String? {
        guard let lat = coord?.lat,
            let lon = coord?.lon else { return .none }
        return "\(lat), \(lon)"
    }
}
