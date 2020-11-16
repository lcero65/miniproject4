//
//  MapView.swift
//  NA-lxc2877-3
//
//  Created by Lamia Cero on 14/11/2020.
//
//reference for map styles:https://stackoverflow.com/questions/61479737/show-maptype-in-selectedsegment-swiftui

import SwiftUI
import MapKit

enum MapDirectionError: Error, LocalizedError {
    case userLocationNotAvailable
    case url(message: String)
    
    var errorDescription: String? {
        localizedDescription
    }
    
    var localizedDescription: String {
        switch self {
        case .userLocationNotAvailable:
            return "User location is not available"
        case .url(let message):
            return message
        }
    }
}

struct MapView: UIViewRepresentable {
    
    struct MapState: Identifiable {
        let id = UUID()
        var newsSt: NewsStand? = nil
        var error: Error? = nil
    }
    
    @Binding var data: [NewsStand]
    @Binding var mapState: MapState?
    var type: MKMapType
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        context.coordinator.zoomToRegion()
        return context.coordinator.mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        context.coordinator.createAnnotations(data: data)
        uiView.mapType = self.type
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        var mapView: MKMapView
        private var locationManager: CLLocationManager
        
        init(parent: MapView) {
            self.parent = parent
            self.mapView = MKMapView()
            self.locationManager = CLLocationManager()
            super.init()
            
            self.mapView.delegate = self
        }
        
        
        func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
            print("Finished loading...")
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            if annotation is MKUserLocation { return nil }
            
            guard let placeAnnotation = annotation as? NewsStandAnnotation else {
                return nil
            }
            
            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation") as? MKMarkerAnnotationView {
                
                annotationView.annotation = placeAnnotation
                
                annotationView.glyphImage = placeAnnotation.newsSModel.category.image
                annotationView.markerTintColor = placeAnnotation.newsSModel.category.color
                
                return annotationView
            }
            
            let annotationView = MKMarkerAnnotationView(annotation: placeAnnotation,
                                                        reuseIdentifier: "myAnnotation")
            
            annotationView.glyphImage = UIImage(systemName: "computer.fill")
            annotationView.markerTintColor = .blue
            annotationView.canShowCallout = true
            
            let infoButton = UIButton(type: .infoLight)
            
            let directionsButton = UIButton(type: .infoDark)
            let carImage = UIImage(systemName: "car")
            directionsButton.setImage(carImage, for: .normal)
            
            infoButton.tag = 0
            directionsButton.tag = 1
            
            annotationView.leftCalloutAccessoryView = infoButton
            annotationView.rightCalloutAccessoryView = directionsButton
            
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            guard let placeAnnotation = view.annotation as? NewsStandAnnotation else {
                return
            }
            
            switch control.tag {
            case 0:
                parent.mapState = MapState(newsSt: placeAnnotation.newsSModel)
            case 1:
                do {
                    try getDirections(for: placeAnnotation.newsSModel)
                } catch {
                    parent.mapState = MapState(error: error)
                }
            default:
                return
            }
            
        }
        
        private func getDirections(for newsSt: NewsStand) throws {
            guard let userCoordinates = locationManager.location?.coordinate else {
                throw MapDirectionError.userLocationNotAvailable
            }
            
            let userLat = userCoordinates.latitude
            let userLong = userCoordinates.longitude
            
            let placeLat = newsSt.coordinate.latitude
            let placeLong = newsSt.coordinate.longitude
            
            let urlString = "https://maps.apple.com/?daddr=(\(placeLat),\(placeLong))&dirflg=d&saddr=(\(userLat),\(userLong))"
            
            guard let url = URL(string: urlString) else {
                throw MapDirectionError.url(message: "Cannot create url.")
            }
            
            guard UIApplication.shared.canOpenURL(url) else {
                throw MapDirectionError.url(message: "Cannot open url.")
            }
            
            UIApplication.shared.open(url, options: [:])
        }
        
        func zoomToRegion(center: CLLocationCoordinate2D = MapConfiguration.initialLocation ,
                          regionRadius: CLLocationDistance = MapConfiguration.regionRadius) {
            
            let region = MKCoordinateRegion(center: center,
                                            latitudinalMeters: regionRadius,
                                            longitudinalMeters: regionRadius)
            
            mapView.setRegion(region, animated: true)
        }
        
        
        
        func createAnnotations(data: [NewsStand]) {
            print("hello")
            let existingAnnotations = mapView.annotations.filter({ !($0 is MKUserLocation) })
            mapView.removeAnnotations(existingAnnotations)
            mapView.addAnnotations(data.map(NewsStandAnnotation.init))
            
        }
    }
}



