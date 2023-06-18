//
//  AnalyticsCollectionViewCell.swift
//  ListedApp
//
//  Created by Rahul Bawane on 17/06/23.
//

import UIKit

class AnalyticsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.cornerRadius = 10
        imgView.layer.cornerRadius = imgView.bounds.width/2
    }

    func setData(title: String, value: String) {
        self.titleLabel.text = value
        self.subTitleLabel.text = title
    }
}
