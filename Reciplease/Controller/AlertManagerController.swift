//
//  AlertManagerController.swift
//  Reciplease
//
//  Created by Saddam Satouyev on 15/04/2021.
//

import UIKit

class AlertManagerController {
    static let shared = AlertManagerController()
    private init() { }
    func presentSimpleAlert(from viewController: UIViewController, message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(confirmAction)
        viewController.present(alertController, animated: true)
    }

}
