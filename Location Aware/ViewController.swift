//
//  ViewController.swift
//  Location Aware
//
//  Created by Tarek Moubarak on 10/1/18.
//  Copyright © 2018 Tarek Moubarak. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var latVal: UILabel!
    @IBOutlet weak var longVal: UILabel!
    @IBOutlet weak var courseVal: UILabel!
    @IBOutlet weak var speedVal: UILabel!
    @IBOutlet weak var altitudeVal: UILabel!
    
    @IBOutlet weak var nearestAddress: UILabel!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0]
        latVal.text = String(userLocation.coordinate.latitude)
        longVal.text = String(userLocation.coordinate.longitude)
        courseVal.text = String(userLocation.course)
        speedVal.text = String(userLocation.speed)
        altitudeVal.text = String(userLocation.altitude)
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if error != nil {
                print(error as Any)
            } else{
                var address = ""
                if let placemark = placemarks?[0] {
                    if placemark.subThoroughfare != nil{
                        address += placemark.subThoroughfare! + " "
                    }
                    if placemark.thoroughfare != nil {
                        address += placemark.thoroughfare! + "\n"
                    }
                    if placemark.subLocality != nil {
                        address += placemark.subLocality! + "\n"
                    }
                    if placemark.subAdministrativeArea != nil {
                        address += placemark.subAdministrativeArea! +
                    "\n"
                    }
                    if placemark.postalCode != nil {
                        address += placemark.postalCode! + "\n"
                    }
                    if placemark.country != nil {
                        address += placemark.country!
                    }
                }
                self.nearestAddress.text = address
            }
        }
    }


}

