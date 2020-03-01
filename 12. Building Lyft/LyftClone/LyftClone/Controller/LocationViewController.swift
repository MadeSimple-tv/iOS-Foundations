//
//  LocationViewController.swift
//  LyftClone
//
//  Created by Lee Bennett on 1/6/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, MKLocalSearchCompleterDelegate{
    
    @IBOutlet weak var tableview: UITableView!
    var locations = [Location]()
    var pickupLocation: Location?
    var dropoffLocation: Location?
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    @IBOutlet weak var dropoffTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locations = LocationService.shared.getRecentLocations()
        
        dropoffTextField.becomeFirstResponder()
        dropoffTextField.delegate = self
        
        searchCompleter.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func cancelDidTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let latestString = (textField.text as! NSString).replacingCharacters(in: range, with: string)
        print("latest string \(latestString)")
        
        if latestString.count > 3{
            searchCompleter.queryFragment = latestString
        }
        
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.isEmpty ? locations.count : searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") as! LocationCell
        
        if searchResults.isEmpty{
            let location = locations[indexPath.row]
            cell.update(location: location)
        } else {
            let searchResult = searchResults[indexPath.row]
            cell.update(searchResult: searchResult)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchResults.isEmpty{
            let location = locations[indexPath.row]
            performSegue(withIdentifier: "RouteSegue", sender: location)
        } else {
            // Convert searchResult -> Location object
            let searchResult = searchResults[indexPath.row]
            let searchRequest = MKLocalSearch.Request(completion: searchResult)
            let search = MKLocalSearch(request: searchRequest)
            search.start(completionHandler: { (response, error) in
                if error == nil{
                    if let dropoffPlacemark = response?.mapItems.first?.placemark{
                        let location = Location(placemark: dropoffPlacemark)
                        self.performSegue(withIdentifier: "RouteSegue", sender: location)
                    }
                }
            })
        }
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        // reload our table view
        tableview.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let routeViewController = segue.destination as? RouteViewController, let dropoffLocation = sender as? Location{
            routeViewController.pickupLocation = pickupLocation
            routeViewController.dropoffLocation = dropoffLocation
        }
    }
    
}
