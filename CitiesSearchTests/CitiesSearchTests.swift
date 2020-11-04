//
//  CitiesSearchTests.swift
//  CitiesSearchTests
//
//  Created by abuzeid on 03.11.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

@testable import CitiesSearch
import XCTest

enum SearchIndex: Int {
    case zero
    case one
    case two
    case three
    case none
}

final class CitiesSearchTests: XCTestCase {
    func testSearchAndSorting() throws {
        let viewModel = CitiesViewModel(citiesLoader: CitiesLoaderMocking())
        viewModel.search(for: "C")
        let exp = expectation(description: "searchText")
        var searchIndex: SearchIndex = .zero
        viewModel.citiesList.subscribe(on: .global(), {
            switch searchIndex {
            case .zero:
                XCTAssert($0.isEmpty)
                searchIndex = .one
            case .one:
                XCTAssertEqual($0.count, 4)
                searchIndex = .two
                viewModel.search(for: "ber")
            case .two:
                XCTAssertEqual($0.count, 3)
                XCTAssertEqual($0.first, CitiesLoaderMocking.data[6])
                XCTAssertEqual($0.last, CitiesLoaderMocking.data[5])
                searchIndex = .three
                viewModel.search(for: "Timore, UK")
            case .three:
                XCTAssertEqual($0.count, 2)
                viewModel.search(for: "M")
                searchIndex = .none
            default:
                exp.fulfill()
            }
        })
        wait(for: [exp], timeout: 0.01)
    }
}

final class CitiesLoaderMocking: CitiesDataSource {
    static let data = [
        City(name: "Cairo", id: 0, country: "Eg", coord: .init(lon: 0, lat: 0)),
        City(name: "cair", id: 1, country: "Eg", coord: .init(lon: 0, lat: 0)),
        City(name: "Caar", id: 2, country: "Eg", coord: .init(lon: 0, lat: 0)),
        City(name: "Cad", id: 3, country: "Eg", coord: .init(lon: 0, lat: 0)),
        City(name: "Berlin", id: 4, country: "Eg", coord: .init(lon: 0, lat: 0)),
        City(name: "Berlina", id: 5, country: "Eg", coord: .init(lon: 0, lat: 0)),
        City(name: "Berlin", id: 6, country: "DE", coord: .init(lon: 0, lat: 0)),
        City(name: "Beer", id: 7, country: "Eg", coord: .init(lon: 0, lat: 0)),
        City(name: "Timore", id: 6, country: "UK", coord: .init(lon: 0, lat: 0)),
        City(name: "Timore", id: 7, country: "UK", coord: .init(lon: 1, lat: 1))]
    func loadCities(compeletion: @escaping (Result<[City], NetworkError>) -> Void) {
        compeletion(.success(CitiesLoaderMocking.data))
    }
}
