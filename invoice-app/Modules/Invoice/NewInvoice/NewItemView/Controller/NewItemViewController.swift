//
//  NewItemViewController.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 19/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit
//
//class NewItemViewControllerPresentStyle {
//
//    let presentStyle: UIModalPresentationStyle
//    let sourceView: UIViewController
//    let sourceRect: CGRect
//
//    init(presentStyle: UIModalPresentationStyle,sourceView: UIViewController, sourceRect: CGRect) {
//        self.presentStyle = presentStyle
//        self.sourceView = sourceView
//        self.sourceRect = sourceRect
//    }
//}

class NewItemViewController: BaseViewController {
    
    // MARK: - Private
    private let viewModel: NewItemViewModelType
    
    //MARK: - Outlets
    @IBOutlet weak var newItemView: CellItemView!
    
    // MARK: - Inits
    init(with viewModel: NewItemViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
//        newItemView.callback = { [weak self] in
////            guard let `self` = self else { return }
////            self.viewModel.popToNewInvoiceForm(source: self)
//        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewItemViewController {
    private func setupView() {
        newItemView.headerView.headerTitle.text = "Add New Item"
    }
}
