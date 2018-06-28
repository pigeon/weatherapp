//
//  WeatherViewCell.swift
//  WeatherApp
//
//  Created by Dmytro Golub on 28/06/2018.
//  Copyright © 2018 dmytro golub. All rights reserved.
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
