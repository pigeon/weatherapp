//
//  WeatherWeatherViewController.swift
//  WeatherApp
//
//  Created by Dmytro Golub 
//  
//

import UIKit

class WeatherViewController: UIViewController, WeatherViewInput {
    var output: WeatherViewOutput!
    @IBOutlet var tableView: UITableView!
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)

    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.center = view.center
        view.addSubview(activityIndicator)

        output.viewIsReady()
    }

    func setupInitialState() {
    }

    @IBAction func refresh(_: Any) {
        output.refreshResults()
    }

    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }

    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }

    func reload() {
        title = output.navigationTitle()
        tableView.reloadData()
    }
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 1
    }

    func numberOfSections(in _: UITableView) -> Int {
        return output.numberOfSections()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell",
                                                       for: indexPath) as? WeatherTableViewCell else {
            fatalError()
        }
        return cell
    }

    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? WeatherTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
    }

    func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        return output.titleForHeader(in: section)
    }
}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return output.numberOfItems(in: collectionView.tag)
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell",
                                                            for: indexPath) as? WeatherCollectionViewCell else {
            fatalError()
        }

        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.25

        let data = output.dataForCell(in: collectionView.tag, row: indexPath.row)

        cell.configureCell(with: data)
        return cell
    }
}
