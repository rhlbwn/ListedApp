//
//  LinksCollectionViewCell.swift
//  ListedApp
//
//  Created by Rahul Bawane on 18/06/23.
//

import UIKit

class LinksCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.cornerRadius = bgView.bounds.height/2
    }

    func setCellData(title: String, selected: Bool) {
        self.titleLabel.text = title
        if selected {
            bgView.backgroundColor = .systemBlue
            titleLabel.textColor = .white
        } else {
            bgView.backgroundColor = .clear
            titleLabel.textColor = .gray
        }
    }
}
