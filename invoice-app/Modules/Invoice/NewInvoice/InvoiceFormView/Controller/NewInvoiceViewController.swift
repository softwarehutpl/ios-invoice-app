//
//  NewInvoiceViewController.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 19/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

enum InvoiceFormSectionType {
    case clientDetails
    case invoiceForm
    case items
}

class NewInvoiceViewController: BaseViewController {
    
    var clientSelected = false // variable holds state which is showing correct
    //view depending whether user is selected
    let sections = [InvoiceFormSectionType.clientDetails, InvoiceFormSectionType.invoiceForm, InvoiceFormSectionType.items]
    
    
    var titles: [String] = ["abc"]
    let item = "added"
    
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
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableView.clipsToBounds = true
        
        
        // Cell register
        
        let clientDetailsView = UINib(nibName: ClientDetailsTableViewCell.identyfier, bundle: nil)
        tableView.register(clientDetailsView, forCellReuseIdentifier: ClientDetailsTableViewCell.identyfier)
        let invoiceFormView = UINib(nibName: InvoiceFormTableViewCell.identyfier, bundle: nil)
        tableView.register(invoiceFormView, forCellReuseIdentifier: InvoiceFormTableViewCell.identyfier)
        let itemsView = UINib(nibName: ItemsTableViewCell.identyfier, bundle: nil)
        tableView.register(itemsView, forCellReuseIdentifier: ItemsTableViewCell.identyfier)
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
            return 3
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch sectionType {
        case .clientDetails: return 1
        case .invoiceForm: return 1
        case .items: return titles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sections[indexPath.section]
        
        if clientSelected == true {
            switch sectionType {
            case .clientDetails:
                guard let clientDetailCell = tableView.dequeueReusableCell(withIdentifier: ClientDetailsTableViewCell.identyfier) as? ClientDetailsTableViewCell else {
                    fatalError(cellError.showError(cellTitle: ClientDetailsTableViewCell.self, cellID: ClientDetailsTableViewCell.identyfier))
                }
                clientDetailCell.callback = { 
                    self.viewModel.selectClient(source: self)
                }
                clientDetailCell.prepareCell(client: viewModel.getClient()!)
                return clientDetailCell
            
            case .invoiceForm:
                guard let invoiceFormCell = tableView.dequeueReusableCell(withIdentifier: InvoiceFormTableViewCell.identyfier) as? InvoiceFormTableViewCell else {
                    fatalError(cellError.showError(cellTitle: InvoiceFormTableViewCell.self, cellID: InvoiceFormTableViewCell.identyfier))
                }
                
                invoiceFormCell.callback = { [weak self] invoiceForm in
                    guard let `self` = self else { return }
                    self.viewModel.getInvoiceFormModel(invoiceForm: invoiceForm)
                }
                return invoiceFormCell
                
            case .items:
                guard let itemsCell = tableView.dequeueReusableCell(withIdentifier: ItemsTableViewCell.identyfier) as? ItemsTableViewCell else {
                    fatalError(cellError.showError(cellTitle: ItemsTableViewCell.self, cellID: ItemsTableViewCell.identyfier))
                }
                
                
                itemsCell.layoutMargins = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
                
                itemsCell.callback = {
                    let indexToScroll = IndexPath(row: self.titles.count - 1, section: 2)
                    let indexpath = IndexPath(row: self.titles.count - 1, section: 2)
                    self.titles.append(self.item)
                    tableView.beginUpdates()
                    tableView.insertRows(at: [indexpath], with: .automatic)
                    tableView.endUpdates()
                    self.tableView.scrollToRow(at: indexToScroll, at: .bottom, animated: true)
                }
                return itemsCell
            }
            
        } else {
            guard let noClientAddedView = tableView.dequeueReusableCell(withIdentifier: NoClientAddedTableViewCell.identyfier) as? NoClientAddedTableViewCell else {
                fatalError(cellError.showError(cellTitle: NoClientAddedTableViewCell.self, cellID: NoClientAddedTableViewCell.identyfier))
            }
            return noClientAddedView
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionType = sections[section]
        let view = NewInvoiceCellHeader()
        if clientSelected == true {
            switch sectionType {
            case .clientDetails : view.headerTitle.text = "Client Details"
            case .invoiceForm: view.headerTitle.text = "Invoice Details"
            case .items: view.headerTitle.text = "Items"
            }
        } else {
            view.isHidden = true
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if clientSelected == false {
            return tableView.frame.height
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //
    //        if editingStyle == .delete {
    //            titles.remove(at: indexPath.row)
    //
    //            tableView.beginUpdates()
    //            tableView.deleteRows(at: [indexPath], with: .automatic)
    //            tableView.endUpdates()
    //        }
    //    }
}
