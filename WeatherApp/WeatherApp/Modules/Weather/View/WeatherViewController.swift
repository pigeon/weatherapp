//
//  WeatherWeatherViewController.swift
//  WeatherApp
//
//  Created by Dmytro Golub on 28/06/2018.
//  Copyright © 2018 dmytro golub. All rights reserved.
//

import UIKit


class CustomCollectionViewLayout: UICollectionViewLayout {
    
    let numberOfColumns = 8

    
    var itemAttributes = [[UICollectionViewLayoutAttributes]]()
    var itemsSize = [CGSize]()
    var contentSize: CGSize = .zero
    
    override func prepare() {
        guard let collectionView = collectionView else {
            return
        }
        
        if collectionView.numberOfSections == 0 {
            return
        }
        
        if itemAttributes.count != collectionView.numberOfSections {
            generateItemAttributes(collectionView: collectionView)
            return
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return itemAttributes[indexPath.section][indexPath.row]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        for section in itemAttributes {
            let filteredArray = section.filter { obj -> Bool in
                return rect.intersects(obj.frame)
            }
            
            attributes.append(contentsOf: filteredArray)
        }
        
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}

// MARK: - Helpers
extension CustomCollectionViewLayout {
    
    func generateItemAttributes(collectionView: UICollectionView) {
        if itemsSize.count != numberOfColumns {
            calculateItemSizes()
        }
        
        var column = 0
        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0
        let xPadding: CGFloat = 2.5
        let yPadding: CGFloat = 2.5
        var contentWidth: CGFloat = 0
        
        itemAttributes = []
        
        for section in 0..<collectionView.numberOfSections {
            var sectionAttributes: [UICollectionViewLayoutAttributes] = []
            
            for index in 0..<numberOfColumns {
                let itemSize = itemsSize[index]
                let indexPath = IndexPath(item: index, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: xOffset, y: yOffset, width: itemSize.width, height: itemSize.height).integral
                
                sectionAttributes.append(attributes)
                
                xOffset += (itemSize.width + xPadding)
                column += 1
                
                if column == numberOfColumns {
                    if xOffset > contentWidth {
                        contentWidth = xOffset
                    }
                    
                    column = 0
                    xOffset = 0
                    yOffset += (itemSize.height + yPadding)
                }
            }
            
            itemAttributes.append(sectionAttributes)
        }
        
        if let attributes = itemAttributes.last?.last {
            contentSize = CGSize(width: contentWidth, height: attributes.frame.maxY)
        }
    }
    
    func calculateItemSizes() {
        itemsSize = []
        
        for index in 0..<numberOfColumns {
            itemsSize.append(sizeForItemWithColumnIndex(index))
        }
    }
    
    func sizeForItemWithColumnIndex(_ columnIndex: Int) -> CGSize {
//        var text: NSString
//
//        switch columnIndex {
//        case 0:
//            text = "MMM-99"
//
//        default:
//            text = "Content"
//        }
//
//        let size: CGSize = text.size(withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14.0)])
//        let width: CGFloat = size.width + 16
        return CGSize(width: 100, height: 100)
    }
    
}

class WeatherViewController: UIViewController, WeatherViewInput {
    var output: WeatherViewOutput!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = CustomCollectionViewLayout()
        output.viewIsReady()
    }

    // MARK: WeatherViewInput

    func setupInitialState() {
    }

    func reload() {
    }
}


extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell",
                                                      for: indexPath)
        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor.blue
        case 1:
            cell.backgroundColor = UIColor.red
        case 2:
            cell.backgroundColor = UIColor.green
        case 3:
            cell.backgroundColor = UIColor.gray
        case 4:
            cell.backgroundColor = UIColor.yellow
        default:
            cell.backgroundColor = UIColor.orange

        }
        
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.25
        return cell
    }
    
    
}
