//
//  WeatherTwo.swift
//  Weather-App
//
//  Created by Genaro Arvizu on 31/08/20.
//  Copyright © 2020 Genaro Arvizu. All rights reserved.
//

import Foundation

struct WeatherTwo: Codable {
    
    struct MainContainer: Codable {
        let temp: Double
        let tempMax: Double
        let tempMin: Double
        let pressure: Double
    }
    
    struct SysContainer: Codable {
        let country: String
    }
    
    let name: String
    let status: Int
    let main: MainContainer
    let sys: SysContainer
}

extension WeatherTwo {
    private enum CodingKeys: String, CodingKey {
        case name
        case status = "cod"
        case main
        case sys
    }
}

extension WeatherTwo.MainContainer {
    private enum CodingKeys: String, CodingKey {
        case temp
        case tempMax = "temp_max"
        case tempMin = "temp_min"
        case pressure
    }
}
