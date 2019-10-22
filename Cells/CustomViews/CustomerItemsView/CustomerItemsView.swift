//
//  CustomerItemsView.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 15/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class CustomerItemsView: NibLoadingView {
    
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var amountAndPrice: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet var contentView: UIView!
    
    private func addShadowToViews(views: [UIView]) {
        views.forEach { (view) in
            view.addShadow(offset: CGSize.init(width: 0, height: 1), color: UIColor.gray, radius: 2.0, opacity: 0.35)
        }
    }
    
    func prepareView(item: ItemModel) {
        itemTitle.text = item.itemName
        amountAndPrice.text = ("\(item.amount) x PLN \(item.price)")
        guard let amount = Double(item.amount), let price = Double(item.price) else { return }
        totalPrice.text = "PLN \(Double(amount * price))"
    }
}
