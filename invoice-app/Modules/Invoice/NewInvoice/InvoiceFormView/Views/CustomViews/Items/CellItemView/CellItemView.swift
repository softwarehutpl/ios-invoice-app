//
//  CellItemView.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 18/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit


class CellItemView: NibLoadingView {
    
    var passItem: ((ItemModel) -> Void)?
    var alert: (() -> Void)?
    
    // MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var headerView: NewInvoiceCellHeader!
    @IBOutlet weak var itemTitleTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    private func textFieldDelegate() {
           itemTitleTextField.delegate = self
           amountTextField.delegate = self
           priceTextField.delegate = self
       }
    
    func addShadowToViews(views: [UIView]) {
        views.forEach { (view) in
            view.addShadow(offset: CGSize.init(width: 0, height: 1), color: UIColor.gray, radius: 2.0, opacity: 0.35)
        }
    }
    
    // MARK: - Actions
    
    //MARK: - Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textFieldDelegate()
        addShadowToViews(views: [itemTitleTextField,amountTextField,priceTextField])
    }
}

extension CellItemView: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let name = itemTitleTextField.text, !name.isEmpty,
            let amount = amountTextField.text, !amount.isEmpty,
            let price = priceTextField.text, !price.isEmpty
        else { return }
        let item = ItemModel(itemName: name, amount: amount, price: price)
        passItem?(item)
    }
}


