//
//  CartTableViewCell.swift
//  LaundryApp
//
//  Created by macbook on 22/05/2025.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var clothImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var No: UILabel!
    
    static let identifier = "CartTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CartTableViewCell", bundle: nil)
    }
    
}
