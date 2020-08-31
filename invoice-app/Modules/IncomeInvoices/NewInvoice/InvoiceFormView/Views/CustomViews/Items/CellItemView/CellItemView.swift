//
//  CellItemView.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 18/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit


class CellItemView: NibLoadingView {
    
    var editMode: FormState = .editInvoice
    var item = ItemModel(itemName: "", amount: "", price: "", tax: "", id: "")
    
    var passItem: ((ItemModel) -> Void)?
    var alert: (() -> Void)?
    
    // MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var headerView: NewInvoiceCellHeader!
    @IBOutlet weak var itemTitleTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var taxTextField: UITextField!
    @IBOutlet weak var totalLabel: EdgeInsetLabel!
    
    func addShadowToViews(views: [UIView]) {
        views.forEach { (view) in
            view.addShadow(offset: CGSize.init(width: 0, height: 1), color: UIColor.gray, radius: 2.0, opacity: 0.35)
        }
    }
    
    // MARK: - Actions
    @IBAction func passItemToViewModel(_ sender: UITextField) {
        guard let name = itemTitleTextField.text,
            let amount = amountTextField.text,
            let price = priceTextField.text,
            let tax = taxTextField.text
            else { return }
        let totalItems = (Int(amount) ?? 0) * (Int(price) ?? 0)
        let totalAfterTax = Double(totalItems) * 0.22 + Double(totalItems)
        totalLabel.text = String(totalAfterTax)
        print(item.id)
            if self.item.id == "" {
                let id = UUID().uuidString
                self.item = ItemModel(itemName: name, amount: amount, price: price, tax: tax, id: id)
                passItem?(item)
                print(item)
            } else {
                self.item = ItemModel(itemName: name, amount: amount, price: price, tax: tax, id: self.item.id)
                passItem?(item)
                print(item)
            }
    }
    
    
    func prepareView(item: ItemModel) {
        self.item = item
        itemTitleTextField.text = item.itemName
        amountTextField.text = item.amount
        priceTextField.text = item.price
        taxTextField.text = item.tax
        let totalItems = (Int(item.amount) ?? 0) * (Int(item.price) ?? 0)
        let totalAfterTax = Double(totalItems) * 0.22 + Double(totalItems)
        totalLabel.text = String(totalAfterTax)
    }
    
    //MARK: - Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        totalLabel.textInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        addShadowToViews(views: [itemTitleTextField,amountTextField,priceTextField,taxTextField])
    }
}
