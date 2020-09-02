//
//  CoreLocationWorker.swift
//  Weather-App
//
//  Created by Genaro Arvizu on 31/08/20.
//  Copyright © 2020 Genaro Arvizu. All rights reserved.
//

import Foundation
import CoreLocation


protocol CoreLocationDelegate: class {
    func coreLocation(location: CLLocation) -> Void
}

class CoreLocationWorker: NSObject {
    
    var locationManager: CLLocationManager!
    var delegate: CoreLocationDelegate?
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
                
        
    }
    
    func requestLocation() {
        switch isAvailable() {
        case .authorizedAlways, .authorizedWhenInUse: locationManager.requestLocation()
        case .notDetermined: locationManager.requestAlwaysAuthorization()
        default:
            break
        }
    }
    
    func isAvailable() -> CLAuthorizationStatus {
        CLLocationManager.authorizationStatus()
    }
    
    
    
}

extension CoreLocationWorker: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse: requestLocation()
        case .notDetermined: locationManager.requestAlwaysAuthorization()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        delegate?.coreLocation(location: locations.first!)
    }
    
}
