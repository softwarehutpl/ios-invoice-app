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
enum InvoiceItemsCellType {
    case newCellButton
    case itemForm
}

class NewInvoiceViewController: BaseViewController {
    
    let validator = Validation()
    
    var clientSelected = false // variable holds state which is showing correct
    //view depending whether user is selected
    
    let sections = [InvoiceFormSectionType.clientDetails, InvoiceFormSectionType.invoiceForm, InvoiceFormSectionType.items]
    
    var titles: [String] = ["abc","abc"]
    let item = "added"
    
    //MARK: - Outlets
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.allowsSelection = false
            tableView.separatorStyle = .none
            tableView.backgroundColor = .white
            tableView.showsVerticalScrollIndicator = false
            tableView.showsHorizontalScrollIndicator = false
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
            tableView.clipsToBounds = true
            tableView.setEditing(true, animated: true)
        }
    }
    
    // MARK: - Private
    private let viewModel: NewInvoiceViewModelType
    
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
    
    private func cellRegister() {
        
        if clientSelected == true {
            tableView.isScrollEnabled = true
            bottomButton.setTitle("Add Invoice", for: .normal)
        } else {
            tableView.isScrollEnabled = false
            bottomButton.setTitle("Select Client", for: .normal)
        }
        
        let clientDetailsView = UINib(nibName: ClientDetailsTableViewCell.identyfier, bundle: nil)
        tableView.register(clientDetailsView, forCellReuseIdentifier: ClientDetailsTableViewCell.identyfier)
        let invoiceFormView = UINib(nibName: InvoiceFormTableViewCell.identyfier, bundle: nil)
        tableView.register(invoiceFormView, forCellReuseIdentifier: InvoiceFormTableViewCell.identyfier)
        let addItemCell = UINib(nibName: AddItemTableViewCell.identyfier, bundle: nil)
        tableView.register(addItemCell, forCellReuseIdentifier: AddItemTableViewCell.identyfier)
        
        let itemCell = UINib(nibName: ItemTableViewCell.identyfier, bundle: nil)
        tableView.register(itemCell, forCellReuseIdentifier: ItemTableViewCell.identyfier)
        
        let noClientAddedView = UINib(nibName: NoClientAddedTableViewCell.identyfier, bundle: nil)
        tableView.register(noClientAddedView, forCellReuseIdentifier: NoClientAddedTableViewCell.identyfier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // test function
    func insertNewItemCell() {
        viewModel.addEmptyRow()
//        tableView.reloadData()
        tableView.layoutIfNeeded()
        scrollToBottom()
        
    }
    func scrollToBottom(){
        tableView.reloadData()
        let indexPath = IndexPath(row: viewModel.itemsCount() - 1, section: 2)
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        clientSelected = viewModel.getClientStatus()
        cellRegister()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
}

extension NewInvoiceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return clientSelected ? 3 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch sectionType {
        case .clientDetails: return 1
        case .invoiceForm: return 1
        case .items: if viewModel.itemsCount() == 0 {
                return 2
            } else {
                return viewModel.itemsCount()
            }
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
                
                invoiceFormCell.passInvoiceForm = { [weak self] invoiceForm in
                    guard let `self` = self else { return }
                    if self.presentedViewController as? UIAlertController != nil {
                    
                    } else {
                        print(invoiceForm)
                        self.viewModel.checkInvoiceForm(invoiceForm: invoiceForm, source: self)
                    }
                }
                return invoiceFormCell
                
            case .items:
                guard let addItemCell = tableView.dequeueReusableCell(withIdentifier: AddItemTableViewCell.identyfier) as? AddItemTableViewCell else {
                    fatalError(cellError.showError(cellTitle: AddItemTableViewCell.self, cellID: AddItemTableViewCell.identyfier))
                }
                addItemCell.callback = { [weak self ] in
                    guard let `self` = self else { return }
                    tableView.endEditing(true)
                    self.insertNewItemCell()
                }
                
                guard let itemCell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identyfier) as? ItemTableViewCell else {
                    fatalError(cellError.showError(cellTitle: ItemTableViewCell.self, cellID: ItemTableViewCell.identyfier))
                    
                }
                if viewModel.itemsCount() != 0 {
                itemCell.prepareCell(item: viewModel.passItemsToSection(indexPath: indexPath.row))
                }
                
                itemCell.callback = { [weak self] item in
                    guard let `self` = self else { return }
                    self.viewModel.getItemFormModel(itemModel: item, index: indexPath.row)
                }
                
                if viewModel.itemsCount() > 0 {
                    return indexPath.item == viewModel.itemsCount() - 1 ? addItemCell : itemCell
                } else {
                    return indexPath.item == 1 ? addItemCell : itemCell
                }
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
                                view.edit.isHidden = true
            case .items: view.headerTitle.text = "Items"
                                view.edit.isHidden = true
            }
        } else {
            view.isHidden = true
        }
        
        view.callback = { [weak self] in
            guard let `self` = self else { return }
            switch sectionType {
            case .clientDetails:
                self.viewModel.selectClient(source: self)
            case .invoiceForm:
                view.edit.isHidden = true
            case .items:
                view.edit.isHidden = true
            }
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .invoiceForm:
          return false
        case .clientDetails:
          return false
        case .items where indexPath.row != tableView.numberOfRows(inSection: 2) - 1 && viewModel.itemsCount() > 2:
            return true
        default:
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return clientSelected ? UITableView.automaticDimension : tableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let sectionType = sections[indexPath.section]
        
        if sectionType == .items && indexPath.row != viewModel.itemsCount() - 1{
            guard editingStyle == .delete else { return }
                if viewModel.itemsCount() > 2 {
                    viewModel.deleteItemFromForm(indexPath: indexPath.row)
                    tableView.reloadData()
                    scrollToBottom()
            }
        }
    }
}
