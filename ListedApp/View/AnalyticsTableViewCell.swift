//
//  AnalyticsTableViewCell.swift
//  ListedApp
//
//  Created by Rahul Bawane on 17/06/23.
//

import UIKit

class AnalyticsTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var analyticsTitlesArray = [String]()
    var analyticsValuesArray = [String]()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "AnalyticsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AnalyticsCollectionViewCell")
        collectionView.reloadData()
    }
    
    func setCellData(data: [String: String]) {
        self.analyticsTitlesArray.removeAll()
        self.analyticsValuesArray.removeAll()
        for (key, value) in data {
            self.analyticsTitlesArray.append(key)
            self.analyticsValuesArray.append(value)
        }
        self.analyticsTitlesArray = self.analyticsTitlesArray.sorted()
        self.analyticsValuesArray = self.analyticsValuesArray.sorted()
        self.collectionView.reloadData()
    }    
}

extension AnalyticsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnalyticsCollectionViewCell", for: indexPath) as? AnalyticsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setData(title: self.analyticsTitlesArray[indexPath.item], value: self.analyticsValuesArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.analyticsTitlesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimension = collectionView.bounds.height
        return CGSize(width: dimension, height: dimension)
    }
}
