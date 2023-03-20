//
//  TopFiveCollectionViewCell.swift
//  Movies App
//
//  Created by Gulyaz Huseynova on 16.03.23.
//

import UIKit

class TopFiveCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var topFiveImage: UIImageView!
    
    @IBOutlet weak var topNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topFiveImage.layer.cornerRadius = topFiveImage.frame.height / 15
   
        
        let attrString = NSAttributedString(
            string: "1",
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor(named: "bl") ?? .link,
                NSAttributedString.Key.foregroundColor: UIColor(named: "nmbr") ?? .black,
                NSAttributedString.Key.strokeWidth: -0.8
            ]
        )
        topNumberLabel.attributedText = attrString
        
    }

}
