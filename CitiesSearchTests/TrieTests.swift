//
//  TrieTests.swift
//  TrieTests
//
//  Created by Rick Zaccone on 2016-12-12.
//  Copyright © 2016 Rick Zaccone. All rights reserved.
//

@testable import CitiesSearch
import XCTest
final class DataLoader {
    static let shared = DataLoader()
    let cities: [City]
    private init() {
        let cities = try? Bundle.main.decode([City].self, from: "cities.json")
        self.cities = cities ?? []
    }
}

final class TrieTests: XCTestCase {
    /// Tests that a newly created trie has zero words.
    func testCreate() {
        let trie = Trie()
        XCTAssertEqual(trie.count, 0)
    }

    /// Tests the insert method
    func testInsert() {
        let trie = Trie()
        trie.insert(city: .init(name: "Alabama", id: 1, country: "US", coord: .init(lon: 0, lat: 0)))
        trie.insert(city: .init(name: "cutie", id: 2, country: "A", coord: .init(lon: 0, lat: 0)))
        trie.insert(city: .init(name: "fred", id: 3, country: "A", coord: .init(lon: 0, lat: 0)))
        XCTAssertTrue(trie.contains(word: "Alabama, US"))
        XCTAssertFalse(trie.contains(word: "Alabama"))
        trie.insert(city: .init(name: "Arizona", id: 4, country: "US", coord: .init(lon: 0, lat: 0)))
        XCTAssertTrue(trie.contains(word: "Arizona, US"))
        XCTAssertEqual(trie.count, 4)
    }

    /// Tests the remove method
    func testRemove() {
        let trie = Trie()
        let cute = City(name: "Berlin", id: 1, country: "DE", coord: .init(lon: 0, lat: 0))
        let cut = City(name: "London", id: 2, country: "UK", coord: .init(lon: 0, lat: 0))
        trie.insert(city: cute)
        trie.insert(city: cut)
        XCTAssertEqual(trie.count, 2)
        trie.remove(word: "Berlin, De")
        XCTAssertTrue(trie.contains(word: "London, UK"))
        XCTAssertFalse(trie.contains(word: "london"))
        XCTAssertEqual(trie.count, 1)
    }

    /// Tests the words property
    func testWords() {
        let trie = Trie()
        var words = trie.cities
        XCTAssertEqual(words.count, 0)
        let cute = City(name: "cute", id: 1, country: "A", coord: .init(lon: 0, lat: 0))
        trie.insert(city: cute)
        words = trie.cities
        XCTAssertEqual(words[0], cute)
        XCTAssertEqual(words.count, 1)
    }

    func testInsertPerformance() {
        measure {
            let trie = Trie()
            let citiesArray = DataLoader.shared.cities
            for city in citiesArray {
                trie.insert(city: city)
            }
            XCTAssertEqual(trie.count, citiesArray.count)
        }
    }

    /// Tests the performance of the insert method when the words are already
    /// present.
    func testInsertAgainPerformance() {
        let trie = Trie()
        let citiesArray = DataLoader.shared.cities
        for city in citiesArray {
            trie.insert(city: city)
        }
        measure {
            for word in citiesArray {
                trie.insert(city: word)
            }
        }
    }

    func testSearchWithPerfexPerformance() {
        let trie = Trie()
        let citiesArray = DataLoader.shared.cities
        for city in citiesArray {
            trie.insert(city: city)
        }
        measure {
            for word in citiesArray {
                _ = trie.findWordsWithPrefix(prefix: word.name)
            }
        }
    }

    /// Tests the performance of the contains method.
    func testContainsPerformance() {
        let trie = Trie()
        let citiesArray = DataLoader.shared.cities
        for city in citiesArray {
            trie.insert(city: city)
        }
        measure {
            for word in citiesArray {
                XCTAssertTrue(trie.contains(word: word.address))
            }
        }
    }

    /// Tests the performance of the remove method.  Since setup has already put
    /// words into the trie, remove them before measuring performance.
    func testRemovePerformance() {
        let trie = Trie()
        let citiesArray = DataLoader.shared.cities
        for word in citiesArray {
            trie.remove(word: word.address)
        }
        measure {
            for word in citiesArray {
                trie.remove(word: word.address)
            }
        }
        XCTAssertEqual(trie.count, 0)
    }

    /// Tests whether word prefixes are properly found and returned.
    func testFindWordsWithPrefix() {
        let trie = Trie()
        let alabama = City(name: "Alabama", id: 1, country: "US", coord: .init(lon: 0, lat: 0))
        let berlin = City(name: "Berlin", id: 2, country: "De", coord: .init(lon: 0, lat: 0))
        let cairo = City(name: "Cairo", id: 3, country: "Eg", coord: .init(lon: 0, lat: 0))

        trie.insert(city: alabama)
        trie.insert(city: berlin)
        trie.insert(city: cairo)

        let wordsAll = trie.findWordsWithPrefix(prefix: "").compactMap { $0 }.sorted()
        XCTAssertEqual(wordsAll, [alabama, berlin, cairo])
        let words = trie.findWordsWithPrefix(prefix: "Be")
        XCTAssertEqual(words, [berlin])
        let benama = City(name: "Bezama", id: 34, country: "A", coord: .init(lon: 0, lat: 0))
        trie.insert(city: benama)
        let words2 = trie.findWordsWithPrefix(prefix: "Be").compactMap { $0 }.sorted()
        XCTAssertEqual(words2, [berlin, benama])
        let noWords = trie.findWordsWithPrefix(prefix: "tee")
        XCTAssertEqual(noWords, [])
        let unicodeWord = City(name: "😬😎", id: 1, country: "US", coord: .init(lon: 0, lat: 0))
        trie.insert(city: unicodeWord)
        let wordsUnicode = trie.findWordsWithPrefix(prefix: "😬")
        XCTAssertEqual(wordsUnicode, [unicodeWord])
    }
}
