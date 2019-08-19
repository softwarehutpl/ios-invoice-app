//
//  CustomerItemsView.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 15/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class CustomerItemsView: UIView {
    
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var amountAndPrice: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func prepareView(item: ItemDescription) {
        itemTitle.text = item.itemName
        amountAndPrice.text = ("\(item.amount)x PLN \(item.price)")
//        totalPrice.text = String(totalPriceValue)
        }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "CustomerItemsView", bundle: bundle)
        contentView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
}
