//
//  NewsStanAnnotation.swift
//  NA-lxc2877-3
//
//  Created by Lamia Cero on 14/11/2020.
//

import Foundation

import MapKit

class NewsStandAnnotation: NSObject, MKAnnotation {
    var title: String? {
        newsSModel.name
    }
    
    var subtitle: String? {
        newsSModel.category.description
    }
    
    var coordinate: CLLocationCoordinate2D {
        newsSModel.coordinate
    }
    
    var newsSModel: NewsStand
    
    init(newsSt: NewsStand) {
        newsSModel = newsSt
    }
}
