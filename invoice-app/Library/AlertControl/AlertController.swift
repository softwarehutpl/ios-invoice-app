//
//  AlertController.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 15/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit
import Foundation

class AlertControl {

    func alert(title:String, msg: String, target: UIViewController, alerts: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertController.Style.alert)
        alerts.forEach { (alertAction) in
            alert.addAction(alertAction)
        }
        target.present(alert, animated: true, completion: nil)
    }
}

let alertControl = AlertControl()
