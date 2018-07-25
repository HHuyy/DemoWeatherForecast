//
//  DataService.swift
//  DemoWeatherForecast
//
//  Created by Đừng xóa on 7/19/18.
//  Copyright © 2018 Đừng xóa. All rights reserved.
//

import Foundation
typealias DICT = Dictionary<AnyHashable, Any>

class DataService {
    static var shared: DataService = DataService()
    
    func getData(completedHandler: @escaping(Weather) -> Void) {
        let url: String = "https://api.apixu.com/v1/forecast.json?key=7ef0663d09174c43b9d12527181807&q=Paris&days=7"
        guard let urlString = URL(string: url) else {return}
        let urlRequest = URLRequest(url: urlString)
        let downloadTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, _, error) in
            guard error == nil else {return}
            guard let aData = data else {return}
            do {
                if let jSonObject = try JSONSerialization.jsonObject(with: aData, options: .mutableContainers) as? DICT {
                    DispatchQueue.main.async {
                        completedHandler(Weather(dictionary: jSonObject))
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        })
        downloadTask.resume()
    }
}

