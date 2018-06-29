//
//  WeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Dmytro Golub on 29/06/2018.
//  Copyright © 2018 dmytro golub. All rights reserved.
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
