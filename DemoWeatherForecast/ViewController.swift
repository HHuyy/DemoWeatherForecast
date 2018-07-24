//
//  ViewController.swift
//  DemoWeatherForecast
//
//  Created by Đừng xóa on 7/19/18.
//  Copyright © 2018 Đừng xóa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var mainIcon: UIImageView!
    @IBOutlet weak var mainDate: UILabel!
    @IBOutlet weak var humid: UILabel!
    @IBOutlet weak var sunriseDate: UILabel!
    @IBOutlet weak var sunsetDate: UILabel!
    @IBOutlet weak var mainAvgTemp: UILabel!
    @IBOutlet weak var mainMinTemp: UILabel!
    @IBOutlet weak var mainMaxTemp: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    var forecastDay: [WeatherDay] = []
    var astro: [AstroData] = []
    var dispatchWorkItem: DispatchWorkItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        DataService.shared.getData { (wearther) in
            self.NameLabel.text = wearther.name
            self.forecastDay = wearther.forecastday
            self.mainDate.text = self.forecastDay[0].date
            self.humid.text = "\(self.forecastDay[0].avghumidity)%"
            self.textLabel.text = self.forecastDay[0].condition.text
            self.mainAvgTemp.text = "\(self.forecastDay[0].avgtemp_c)º"
            self.mainMinTemp.text = "\(self.forecastDay[0].mintemp_c)º"
            self.mainMaxTemp.text = "\(self.forecastDay[0].maxtemp_c)º"
            self.astro = wearther.astro
            self.sunriseDate.text = self.astro[0].sunrise
            self.sunsetDate.text = self.astro[0].sunset
            let icon: String = self.forecastDay[0].condition.icon
            self.mainIcon.downloadImage(from: icon)
            self.tableView.reloadData()
        }
    }
    
    func downloadImageInCell(at indexPath: IndexPath, with urlString: String) {
        guard let url = URL(string: urlString) else {return}
        DispatchQueue.global().async {
            if let data = try?  Data(contentsOf: url) {
                DispatchQueue.main.async {
                    if let cell = self.tableView.cellForRow(at: indexPath) as? TableViewCell {
                        cell.iconCell.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastDay.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.dateCell.text = forecastDay[indexPath.row + 1].date
        cell.tempCell.text = "\(forecastDay[indexPath.row + 1].mintemp_c)º - \(forecastDay[indexPath.row + 1].maxtemp_c)º"
        downloadImageInCell(at: indexPath, with: forecastDay[indexPath.row + 1].condition.icon)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

