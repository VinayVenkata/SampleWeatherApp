//
//  Weather.swift
//  RestAPICall
//
//  Created by Vinay Ponnuri on 8/3/18.
//  Copyright © 2018 Vinay Ponnuri. All rights reserved.
//

import Foundation

struct Weather {
    let summary: String
    let icon: String
    let temparature: Double
    
    enum SerializationError: Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    init(json:[String:Any]) throws {
        guard let summary = json["summary"] as? String else {
            throw SerializationError.missing("Summary is missing")
        }
        
        guard let icon = json["icon"] as? String else {
            throw SerializationError.missing("icon is missing")
        }
        
        guard let temparature = json["temperatureMax"] as? Double else {
            throw SerializationError.missing("temperature is missing")
        }
        
        self.summary = summary
        self.icon = icon
        self.temparature = temparature
        
    }
    
    static let basePath = "https://api.darksky.net/forecast/4d02c7ec919033cdea19792901d9fc64/"
    static func forcast(withLocatioin location: String, completion: @escaping ([Weather]) -> ()) {
        let url = basePath + location
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            var forcastArray:[Weather] = []
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let dailyForcast = json["daily"] as? [String:Any] {
                            if let dailyData = dailyForcast["data"] as? [[String:Any]] {
                                for dataPoint in dailyData {
                                    if let weatherObject = try?  Weather(json: dataPoint){
                                        forcastArray.append(weatherObject)
                                    }
                                }
                            }
                        }
                    }
                }catch {
                    print(error.localizedDescription)
                }
                completion(forcastArray)
            }
            
        }
        task.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
