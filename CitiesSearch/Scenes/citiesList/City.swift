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
    let country: String?
    let coord: Coord?

    enum CodingKeys: String, CodingKey {
        case country, name
        case id = "_id"
        case coord
    }
}

struct Coord: Codable {
    let lon, lat: Double?
}
