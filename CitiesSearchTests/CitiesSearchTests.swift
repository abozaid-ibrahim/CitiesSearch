//
//  CitiesSearchTests.swift
//  CitiesSearchTests
//
//  Created by abuzeid on 03.11.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

@testable import CitiesSearch
import XCTest

final class CitiesSearchTests: XCTestCase {
    func testExample() throws {
        let viewModel = CitiesViewModel()
        viewModel.search(for: "A")
        let exp = expectation(description: "searchText")
        viewModel.citiesList.subscribe(on: .global(), {
            XCTAssertEqual($0.count, 5)
            exp.fulfill()
        })
        waitForExpectations(timeout: 0.01, handler: nil)
    }

    func testPerformanceExample() throws {
        measure {
            let viewModel = CitiesViewModel()
            viewModel.search(for: "A")
        }
    }
}
