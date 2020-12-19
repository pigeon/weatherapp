//
//  WeatherViewCell.swift
//  WeatherApp
//
//  Created by Dmytro Golub 
//  
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet fileprivate var collectionView: UICollectionView!

    func setCollectionViewDataSourceDelegate(_ dataSourceDelegate: UICollectionViewDataSource, forRow row: Int) {
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.reloadData()
    }
}
