//
//  Validator.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 30/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation
import UIKit

enum Alert {        //for failure and success results
    case success
    case failure
    case error
}

enum Valid {
    case success
    case failure
}

enum ValidationType {
    case email
    case phoneNumber
    case password
}

enum RegEx: String {
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" // Email
    case password = "^.{6,15}$" // Password length 6-15
    case phoneNumber = "[0-7]{10,14}" // PhoneNo -14 Digits
}

enum AlertMessages: String {
    case inValidEmail = "Invalid Email"
    case inValidPhone = "Invalid Phone"
    case inValidPassword = "Invalid Password"
    
    case emptyEmail = "Empty Email"
    case emptyPhone = "Empty Phone"
    case emptyPassword = "Empty Password"
    
    func localized() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}


class ValidatorAlert {
    func showAlert(title: String, msg: String, target: UIViewController, alerts: [UIAlertAction]?) {
        let alert = UIAlertController(title: title, message: msg , preferredStyle: UIAlertController.Style.alert)
        alerts?.forEach { (alertAction) in
            alert.addAction(alertAction)
        }
        target.present(alert, animated: true, completion: nil)
    }
}

class Validation: NSObject {
    
    public static let shared = Validation()
    var alertController = ValidatorAlert()
    
    func validate(values: (type: ValidationType, inputValue: String)...,target: UIViewController) -> Valid {
        for valueToBeChecked in values {
            switch valueToBeChecked.type {
            case .email:
                if let tempValue = isValidString((valueToBeChecked.inputValue, .email, .emptyEmail, .inValidEmail), target: target) {
                    return tempValue
                }
            case .password:
                if let tempValue = isValidString((valueToBeChecked.inputValue, .password, .emptyPassword, .inValidPassword), target: target) {
                    return tempValue
                }
            case .phoneNumber:
                if let tempValue = isValidString((valueToBeChecked.inputValue, .phoneNumber, .emptyPhone, .inValidPhone), target: target) {
                    return tempValue
                }
            }
        }
        return .success
    }
    
    func isValidString(_ input: (text: String, regex: RegEx, emptyAlert: AlertMessages, invalidAlert: AlertMessages), target: UIViewController) -> Valid? {
        if input.text.isEmpty {
            alertController.showAlert(title: "Error", msg: input.emptyAlert.localized(), target: target , alerts: nil)
            return .failure
        } else if isValidRegEx(input.text, input.regex) != true {
            alertController.showAlert(title: "Error", msg: input.invalidAlert.localized(), target: target , alerts: nil)
            return .failure
        }
        return nil
    }
    
    func isValidRegEx(_ testStr: String, _ regex: RegEx) -> Bool {
        let stringTest = NSPredicate(format:"SELF MATCHES %@", regex.rawValue)
        let result = stringTest.evaluate(with: testStr)
        return result
    }
}
