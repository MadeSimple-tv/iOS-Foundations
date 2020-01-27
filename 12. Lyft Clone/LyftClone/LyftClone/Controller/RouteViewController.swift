//
//  RouteViewController.swift
//  LyftClone
//
//  Created by Lee Bennett on 1/6/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import UIKit
import MapKit

class RouteViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var dropoffLabel: UILabel!
    @IBOutlet weak var pickupLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var routeLabelContainer: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var selectRideButton: UIButton!
    
    var selectedIndex = 1
    
    var pickupLocation: Location!
    var dropoffLocation: Location!
    var rideQuotes = [RideQuote]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Rounding all the corners!!!
        routeLabelContainer.layer.cornerRadius = 10.0
        backButton.layer.cornerRadius = backButton.frame.size.width / 2.0
        selectRideButton.layer.cornerRadius = 10.0
        
        
        pickupLabel.text = pickupLocation?.title
        dropoffLabel.text = dropoffLocation?.title
        
        rideQuotes = RideQuoteService.shared.getQuotes(pickupLocation: pickupLocation!, dropffLocation: dropoffLocation!)
        
        // Add annotations to map view
        let pickupCoordinate = CLLocationCoordinate2D(latitude: pickupLocation!.lat, longitude: pickupLocation!.lng)
        let dropoffCoordinate = CLLocationCoordinate2D(latitude: dropoffLocation!.lat, longitude: dropoffLocation!.lng)
        let pickupAnnotation = LocationAnnotation(coordinate: pickupCoordinate, locationType: "pickup")
        let dropoffAnnotation = LocationAnnotation(coordinate: dropoffCoordinate, locationType: "dropoff")
        mapView.addAnnotations([pickupAnnotation, dropoffAnnotation])
        
        mapView.delegate = self

        displayRoute(sourceLocation: pickupLocation!, destinationLocation: dropoffLocation!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func backButtonDidPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func displayRoute(sourceLocation: Location, destinationLocation: Location){
        let sourceCoordinate = CLLocationCoordinate2D(latitude: sourceLocation.lat, longitude: sourceLocation.lng)
        let destinationCoordinate =  CLLocationCoordinate2D(latitude: destinationLocation.lat, longitude: destinationLocation.lng)
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationCoordinate)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlacemark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            if let error = error{
                print("There's an error with calculating route \(error)")
                return
            }
            
            if let response = response {
                let route = response.routes[0]
                self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            
                let EDGE_INSET: CGFloat = 80.0
                let boundingMapRect = route.polyline.boundingMapRect
                self.mapView.setVisibleMapRect(boundingMapRect, edgePadding: UIEdgeInsets(top: EDGE_INSET, left: EDGE_INSET, bottom: EDGE_INSET, right: EDGE_INSET), animated: false)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rideQuotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RideQuoteCell") as! RideQuoteCell
        let rideQuote = rideQuotes[indexPath.row]
        cell.update(rideQuote: rideQuote)
        cell.updateSelectStatus(status: indexPath.row == selectedIndex)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        let selectedRideQuote = rideQuotes[indexPath.row]
        selectRideButton.setTitle("Select \(selectedRideQuote.name)", for: .normal)
        tableView.reloadData()
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 5.0
        renderer.strokeColor = UIColor(red: 247.0/255.0, green: 66.0/255.0, blue: 190.0/255.0, alpha: 1)
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        let reuseIdentifier = "LocationAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        if annotationView == nil{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        } else{
            annotationView!.annotation = annotation
        }
        let locationAnnotation = annotation as! LocationAnnotation
        annotationView!.image = UIImage(named: "dot-\(locationAnnotation.locationType)")
        return annotationView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let driverViewController = segue.destination as? DriverViewController{
            driverViewController.pickupLocation = pickupLocation
            driverViewController.dropoffLocation = dropoffLocation
        }
    }
    
}
