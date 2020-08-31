//
//  ClientEditViewController.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 05/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

enum EditClientFormSectionType {
    case clientDetails
    case addressDetails
}

class EditClientViewController: BaseViewController {
    
    let sections = [EditClientFormSectionType.clientDetails, EditClientFormSectionType.addressDetails]
    
    //MARK: - Outlets
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
    private let viewModel: EditClientViewModelType
    
    init(with viewModel: EditClientViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    //MARK: - Setup Views
    private func setupNavigationBar() {
        navigationItem.title = "Edit Client"
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1)
        navigationController?.navigationBar.barStyle = .black
        let rightNavBarItemImage = UIImage(named: "hamburgericon")
        let rightNavBarItem = UIBarButtonItem(image: rightNavBarItemImage, style: .plain, target: self, action: #selector(clientOptionsTapped))
        rightNavBarItem.tintColor = .white
        navigationItem.rightBarButtonItem = rightNavBarItem
    }
    
    private func cellRegister() {
        // Register Cells
        let newClientDetailViewCell = UINib(nibName: NewClientDetailsTableViewCell.identyfier, bundle: nil)
        tableView.register(newClientDetailViewCell, forCellReuseIdentifier: NewClientDetailsTableViewCell.identyfier)
        let newClientAddressCel = UINib(nibName: NewClientAddressTableViewCell.identyfier, bundle: nil)
        tableView.register(newClientAddressCel, forCellReuseIdentifier: NewClientAddressTableViewCell.identyfier)
    }
    
    //MARK: - Actions
    @IBAction func saveClientTap(_ sender: UIButton) {
        view.endEditing(true)
        viewModel.editClient()
        viewModel.popToClientList(source: self)
    }
    
    @objc func clientOptionsTapped() {
        alertControl.showAlert(title: "Choose option", msg: "", target: self, alerts:[
            UIAlertAction(title: "Email", style: .default, handler: { (alert) in
                print("Sended by email")
            }),
            UIAlertAction(title: "Share", style: .default, handler: { (alert) in
                print("Shared")
            }),
            UIAlertAction(title: "Delete", style: .destructive, handler: { (alert) in
                self.viewModel.deleteClient()
                self.viewModel.popToClientList(source: self)
            }),
            UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert) in
                print("Cancelled")
            })
            ])
    }
    
    //MARK: - Lifecycle
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        cellRegister()
    }
}

extension EditClientViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        
        switch sectionType {
        case .clientDetails: return 1
        case .addressDetails: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sections[indexPath.section]
        
        switch sectionType {
        case .clientDetails:
            guard let newClientDetailsCell = tableView.dequeueReusableCell(withIdentifier: NewClientDetailsTableViewCell.identyfier) as? NewClientDetailsTableViewCell else {
                fatalError(cellError.showError(cellTitle: NewClientDetailsTableViewCell.self, cellID: NewClientDetailsTableViewCell.identyfier))
            }
            newClientDetailsCell.prepareCell(clientDetails: self.viewModel.fetchClientDetails())
            newClientDetailsCell.callback = { [weak self] clientDetails in
                guard let `self` = self else { return }
                self.viewModel.getEditedClientDetails(clientDetails: clientDetails)
            }
            return newClientDetailsCell
            
        case .addressDetails:
          guard let newClientAddressCell = tableView.dequeueReusableCell(withIdentifier: NewClientAddressTableViewCell.identyfier) as? NewClientAddressTableViewCell else {
                fatalError(cellError.showError(cellTitle: NewClientAddressTableViewCell.self, cellID: NewClientAddressTableViewCell.identyfier))
            }
            newClientAddressCell.prepareCell(clientAddress: self.viewModel.fetchClientAddressDetails())
            newClientAddressCell.callback = { [weak self] clientAddress in
                guard let `self` = self else { return }
                self.viewModel.getEditedClientAddress(clientAddress: clientAddress)
            }
            return newClientAddressCell
        }
    }
}
