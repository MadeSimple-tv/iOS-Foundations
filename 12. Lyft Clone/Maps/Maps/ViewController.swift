//
//  ViewController.swift
//  Maps
//
//  Created by Lee Bennett on 1/4/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    var locationManager: CLLocationManager!

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 0.0
        
        // Request permission for user's location
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            locationManager.startUpdatingLocation()
        }
                
        mapView.delegate = self
        
        let appleStoreAnnotation = LocationAnnotation(title: "Apple Union Square", coordinate: CLLocationCoordinate2D(latitude: 37.7861369, longitude: -122.4089195))
        let blueBottleCoffeeAnnotation = LocationAnnotation(title: "Blue Bottle Coffee", coordinate: CLLocationCoordinate2D(latitude: 37.7763291, longitude: -122.4254317))
        mapView.addAnnotations([appleStoreAnnotation, blueBottleCoffeeAnnotation])
        displayRoute(sourceCoordinate: appleStoreAnnotation.coordinate, destinationCoordinate: blueBottleCoffeeAnnotation.coordinate)
//        mapView.addAnnotation(appleStoreAnnotation)
        // mapView.setCenter(appleStoreAnnotation.coordinate, animated: false)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        return renderer
    }
    
    func displayRoute(sourceCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D){
        // Placemarks
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
        
        // Directions
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlacemark)
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate(completionHandler: { (response, error) in
            if let error = error{
                print("There is an error with calculating route \(error)")
                return
            }
            if let response = response{
                let route = response.routes.first!
                // Drawing the route on the map
                self.mapView.addOverlay(route.polyline, level: .aboveRoads)
                // Zoom in and center the map's visible region on the route
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 80.0, left: 80.0, bottom: 80.0, right: 80.0), animated: false)
            }
        })
        
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first!
        print("location update latitude: \(location.coordinate.latitude) , longitude: \(location.coordinate.longitude)")
    }

}

