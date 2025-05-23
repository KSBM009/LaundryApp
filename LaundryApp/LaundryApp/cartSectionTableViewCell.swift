//
//  cartSectionTableViewCell.swift
//  LaundryApp
//
//  Created by macbook on 22/05/2025.
//

import UIKit

class cartSectionTableViewCell: UITableViewCell {

    @IBOutlet weak var Category: UILabel!
    @IBOutlet weak var count: UILabel!
    
    static let identifier = "cartSectionTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "cartSectionTableViewCell", bundle: nil)
    }
    
}
