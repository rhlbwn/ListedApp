//
//  LinksTableViewCell.swift
//  ListedApp
//
//  Created by Rahul Bawane on 18/06/23.
//

import UIKit

protocol LinksTableViewCellProtocol {
    func selectedLinkTypeChanged(type: LinkTypes)
}

class LinksTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var linkTypes = [LinkTypes.recent, LinkTypes.top]
    var selectedLinkType = LinkTypes.recent
    var delegate: LinksTableViewCellProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "LinksCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LinksCollectionViewCell")
        collectionView.reloadData()
    }
    
    func setCellData(selectedType: LinkTypes) {
        self.selectedLinkType = selectedType
        self.collectionView.reloadData()
    }
}

extension LinksTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LinksCollectionViewCell", for: indexPath) as? LinksCollectionViewCell else {
            return UICollectionViewCell()
        }
        let linkType = linkTypes[indexPath.item]
        cell.setCellData(title: linkType.rawValue, selected: linkType == self.selectedLinkType)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.linkTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/CGFloat(self.linkTypes.count), height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let linkType = linkTypes[indexPath.item]
        if linkType == self.selectedLinkType {
            return
        }
        delegate.selectedLinkTypeChanged(type: linkTypes[indexPath.item])
    }
}
