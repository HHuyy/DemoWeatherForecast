//
//  UIImageView+Extentions.swift
//  DemoWeatherForecast
//
//  Created by Đừng xóa on 7/24/18.
//  Copyright © 2018 Đừng xóa. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}
