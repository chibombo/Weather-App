//
//  Weather.swift
//  Weather-App
//
//  Created by Genaro Arvizu on 27/08/20.
//  Copyright © 2020 Genaro Arvizu. All rights reserved.
//

import Foundation

struct Weather {
    
    var temp: Double = 0
    var tempMin: Double = 0
    var tempMax: Double = 0
    var pressure: Double = 0
    var country: String = ""
    var city: String = ""
    
    init() {}
    
    init(temp: Double, tempMin: Double, tempMax: Double, pressure: Double, country: String, city: String) {
        self.temp = temp
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.pressure = pressure
        self.country = country
        self.city = city
    }
    
    init(from: [String: Any]) {
        if let main: [String: Any] = from[kMainKey] as? [String: Any],
            let temp: Double = main[kTempKey] as? Double,
            let tempMin: Double = main[kMinTempKey] as? Double,
            let tempMax: Double = main[kMaxTempKey] as? Double,
            let pressure: Double = main[kPressureKey] as? Double {
            
            self.temp = temp.toCelcius()
            self.tempMax = tempMax.toCelcius()
            self.tempMin = tempMin.toCelcius()
            self.pressure = pressure
            
        }
        
        if let sys: [String: Any] = from[kSysKey] as? [String: Any],
            let country: String = sys[kCountryKey] as? String {
            self.country = country
        }
        
        if let city: String = from[kNameKey] as? String {
            self.city = city
        }
        
        
    }
    
    
}
