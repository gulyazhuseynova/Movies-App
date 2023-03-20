//
//  MoviesCollectionViewCell.swift
//  Movies App
//
//  Created by Gulyaz Huseynova on 17.03.23.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImage.layer.cornerRadius = posterImage.frame.height / 15
    }

}
