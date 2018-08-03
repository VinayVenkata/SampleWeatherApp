//
//  WeatherTableViewController.swift
//  RestAPICall
//
//  Created by Vinay Ponnuri on 8/3/18.
//  Copyright © 2018 Vinay Ponnuri. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var SearchBar: UISearchBar!
    var forecastData = [Weather]()
    override func viewDidLoad() {
        super.viewDidLoad()

        SearchBar.delegate = self
        updateWeatherForLocation(location: "Overland Park")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let  weatherObject = forecastData[indexPath.row]
        cell.textLabel?.text = weatherObject.summary
        cell.detailTextLabel?.text = "\(Int(weatherObject.temperature)) °F"
        cell.imageView?.image = UIImage(named: weatherObject.icon)
        
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        SearchBar.becomeFirstResponder()
        if let locationString = SearchBar.text, !locationString.isEmpty {
            updateWeatherForLocation(location: locationString)
        }
    }

    func updateWeatherForLocation(location: String) {
        CLGeocoder().geocodeAddressString(location) { (placemarks:[CLPlacemark]?, error:Error?) in
            if let location = placemarks?.first?.location {
                Weather.forecast(withLocation: location.coordinate, completion: { (results: [Weather]?) in
                    if let weatherdata = results {
                        self.forecastData = weatherdata
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                })
            }
        }
    }
    
    
    
    
    
    
    
    
    
    

}
