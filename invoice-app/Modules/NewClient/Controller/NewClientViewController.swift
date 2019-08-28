//
//  NewClientViewController.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 22/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class NewClientViewController: BaseViewController {
    
    //MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Private
    private let viewModel: NewClientViewModelType
    private var clientModel = ClientModel(name: "", email: "", phone: "", address: "", postcode: "", city: "", country: "")
    
    init(with viewmodel: NewClientViewModelType) {
        self.viewModel = viewmodel
        super.init()
    }
    
    //MARK: - Actions
    
    @IBAction func addClientTap(_ sender: UIButton) {
        view.endEditing(true)
        viewModel.createNewClient(client: clientModel, source: self)
    }
    
    //MARK: - Setup Views
    private func setupNavigationBar() {
        navigationItem.title = "Create New Client"
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1)
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func setupTableView() {
        // Setup table view
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.layer.cornerRadius = 10
        tableView.clipsToBounds = true
        
        // Register Cells
        let newClientDetailViewCell = UINib(nibName: NewClientDetailsTableViewCell.identyfier, bundle: nil)
        tableView.register(newClientDetailViewCell, forCellReuseIdentifier: NewClientDetailsTableViewCell.identyfier)
        let newClientAddressCel = UINib(nibName: NewClientAddressTableViewCell.identyfier, bundle: nil)
        tableView.register(newClientAddressCel, forCellReuseIdentifier: NewClientAddressTableViewCell.identyfier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
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
        switch section {
        case 0: return 1
        case 1: return 1
        default: fatalError("Sections loading error")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let newClientDetailsCell = tableView.dequeueReusableCell(withIdentifier: NewClientDetailsTableViewCell.identyfier) as? NewClientDetailsTableViewCell else {
                fatalError(cellError.showError(cellTitle: NewClientDetailsTableViewCell.self, cellID: NewClientDetailsTableViewCell.identyfier))
                
            }
            newClientDetailsCell.callback = { client in
                self.clientModel.name = client.name
                self.clientModel.email = client.email
                self.clientModel.phone = client.phone
            }
            return newClientDetailsCell
        case 1:
            guard let newClientAddressCell = tableView.dequeueReusableCell(withIdentifier: NewClientAddressTableViewCell.identyfier) as? NewClientAddressTableViewCell else {
                fatalError(cellError.showError(cellTitle: NewClientAddressTableViewCell.self, cellID: NewClientAddressTableViewCell.identyfier))
            }
            newClientAddressCell.callback = { clientAddress in
                self.clientModel.address = clientAddress.address
                self.clientModel.postcode = clientAddress.postcode
                self.clientModel.city = clientAddress.city
                self.clientModel.country = clientAddress.country
            }
            return newClientAddressCell
            
        default: return UITableViewCell()
            
        }
    }
}
