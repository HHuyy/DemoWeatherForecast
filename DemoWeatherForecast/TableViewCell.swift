//
//  TableViewCell.swift
//  DemoWeatherForecast
//
//  Created by Đừng xóa on 7/21/18.
//  Copyright © 2018 Đừng xóa. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var dateCell: UILabel!
    @IBOutlet weak var tempCell: UILabel!
    @IBOutlet weak var iconCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
