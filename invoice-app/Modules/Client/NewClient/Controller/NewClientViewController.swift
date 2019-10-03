//
//  NewClientViewController.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 22/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

enum NewClientFormSectionType {
    case clientDetails
    case addressDetails
}

class NewClientViewController: BaseViewController {
    
    let sections = [NewClientFormSectionType.clientDetails, NewClientFormSectionType.addressDetails]
    //MARK: - Outlet
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
    @IBOutlet weak var addClientButton: UIButton!
    
    //MARK: - Private
    private let viewModel: NewClientViewModelType
    
    //MARK: - Inits
    init(with viewmodel: NewClientViewModelType) {
        self.viewModel = viewmodel
        super.init()
    }
    
    //MARK: - Actions
    @IBAction func addClientTap(_ sender: UIButton) {
        view.endEditing(true)
        viewModel.createNewClient()
        viewModel.popToClientsList(source: self)
    }
    
    //MARK: - Setup Views
    private func setupNavigationBar() {
        navigationItem.title = "Create New Client"
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1)
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func cellRegister() {
        // Register Cells
        let newClientDetailViewCell = UINib(nibName: NewClientDetailsTableViewCell.identyfier, bundle: nil)
        tableView.register(newClientDetailViewCell, forCellReuseIdentifier: NewClientDetailsTableViewCell.identyfier)
        let newClientAddressCel = UINib(nibName: NewClientAddressTableViewCell.identyfier, bundle: nil)
        tableView.register(newClientAddressCel, forCellReuseIdentifier: NewClientAddressTableViewCell.identyfier)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        cellRegister()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NewClientViewController: UITableViewDelegate, UITableViewDataSource{
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
            newClientDetailsCell.callback = { [weak self] client in
                guard let `self` = self else { return }
                self.viewModel.getNewClientDetailModel(clientDetails: client)
            }
            return newClientDetailsCell
            
        case .addressDetails:
            guard let newClientAddressCell = tableView.dequeueReusableCell(withIdentifier: NewClientAddressTableViewCell.identyfier) as? NewClientAddressTableViewCell else {
                fatalError(cellError.showError(cellTitle: NewClientAddressTableViewCell.self, cellID: NewClientAddressTableViewCell.identyfier))
            }
            newClientAddressCell.callback = { [weak self] clientAddress in
                guard let `self` = self else { return }
                self.viewModel.getNewClientAddressModel(clientAddress: clientAddress)
            }
            return newClientAddressCell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
