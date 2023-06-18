//
//  LinkDataTableViewCell.swift
//  ListedApp
//
//  Created by Rahul Bawane on 18/06/23.
//

import UIKit

class LinkDataTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var linkBgView: UIView!
    @IBOutlet weak var linkImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var clickLabel: UILabel!

    @IBOutlet weak var linkLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.cornerRadius = 10
        linkImageView.layer.cornerRadius = 5
        linkImageView.layer.borderWidth = 1
        linkImageView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.clipsToBounds = true
//        linkBgView.addLineDashedStroke(pattern: [2,2], radius: 10, color: UIColor.blue.cgColor)
    }
    
    func setCellData(linkData: Link?) {
        guard let linkData = linkData else {return}
        titleLabel.text = linkData.title
        dateLabel.text = linkData.createdAt.changeDateFormat(input: "yyyy-MM-dd'T'HH:mm:ss.SSSz", output: "dd MMM yyyy")
        countLabel.text = "\(linkData.totalClicks)"
        linkLabel.text = linkData.webLink
        DispatchQueue.main.async {
            self.linkImageView.downloaded(from: linkData.originalImage)
        }
    }
    
}

extension String {
    func changeDateFormat(input: String, output: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = input
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = output
        let resultString = dateFormatter.string(from: date!)
        print(resultString)
        return resultString
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension UIView {
    func addLineDashedStroke(pattern: [NSNumber]?, radius: CGFloat, color: CGColor) {
        let borderLayer = CAShapeLayer()

        borderLayer.strokeColor = color
        borderLayer.lineDashPattern = pattern
        borderLayer.frame = bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius)).cgPath

        layer.addSublayer(borderLayer)
    }
}
