//
//  ButtonTableViewCell.swift
//  ListedApp
//
//  Created by Rahul Bawane on 18/06/23.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    
    var cellType = LandingPageSection.viewAnalytics
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        button.layer.borderWidth = 1
        button.layer.cornerRadius =  10
    }
    
    func setCellData(cellType: LandingPageSection) {
        switch cellType {
        case .viewAnalytics:
            button.layer.borderColor = UIColor.gray.cgColor
            button.setTitle("View Analytics", for: .normal)
            button.backgroundColor = .clear
            button.contentHorizontalAlignment = .center
        case .viewAllLinks:
            button.layer.borderColor = UIColor.gray.cgColor
            button.setTitle("View all links", for: .normal)
            button.backgroundColor = .clear
            button.contentHorizontalAlignment = .center
        case .chat:
            button.layer.borderColor = UIColor.systemGreen.cgColor
            button.setTitle("Talk with us", for: .normal)
            button.backgroundColor = .systemGreen.withAlphaComponent(0.4)
            button.contentHorizontalAlignment = .left
        case .faq:
            button.layer.borderColor = UIColor.systemBlue.cgColor
            button.setTitle("Frequently Added Questions", for: .normal)
            button.backgroundColor = .systemBlue.withAlphaComponent(0.4)
            button.contentHorizontalAlignment = .left
        default: break
        }
    }
}
