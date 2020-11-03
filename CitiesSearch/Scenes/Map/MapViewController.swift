//
//  AirportsMapController.swift
//  CitiesSearch
//
//  Created by abuzeid on 31.10.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import MapKit
import UIKit

final class MapViewController: UIViewController {
    private let mapView = MKMapView()
    private let mapDistanceMeters = Double(10000)
    private let city: City
    init(with city: City) {
        self.city = city
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addCityAnnotation()
    }
}

private extension MapViewController {
    func setup() {
        view.addSubview(mapView)
        mapView.setConstrainsEqualToParent(edge: [.all])
        title = city.address
    }

    func addCityAnnotation() {
        guard let location = city.coord else { return }
        let coordinates = CLLocationCoordinate2D(latitude: location.lat, longitude: location.lon)
        let annotation = MKPointAnnotation()
        annotation.title = city.name
        annotation.coordinate = coordinates
        mapView.addAnnotation(annotation)
        mapView.setRegion(.init(center: coordinates, latitudinalMeters: mapDistanceMeters, longitudinalMeters: mapDistanceMeters),
                          animated: true)
    }
}
