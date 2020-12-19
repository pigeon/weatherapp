//
//  ViewController.swift
//
//
//  Created by Dmytro Golub
//
//

import UIKit

extension UIViewController {
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func show(error: NSError) {
        showError(title: "Error", message: error.localizedDescription)
    }
}
