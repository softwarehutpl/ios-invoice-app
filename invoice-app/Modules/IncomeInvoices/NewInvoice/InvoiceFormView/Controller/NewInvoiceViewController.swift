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

enum FormState {
    case editInvoice
    case clientSelected
    case clientUnselected
}

class NewInvoiceViewController: BaseViewController {
    
    let validator = Validation() // di soon
    
    var clientSelected = false
    var invoicePassed = false
    
    let sections = [InvoiceFormSectionType.clientDetails, InvoiceFormSectionType.invoiceForm, InvoiceFormSectionType.items]
    
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
            bottomButton.layer.cornerRadius = 5
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
        tableView.endEditing(true)
        let formState = viewModel.getFormState()
        switch formState {
        case .clientSelected:
            self.viewModel.createNewInvoice()
            self.viewModel.popToInvoiceList(source: self)
        case .editInvoice:
            self.viewModel.editInvoice()
//            self.viewModel.popToInvoiceList(source:self)
        case .clientUnselected:
            self.viewModel.selectClient(source: self)
        }
    }
    
    //MARK: - Setup Views
    private func setupView() {
        switch viewModel.getFormState() {
        case .clientSelected:
            navigationItem.title = "New Invoice"
            tableView.isScrollEnabled = true
            bottomButton.setTitle("Add Invoice", for: .normal)
        case .editInvoice:
            navigationItem.title = "Edit Invoice"
            tableView.isScrollEnabled = true
            bottomButton.setTitle("Save Invoice", for: .normal)
        case .clientUnselected:
            navigationItem.title = "New Invoice"
            tableView.isScrollEnabled = false
            bottomButton.setTitle("Select Client", for: .normal)
        }
    }
    
    private func cellRegister() {
        
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
        if viewModel.getFormState() == .editInvoice {
            viewModel.fillFormsFromEditView()
        }
        setupView()
        clientSelected = viewModel.getClientTest()
        cellRegister()
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension NewInvoiceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let formState = viewModel.getFormState()
        switch formState {
        case .clientSelected, .editInvoice:
        return 3
        case .clientUnselected:
        return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch sectionType {
        case .clientDetails: return 1
        case .invoiceForm: return 1
        case .items: return viewModel.itemsCount()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sections[indexPath.section]
        let formState = viewModel.getFormState()
        switch formState {
        case .clientSelected, .editInvoice:
            switch sectionType {
            case .clientDetails:
                guard let clientDetailCell = tableView.dequeueReusableCell(withIdentifier: ClientDetailsTableViewCell.identyfier) as? ClientDetailsTableViewCell else {
                    fatalError(cellError.showError(cellTitle: ClientDetailsTableViewCell.self, cellID: ClientDetailsTableViewCell.identyfier))
                }
                clientDetailCell.callback = { 
                    self.viewModel.selectClient(source: self)
                }
                clientDetailCell.prepareCell(client: viewModel.fetchClientForm()!)
                return clientDetailCell
                
            case .invoiceForm:
                guard let invoiceFormCell = tableView.dequeueReusableCell(withIdentifier: InvoiceFormTableViewCell.identyfier) as? InvoiceFormTableViewCell else {
                    fatalError(cellError.showError(cellTitle: InvoiceFormTableViewCell.self, cellID: InvoiceFormTableViewCell.identyfier))
                }
                
                        invoiceFormCell.passInvoiceForm = { [weak self] invoiceForm in
                    guard let `self` = self else { return }
                    if self.presentedViewController as? UIAlertController != nil {
                    
                    } else {
                        self.viewModel.fetchInvoiceForm(invoiceForm: invoiceForm, source: self)
                    }
                }
                invoiceFormCell.prepareCell(invoiceForm: viewModel.passInvoiceFormToSection())
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
                
                itemCell.prepareCell(item: viewModel.passItemsToSection(indexPath: indexPath.row))
                itemCell.callback = { [weak self] item in
                    guard let `self` = self else { return }
                    self.viewModel.fetchItemsForm(itemModel: item, index: indexPath.row)
                }
                return indexPath.item == viewModel.itemsCount() - 1 ? addItemCell : itemCell
            }
            
        case .clientUnselected:
            guard let noClientAddedView = tableView.dequeueReusableCell(withIdentifier: NoClientAddedTableViewCell.identyfier) as? NoClientAddedTableViewCell else {
                fatalError(cellError.showError(cellTitle: NoClientAddedTableViewCell.self, cellID: NoClientAddedTableViewCell.identyfier))
            }
            return noClientAddedView
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionType = sections[section]
        let formState = viewModel.getFormState()
        let view = NewInvoiceCellHeader()
        switch formState {
        case .editInvoice, .clientSelected:
            switch sectionType {
            case .clientDetails : view.headerTitle.text = "Client Details"
            case .invoiceForm: view.headerTitle.text = "Invoice Details"
                                view.edit.isHidden = true
            case .items: view.headerTitle.text = "Items"
                                view.edit.isHidden = true
            }
        case .clientUnselected:
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
        let formState = viewModel.getFormState()
        switch formState {
        case .clientSelected, .editInvoice:
            return UITableView.automaticDimension
        case .clientUnselected:
            return tableView.frame.height
        }
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
