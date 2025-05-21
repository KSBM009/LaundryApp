//
//  clothsCollectionViewCell.swift
//  LaundryApp
//
//  Created by macbook on 17/05/2025.
//

import UIKit

class clothsCollectionViewCell: UICollectionViewCell {

    @IBOutlet var itemImg: UIImageView!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemCount: UILabel!
    @IBOutlet var DecrementBtn: UIButton!
    @IBOutlet var IncrementBtn: UIButton!
    
    static let identifier = "clothsCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "clothsCollectionViewCell", bundle: nil)
    }

}
