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
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
}

final class CitiesSearchTests: XCTestCase {
    func testExample() throws {
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
            default:
                XCTAssertEqual($0.count, 3)
                exp.fulfill()
            }
        })
        waitForExpectations(timeout: 0.2, handler: nil)
    }

    func testPerformancePrebaringData() throws {
        measure {
            let viewModel = CitiesViewModel()
            viewModel.search(for: "A")
            let exp = expectation(description: "searchText")
            var searchIndex: SearchIndex = .zero
            viewModel.citiesList.subscribe(on: .global(), {
                if searchIndex == .zero {
                    XCTAssert($0.isEmpty)
                    searchIndex = .one
                } else if searchIndex == .one {
                    exp.fulfill()
                }
            })
            wait(for: [exp], timeout: 6.30)
        }
    }

    func testPerformanceSearchTenTimes() throws {
        let exp = expectation(description: "WaitLoadingData")
        let viewModel = CitiesViewModel()
        measure {
            viewModel.search(for: "A")
            var searchIndex: SearchIndex = .zero
            viewModel.citiesList.subscribe(on: .global(), { _ in
                switch searchIndex {
                case .zero:
                    searchIndex = .one
                    viewModel.search(for: "B")
                case .one:
                    searchIndex = .two
                    viewModel.search(for: "C")
                case .two:
                    searchIndex = .three
                    viewModel.search(for: "di")
                case .three:
                    searchIndex = .four
                    viewModel.search(for: "eee")
                case .four:
                    searchIndex = .five
                    viewModel.search(for: "face")
                case .five:
                    searchIndex = .six
                    viewModel.search(for: "g")
                case .six:
                    searchIndex = .seven
                    viewModel.search(for: "ha")
                case .seven:
                    searchIndex = .eight
                    viewModel.search(for: "cooloo")
                case .eight:
                    searchIndex = .nine
                    viewModel.search(for: "k")
                case .nine:
                    searchIndex = .ten
                    viewModel.search(for: "ze")
                case .ten:
                    exp.fulfill()
                }
            })
        }
        wait(for: [exp], timeout: 6.40)
    }
}

final class CitiesLoaderMocking: CitiesDataSource {
    func loadCities(compeletion: @escaping (Result<[City], NetworkError>) -> Void) {
        let cairo = City(name: "Cairo", id: 1, country: "Eg", coord: nil)
        let cair = City(name: "cair", id: 2, country: "Eg", coord: nil)
        let caar = City(name: "Caar", id: 3, country: "Eg", coord: nil)
        let cad = City(name: "Cad", id: 4, country: "Eg", coord: nil)

        let berlin = City(name: "Berlin", id: 5, country: "Eg", coord: nil)
        let berlina = City(name: "Berlina", id: 6, country: "Eg", coord: nil)
        let ber = City(name: "ber", id: 7, country: "Eg", coord: nil)
        let beer = City(name: "Beer", id: 8, country: "Eg", coord: nil)
        compeletion(.success([cairo, cair, caar, cad, berlin, berlina, ber, beer]))
    }
}
