//
//  UITableViewControllerExtension.swift
//  TTCAssignment
//
//  Created by Kem Belderol on 8/22/20.
//  Copyright © 2020 Krats. All rights reserved.
//

import UIKit

extension UITableViewController {
    func showAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach({alert.addAction($0)})
        present(alert, animated: true, completion: nil)
    }
}
