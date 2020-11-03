//
//  AirportsViewModel.swift
//  SchipholApp
//
//  Created by abuzeid on 30.10.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation

protocol CitiesViewModelType {
    var citiesList: Observable<[City]> { get }
    var error: Observable<String?> { get }
    var isLoading: Observable<Bool> { get }
    func search(for city: String)
}

final class CitiesViewModel: CitiesViewModelType {
    private let citiesLoader: CitiesDataSource
    let citiesList: Observable<[City]> = .init([])
    let isLoading: Observable<Bool> = .init(false)
    let error: Observable<String?> = .init(nil)

    init(citiesLoader: CitiesDataSource = CitiesLocalLoader()) {
        self.citiesLoader = citiesLoader
    }

    func search(for city: String) {
        isLoading.next(true)
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.citiesLoader.loadCities { data in
                switch data {
                case let .success(response):
                    self.citiesList.next(response)
                case let .failure(error):
                    self.error.next(error.localizedDescription)
                }
                self.isLoading.next(false)
            }
        }
    }
}
