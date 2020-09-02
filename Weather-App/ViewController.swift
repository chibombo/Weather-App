//
//  ViewController.swift
//  Weather-App
//
//  Created by Genaro Arvizu on 26/08/20.
//  Copyright © 2020 Genaro Arvizu. All rights reserved.
//

import UIKit
import CoreLocation

let kMainKey: String = "main"
let kTempKey: String = "temp"
let kMinTempKey: String = "temp_min"
let kMaxTempKey: String = "temp_max"
let kPressureKey: String = "pressure"

let kSysKey: String = "sys"
let kCountryKey: String = "country"

let kNameKey: String = "name"

class ViewController: UIViewController {

    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblMinTemp: UILabel!
    @IBOutlet weak var lblMaxTemp: UILabel!
    @IBOutlet weak var lblPresure: UILabel!
    @IBOutlet weak var btnUpdate: UIButton!
        
    let locationWorker: CoreLocationWorker = CoreLocationWorker()
    let urlSession: URLSessionWorker = URLSessionWorker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationWorker.delegate = self
              
    }

    func fetchWeather(location: CLLocation) {
        let url: URL = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=b0ddff72b77ab111f267ad5beff6f7ff")!
        urlSession.executeRequest(url: url,
                                  completionSuccess: { (response: WeatherTwo) in
                                    DispatchQueue.main.async {
                                        self.lblCountry.text = response.sys.country
                                        self.lblCity.text = response.name
                                        self.lblTemp.text = "\(response.main.temp.toCelcius())"
                                        self.lblMinTemp.text = "\(response.main.tempMin.toCelcius())"
                                        self.lblMaxTemp.text = "\(response.main.tempMax.toCelcius())"
                                        self.lblPresure.text = "\(response.main.pressure)"
                                    }
        }) { (error: Error) in
            let action: UIAlertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            let alert: UIAlertController = UIAlertController(title: "Error",
                                                             message: "Intenta más tarde",
                                                             preferredStyle: .alert)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func userTappedUpdate(_ sender: UIButton) {
        locationWorker.requestLocation()
    }
        
}

extension ViewController: CoreLocationDelegate {
        
    func coreLocation(location: CLLocation) {
        fetchWeather(location: location)
    }
        
}
