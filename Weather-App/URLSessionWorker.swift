//
//  URLSessionWorker.swift
//  Weather-App
//
//  Created by Genaro Arvizu on 31/08/20.
//  Copyright © 2020 Genaro Arvizu. All rights reserved.
//

import Foundation
import Network


class URLSessionWorker {
    
    let monitor: NWPathMonitor = NWPathMonitor()
    
    init() {
        monitor.start(queue: .global())
    }
    
    func executeRequest(url: URL, completionSuccess: @escaping(WeatherTwo) -> Void, completionFailed: @escaping(Error) -> Void) {
        
        var request: URLRequest = URLRequest(url: url)
        request.timeoutInterval = 10
        request.httpMethod = "GET"
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            if self.monitor.currentPath.status == .satisfied {
                URLSession.shared.dataTask(with: request) { (data: Data?, urlResponse: URLResponse?, error: Error?) in
                    if let anError: Error = error {
                        print(anError.localizedDescription)
                        completionFailed(anError)
                    } else if let aData: Data = data,
                        let response: HTTPURLResponse = urlResponse as? HTTPURLResponse {
                        
                        switch response.statusCode {
                        case 200...299:
                            
                            do {
                                //                                1.- Option One
                                //                                let json = try JSONSerialization.jsonObject(with: aData,
                                //                                                                            options: .mutableContainers)
                                //                                if let dicc: [String: Any] = json as? [String: Any] {
                                //                                    let weather: Weather = Weather(from: dicc)
                                //                                    print(weather)
                                //
                                //                                    DispatchQueue.main.async {
                                //                                        self.lblCountry.text = weather.country
                                //                                        self.lblCity.text = weather.city
                                //                                        self.lblTemp.text = "\(weather.temp)"
                                //                                        self.lblMinTemp.text = "\(weather.tempMin)"
                                //                                        self.lblMaxTemp.text = "\(weather.tempMax)"
                                //                                        self.lblPresure.text = "\(weather.pressure)"
                                //                                    }
                                //                                }
                                //                                2.- Option Two
                                let response: WeatherTwo = try JSONDecoder().decode(WeatherTwo.self, from: aData)
                                completionSuccess(response)
                                //                                        DispatchQueue.main.async {
                                //                                            self.lblCountry.text = response.sys.country
                                //                                            self.lblCity.text = response.name
                                //                                            self.lblTemp.text = "\(response.main.temp.toCelcius())"
                                //                                            self.lblMinTemp.text = "\(response.main.tempMin.toCelcius())"
                                //                                            self.lblMaxTemp.text = "\(response.main.tempMax.toCelcius())"
                                //                                            self.lblPresure.text = "\(response.main.pressure)"
                                //                                        }
                            } catch let error {
                                print(error.localizedDescription)
                                completionFailed(error)
                            }
                            
                            
                            break
                        case 400...499: break
                        case 500...599: break
                        default: break
                        }
                    }
                }.resume()
            } else {
                let error: NSError = NSError(domain: "", code: 666, userInfo: nil)
                completionFailed(error)
            }
        }
    }
    
}
