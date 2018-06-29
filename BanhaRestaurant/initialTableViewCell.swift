//
//  initialTableViewCell.swift
//  Created by Shimaa Elcc on 4/14/18.

import UIKit
import Cosmos
class initialTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImg: UIImageView!
    @IBOutlet weak var callBtn: UIButton!
    
    @IBOutlet var CosmosView: CosmosView!
    @IBOutlet weak var firstLbl: UILabel!
    @IBOutlet weak var secondLbl: UILabel!
    
    override func awakeFromNib() {
        callBtn.layer.cornerRadius = CGFloat(Float(5.0));
        cellImg.layer.cornerRadius = cellImg.frame.size.width / 2;
        cellImg.clipsToBounds = true
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        firstLbl.text = ""
        secondLbl.text = ""
        cellImg.image = nil
        CosmosView.rating = 1
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
