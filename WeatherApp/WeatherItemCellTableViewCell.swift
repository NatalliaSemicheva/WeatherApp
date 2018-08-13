//
//  WeatherItemCellTableViewCell.swift
//  WeatherApp
//
//  Created by Наталия Семичева on 8/12/18.
//  Copyright © 2018 Наталия Семичева. All rights reserved.
//

import UIKit

class WeatherItemCellTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var degreeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
