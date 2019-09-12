//
//  NewInvoiceViewController.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 19/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit


class NewInvoiceViewController: BaseViewController {
    
    var clientSelected = false
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomButton: UIButton!
    
    // MARK: - Private
    let viewModel: NewInvoiceViewModelType
    
    // MARK: - Inits
    init(with viewModel: NewInvoiceViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Actions
    @IBAction func tapBottomButton(_ sender: UIButton) {
        view.endEditing(true)
        if clientSelected == true {
            viewModel.createNewInvoice()
            viewModel.popToInvoiceList(source: self)
        } else {
          viewModel.selectClient(source: self)
        }
    }
    
    //MARK: - Setup Views
    private func setupNavigationBar() {
        navigationItem.title = "New Invoice"
    }
    
    private func setupTableView() {
        if clientSelected == true {
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
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        clientSelected = viewModel.getClientStatus()
        setupTableView()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
    }
}

extension NewInvoiceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if clientSelected == true {
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
        if clientSelected == true {
            switch indexPath.section {
            case 0:
                guard let clientDetailCell = tableView.dequeueReusableCell(withIdentifier: ClientDetailsTableViewCell.identyfier) as? ClientDetailsTableViewCell else {
                    fatalError(cellError.showError(cellTitle: ClientDetailsTableViewCell.self, cellID: ClientDetailsTableViewCell.identyfier))
                }
                clientDetailCell.callback = { 
                    self.viewModel.selectClient(source: self)
                }
                clientDetailCell.prepareCell(client: viewModel.getClient()!)
                return clientDetailCell
            case 1:
                guard let invoiceFormCell = tableView.dequeueReusableCell(withIdentifier: InvoiceFormTableViewCell.identyfier) as? InvoiceFormTableViewCell else {
                    fatalError(cellError.showError(cellTitle: InvoiceFormTableViewCell.self, cellID: InvoiceFormTableViewCell.identyfier))
                    
                }
                invoiceFormCell.callback = { [weak self] invoiceForm in
                    guard let `self` = self else { return }
                    self.viewModel.getInvoiceFormModel(invoiceForm: invoiceForm)
                }
                return invoiceFormCell
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
        if clientSelected == true {
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
