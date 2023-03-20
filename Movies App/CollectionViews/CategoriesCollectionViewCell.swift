//
//  CategoriesCollectionViewCell.swift
//  Movies App
//
//  Created by Gulyaz Huseynova on 17.03.23.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var categoriesLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        underlineView.isHidden = true
    }
   
    

}
