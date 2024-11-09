//
//  UiAlert.swift
//  MovieApplication
//
//  Created by Пащенко Иван on 09.11.2024.
//

import Foundation
import UIKit

extension UIViewController {
    static func showAlert(title: String, message: String, actionTitle: String = "OK", actionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: actionHandler))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
