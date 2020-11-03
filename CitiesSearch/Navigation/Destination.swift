//
//  Destination.swift
//  CitiesSearch
//
//  Created by abuzeid on 30.10.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation
import UIKit

enum Destination {
    case citiesList
    case map(City)
    var controller: UIViewController {
        switch self {
        case .citiesList:
            return CitiesTableController()
        case let .map(city):
            return MapViewController(with: city)
        }
    }
}
