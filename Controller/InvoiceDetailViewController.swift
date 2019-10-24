//
//  InvoiceDetailViewController.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 08/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

enum state {
    case editInvoice
    case newInvoice
}

enum InvoiceDetailsSectionType {
    case customerDetails
    case customerAddress
    case customerItems
}

class InvoiceDetailViewController: BaseViewController {
    
    let sections = [InvoiceDetailsSectionType.customerDetails, InvoiceDetailsSectionType.customerAddress, InvoiceDetailsSectionType.customerItems]
    
    // MARK: - Outlets
    @IBOutlet weak var topView: InvoiceDetailTopView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.allowsSelection = false
            tableView.separatorStyle = .none
            tableView.backgroundColor = .white
            tableView.showsVerticalScrollIndicator = false
            tableView.showsHorizontalScrollIndicator = false
            tableView.layer.cornerRadius = 10
            tableView.clipsToBounds = true
        }
    }
    
    //MARK: - Private
    private let viewModel: InvoiceDetailViewModelType
    
    //MARK: - Inits
    init(with viewmodel: InvoiceDetailViewModelType) {
        self.viewModel = viewmodel
        super.init()
    }
    
    //MARK: - Setup Views
    private func cellRegister() {
        let customerDetailsNib = UINib(nibName: CustomerDetailsCell.identyfier, bundle: nil)
        tableView.register(customerDetailsNib, forCellReuseIdentifier: CustomerDetailsCell.identyfier)
        let customerAddressNib = UINib(nibName: CustomerAddressCell.identyfier, bundle: nil)
        tableView.register(customerAddressNib, forCellReuseIdentifier: CustomerAddressCell.identyfier)
        let customerItemsCellNib = UINib(nibName: CustomerItemsCell.identyfier, bundle: nil)
        tableView.register(customerItemsCellNib, forCellReuseIdentifier: CustomerItemsCell.identyfier)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Invoice Details"
        let rightNavBarItemImage = UIImage(named: "hamburgericon")
        let rightNavBarItem = UIBarButtonItem(image: rightNavBarItemImage, style: .plain, target: self, action: #selector(invoiceOptionsTapped))
        rightNavBarItem.tintColor = .white
        navigationItem.rightBarButtonItem = rightNavBarItem
    }
    
    func loadTopViewData() {
        topView.loadData(invoice: viewModel.getDataForTopView())
    }
    
    //MARK: - Actions
    @objc func invoiceOptionsTapped() {
        alertControl.showAlert(title: "Choose option", msg: "", target: self, alerts:[
            UIAlertAction(title: "Edit", style: .default, handler: {[weak self] (alert) in
                guard let `self` = self else { return }
                self.viewModel.editInvoiceView(source: self)
            }),
            UIAlertAction(title: "Email", style: .default, handler: { (alert) in
                print("Sended by email")
            }),
            UIAlertAction(title: "Share", style: .default, handler: { (alert) in
                print("Shared")
            }),
            UIAlertAction(title: "Delete", style: .destructive, handler: { (alert) in
                self.viewModel.deleteInvoice()
                self.viewModel.popToInvoiceList(source: self)
            }),
            UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert) in
                print("Canceled")
            })
            ])
    }
    
    //MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        topView.loadData(invoice: viewModel.getDataForTopView())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        cellRegister()
        loadTopViewData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InvoiceDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionType = sections[section]
        let label: EdgeInsetLabel = {
            let label = EdgeInsetLabel()
            label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            label.textInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            label.backgroundColor = #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1)
            label.font = UIFont.boldSystemFont(ofSize: 14)
            return label
        }()
        switch sectionType {
        case .customerDetails: label.text = "Client Details"
        case .customerAddress: label.text = "Client Address"
        case .customerItems: label.text = "Items"
        }
        return label
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch sectionType {
        case .customerDetails: return 1
        case .customerAddress: return 1
        case .customerItems: return viewModel.getItemsCount()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .customerDetails:
            guard let customerDetailsCell = tableView.dequeueReusableCell(withIdentifier: CustomerDetailsCell.identyfier, for: indexPath) as? CustomerDetailsCell else {
                fatalError(cellError.showError(cellTitle: CustomerDetailsCell.self, cellID: CustomerDetailsCell.identyfier))
            }
            customerDetailsCell.prepareView(client: viewModel.getCustomerDetails())
            return customerDetailsCell
        case .customerAddress:
            guard let customerAddressCell = tableView.dequeueReusableCell(withIdentifier: CustomerAddressCell.identyfier) as? CustomerAddressCell else {
                fatalError(cellError.showError(cellTitle: CustomerAddressCell.self, cellID: CustomerAddressCell.identyfier))
            }
            customerAddressCell.prepareView(client: viewModel.getCustomerDetails())
            return customerAddressCell
        case .customerItems:
            guard let customerItemsCell = tableView.dequeueReusableCell(withIdentifier: CustomerItemsCell.identyfier) as? CustomerItemsCell else {
                fatalError(cellError.showError(cellTitle: CustomerItemsCell.self, cellID: CustomerItemsCell.identyfier))
            }
            customerItemsCell.prepareView(item: viewModel.getItemsDescriptions(indexPath: indexPath.row))
            return customerItemsCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row\(indexPath)")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
