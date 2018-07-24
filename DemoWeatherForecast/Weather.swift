//
//  Weather.swift
//  DemoWeatherForecast
//
//  Created by Đừng xóa on 7/19/18.
//  Copyright © 2018 Đừng xóa. All rights reserved.
//

import Foundation

class Weather {
    var name: String
    var forecastday: [WeatherDay] = []
    var astro: [AstroData] = []
    
    
    init(dictionary: DICT) {
        let location = dictionary["location"] as? DICT ?? [:]
        name = location["name"] as? String ?? "-9999"
        
        let forecast = dictionary["forecast"] as? DICT ?? [:]
        let forecastday = forecast["forecastday"] as? [DICT] ?? []
        for weatherDay in forecastday {
            self.forecastday.append(WeatherDay(dict: weatherDay))
        }
        for astroData in forecastday {
            self.astro.append(AstroData(ditc: astroData))
        }
    }
}


struct WeatherDay {
    var date: String
    var date_epoch: TimeInterval
    var maxtemp_c: Double
    var mintemp_c: Double
    var avgtemp_c: Double
    var avghumidity : Double
    
    var condition: Condition
    
    init(dict: DICT) {
        date = dict["date"] as? String ?? "-9999"
        date_epoch = dict["date_epoch"] as? TimeInterval ?? -9999
        let day = dict["day"] as? DICT ?? [:]
        maxtemp_c = day["maxtemp_c"] as? Double ?? -9999
        mintemp_c = day["mintemp_c"] as? Double ?? -9999
        avgtemp_c = day["avgtemp_c"] as? Double ?? -9999
        avghumidity = day["avghumidity"] as? Double ?? -9999
        condition = Condition(dict: day["condition"] as? DICT ?? [:])
    }
}

struct Condition {
    var text: String
    var icon: String
    init(dict: DICT) {
        text = dict["text"] as? String ?? "-9999"
        icon =  "http:" + (dict["icon"] as? String ?? "-9999")
    }
}

struct AstroData {
    var sunrise: String
    var sunset: String
    
    init(ditc: DICT) {
        let astro = ditc["astro"] as? DICT ?? [:]
        sunrise = astro["sunrise"] as? String ?? "-9999"
        sunset = astro["sunset"] as? String ?? "-9999"
    }
}
