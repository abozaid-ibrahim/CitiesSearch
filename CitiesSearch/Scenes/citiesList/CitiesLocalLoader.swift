//
//  AirlineDataSource.swift
//  SchipholApp
//
//  Created by abuzeid on 30.10.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation

protocol CitiesDataSource {
    func loadCities(compeletion: @escaping (Result<[City], NetworkError>) -> Void)
}

final class CitiesLocalLoader: CitiesDataSource {
    func loadCities(compeletion: @escaping (Result<[City], NetworkError>) -> Void) {
        do {
            let response = try Bundle.main.decode([City].self, from: "cities.json")
            compeletion(.success(response))
        } catch {
            compeletion(.failure(.noData))
        }
    }
}
