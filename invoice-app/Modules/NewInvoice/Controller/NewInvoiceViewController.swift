//
//  NewInvoiceViewController.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 19/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit


class NewInvoiceViewController: BaseViewController {
    
    var status = true
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomButton: UIButton!
    
    
    // MARK: - Private
    private let viewModel: NewInvoiceViewModelType
    
    
    // MARK: - Lifecycle
    init(with viewModel: NewInvoiceViewModelType) {
        self.viewModel = viewModel
        super.init()
    }

    
    // MARK: - Actions
    @IBAction func tapBottomButton(_ sender: UIButton) {
        status == true ? print("true") : viewModel.selectClient(source: self)
        let randomString = UUID().uuidString
        let invoice1 = InvoiceModel(invoiceTitle: "TestTitle", date: "01-01-02", dueDate: "01-01-02", amount: "100", status: true, client: ClientModel(name: randomString, email: "abc@wp.pl", phone: "694521521", address: "adres", postcode: "postcode", city: "city", country: "country"), items: [ItemModel(itemName: "item", amount: "100", price: "200")])
        viewModel.addInvoice(invoice: invoice1)
    }
    
    
    //MARK: - Setup Views
    private func setupNavigationBar() {
        navigationItem.title = "New Invoice"
    }
    
    private func setupTableView() {
        if status == true {
            tableView.isScrollEnabled = true
            bottomButton.setTitle("Add Invoice", for: .normal)
        } else {
            tableView.isScrollEnabled = false
            bottomButton.setTitle("Select Client", for: .normal)
        }
        // Setup View
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.clipsToBounds = true
        
        // Cell register
        
        let clientDetailsView = UINib(nibName: ClientDetailsTableViewCell.identyfier, bundle: nil)
        tableView.register(clientDetailsView, forCellReuseIdentifier: ClientDetailsTableViewCell.identyfier)
        let InvoiceFormView = UINib(nibName: InvoiceFormTableViewCell.identyfier, bundle: nil)
        tableView.register(InvoiceFormView, forCellReuseIdentifier: InvoiceFormTableViewCell.identyfier)
        let noClientAddedView = UINib(nibName: NoClientAddedTableViewCell.identyfier, bundle: nil)
        tableView.register(noClientAddedView, forCellReuseIdentifier: NoClientAddedTableViewCell.identyfier)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()

    }
}

extension NewInvoiceViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if status == true {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return 3
        default: fatalError("Sections loading error")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if status == true {
            switch indexPath.section {
            case 0:
                guard let clientDetailsView = tableView.dequeueReusableCell(withIdentifier: ClientDetailsTableViewCell.identyfier) as? ClientDetailsTableViewCell else {
                    fatalError(cellError.showError(cellTitle: ClientDetailsTableViewCell.self, cellID: ClientDetailsTableViewCell.identyfier))
                }
                //            clientDetailsView.prepareView(customer: viewModel.getCustomerDetails())
                clientDetailsView.callback = { 
                    self.viewModel.selectClient(source: self)
                }
                return clientDetailsView
            case 1:
                guard let invoiceFormView = tableView.dequeueReusableCell(withIdentifier: InvoiceFormTableViewCell.identyfier) as? InvoiceFormTableViewCell else {
                    fatalError(cellError.showError(cellTitle: InvoiceFormTableViewCell.self, cellID: InvoiceFormTableViewCell.identyfier))
                    
                }
                return invoiceFormView
            case 2: return UITableViewCell()
            default: return UITableViewCell()
            }
        } else {
            guard let noClientAddedView = tableView.dequeueReusableCell(withIdentifier: NoClientAddedTableViewCell.identyfier) as? NoClientAddedTableViewCell else {
                fatalError(cellError.showError(cellTitle: NoClientAddedTableViewCell.self, cellID: NoClientAddedTableViewCell.identyfier))
            }
            return noClientAddedView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if status == true {
            switch indexPath.section {
            case 0: return 200
            case 1: return 620
            default: fatalError()
            }
        } else {
            switch indexPath.section {
            case 0: return tableView.frame.height
            default: fatalError()
            }
        }
    }
}
