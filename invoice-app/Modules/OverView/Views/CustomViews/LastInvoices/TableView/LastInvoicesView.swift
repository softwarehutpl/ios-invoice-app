//
//  LastInvoicesView.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 29/10/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class LastInvoicesView: NibLoadingView {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.clipsToBounds = true
        }
    }
    //MARK: - Setup TableView
    private func setupTableView() {
        let invoiceCell = UINib(nibName: InvoiceTableViewCell.identyfier, bundle: nil)
        tableView.register(invoiceCell, forCellReuseIdentifier: InvoiceTableViewCell.identyfier)
    }
    
    //MARK: - Setup View
    private func setupView() {
        view.layer.cornerRadius = 10
        view.addShadow(offset: CGSize(width: 3, height: 3), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2), radius: 3, opacity: 0.2)
    }
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTableView()
        setupView()
    }
}

extension LastInvoicesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let invoiceCell = tableView.dequeueReusableCell(withIdentifier: InvoiceTableViewCell.identyfier, for: indexPath) as? InvoiceTableViewCell else {
            fatalError(cellError.showError(cellTitle: InvoiceTableViewCell.self, cellID: InvoiceTableViewCell.identyfier))
        }
        return invoiceCell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
