//
//  UITextField(addingnewinvoice).swift
//  invoice-app
//
//  Created by Damian Szejnoch on 19/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class CustomTextField: UITextField, UITextFieldDelegate {
    //Used in NewInvoiceViewController
    
    private func setup() {
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.layer.borderWidth = 0.5
        self.textColor = .black
        self.delegate = self
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 5, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 5, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.borderColor = #colorLiteral(red: 0.1453877687, green: 0.4133757949, blue: 0.3077362776, alpha: 1)
        self.layer.borderWidth = 1
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.layer.borderWidth = 0.5
    }
}
