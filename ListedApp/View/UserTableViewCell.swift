//
//  UserTableViewCell.swift
//  ListedApp
//
//  Created by Rahul Bawane on 15/06/23.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var salutationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(name: String) {
        self.nameLabel.text = name + " 👋"
        self.salutationLabel.text = "Good " + self.getDayStatus()
    }

    func getDayStatus() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 6..<12 : return "Morning"
        case 12 : return "Noon"
        case 13..<17 : return "Afternoon"
        case 17..<22 : return "Evening"
        default: return "Night"
        }
    }
}
