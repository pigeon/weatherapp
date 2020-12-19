//
//  WeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Dmytro Golub
//  
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet var temperature: UILabel!
    @IBOutlet var time: UILabel!

    func configureCell(with data: WeatherModel) {
        temperature.text = String(data.tepmerature)
        time.text = data.time
    }
}
