//
//  sideBarTableViewCell.swift
//  BanhaRestaurant
//
//  Created by Shimaa Elcc on 5/15/18.
//  Copyright © 2018 Shimaa Elcc. All rights reserved.
//

import UIKit

class sideBarTableViewCell: UITableViewCell {

    @IBOutlet var cellLbl: UILabel!

    @IBOutlet var cellImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
