//
//  MapConfiguration.swift
//  NA-lxc2877-3
//
//  Created by Lamia Cero on 14/11/2020.
//

import Foundation
import MapKit

struct MapConfiguration {
    static let initialLocation = CLLocationCoordinate2D(latitude: 45.782722,
                                                        longitude: 15.981194)
    static let regionRadius: CLLocationDistance = 10000

    private init() {}
}
