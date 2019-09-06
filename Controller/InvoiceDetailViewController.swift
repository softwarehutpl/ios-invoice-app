//
//  InvoiceDetailViewController.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 08/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class InvoiceDetailViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var topView: InvoiceDetailTopView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Private
    private let viewModel: InvoiceDetailViewModelType
    
    //MARK: - Inits
    init(with viewmodel: InvoiceDetailViewModelType) {
        self.viewModel = viewmodel
        super.init()
    }
    
    //MARK: - Setup Views
    private func setupTableView() {
        // Setup Table View
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.layer.cornerRadius = 10
        tableView.clipsToBounds = true
        
        // Register Cells
        let customerDetailsNib = UINib(nibName: CustomerDetailsCell.identyfier, bundle: nil)
        tableView.register(customerDetailsNib, forCellReuseIdentifier: CustomerDetailsCell.identyfier)
        let customerAddressNib = UINib(nibName: CustomerAddressCell.identyfier, bundle: nil)
        tableView.register(customerAddressNib, forCellReuseIdentifier: CustomerAddressCell.identyfier)
        let customerItemsCellNib = UINib(nibName: CustomerItemsCell.identyfier, bundle: nil)
        tableView.register(customerItemsCellNib, forCellReuseIdentifier: CustomerItemsCell.identyfier)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Invoice Details"
    }
    
    func loadTopViewData() {
        topView.loadData(invoice: viewModel.getDataForTopView())
    }
    
    //MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
    topView.loadData(invoice: viewModel.getDataForTopView())
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        loadTopViewData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InvoiceDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label: EdgeInsetLabel = {
            let label = EdgeInsetLabel()
            label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            label.textInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            label.backgroundColor = #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1)
            label.font = UIFont.boldSystemFont(ofSize: 13)
            return label
        }()
        switch section {
        case 0: label.text = "CLIENT DETAILS"
        case 1: label.text = "CLIENT ADDRESS"
        case 2: label.text = "ITEMS DESCRIPTION"
        case 3: label.text = "SOMETHING"
        default: fatalError()
        }
        return label
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return viewModel.getItemsCount()
        case 3: return 1
        default: fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let customerDetailsCell = tableView.dequeueReusableCell(withIdentifier: CustomerDetailsCell.identyfier, for: indexPath) as? CustomerDetailsCell else {
                fatalError(cellError.showError(cellTitle: CustomerDetailsCell.self, cellID: CustomerDetailsCell.identyfier))
            }
            customerDetailsCell.prepareView(client: viewModel.getCustomerDetails())
            return customerDetailsCell
        case 1:
            guard let customerAddressCell = tableView.dequeueReusableCell(withIdentifier: CustomerAddressCell.identyfier) as? CustomerAddressCell else {
                fatalError(cellError.showError(cellTitle: CustomerAddressCell.self, cellID: CustomerAddressCell.identyfier))
            }
            customerAddressCell.prepareView(client: viewModel.getCustomerDetails())
            return customerAddressCell
        case 2:
            guard let customerItemsCell = tableView.dequeueReusableCell(withIdentifier: CustomerItemsCell.identyfier) as? CustomerItemsCell else {
                fatalError(cellError.showError(cellTitle: CustomerItemsCell.self, cellID: CustomerItemsCell.identyfier))
            }
            customerItemsCell.prepareView(item: viewModel.getItemsDescriptions(indexPath: indexPath.row))
            return customerItemsCell
        default: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 150
        case 1: return 60
        case 2: return 70
        case 3: return 300
        default: fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row\(indexPath)")
    }
}
