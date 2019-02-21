//
//  TableViewCell.swift
//  My Meal
//
//  Created by 肖梦真 on 2/20/19.
//  Copyright © 2019 mengzhenxiao. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var mealImagePlace: UIImageView!
    @IBOutlet weak var mealTimePlace: UILabel!
    @IBOutlet weak var datePlace: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
