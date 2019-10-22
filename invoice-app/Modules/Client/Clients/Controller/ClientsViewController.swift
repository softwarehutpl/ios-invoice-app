//
//  NewClientViewController.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 22/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class ClientsViewController: BaseViewController {
    
    //MARK: - Outlets
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Private
    var viewModel: ClientViewModelType
    
    //MARK: - Inits
    init(with viewmodel: ClientViewModelType) {
        self.viewModel = viewmodel
        super.init()
    }
    
    // //MARK: - Actions
    @objc func didTapRightNavBarItem() {
        viewModel.createNewClient(source: self)
    }
    
    @objc func refresh() {
        viewModel.fetchClientsFromCoreData()
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
    //MARK: - Views Setup
    private func refreshControlSetup() {
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        collectionView.alwaysBounceVertical = true
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        let nib = UINib(nibName: ClientCollectionViewCell.identyfier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ClientCollectionViewCell.identyfier)
    }
    
    private func setupNavigationBar() {
        let rightNavBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapRightNavBarItem))
        navigationItem.rightBarButtonItem = rightNavBarItem
        navigationItem.title = "Clients"
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1)
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func setupSearchBar() {
        if let textField = self.searchBar.subviews.first?.subviews.compactMap({ $0 as? UITextField }).first {
            textField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            textField.borderStyle = .none
            textField.layer.borderWidth = 1
            textField.layer.borderColor = #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1)
            searchBar.delegate = self
        }
    }
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchClientsFromCoreData()
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
        setupSearchBar()
        viewModel.fetchClientsFromCoreData()
        refreshControlSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ClientsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.getClientsCount() == 0 {
            self.collectionView.setEmptyMessage("No clients to show")
        } else {
            self.collectionView.restore()
        }
        return viewModel.getClientsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClientCollectionViewCell.identyfier, for: indexPath) as? ClientCollectionViewCell else {
            fatalError("Expected `\(ClientCollectionViewCell.self)` type for reuseIdentifier \(ClientCollectionViewCell.identyfier). Check the configuration")
        }
        cell.prepareForReuse()
        cell.clipsToBounds = true
        cell.prepareView(client: viewModel.fetchClients(index: indexPath.item))
        cell.callback = { [weak self] in
            guard let `self` = self else { return }
            cell.cellIndex = indexPath.item
            guard let index = cell.cellIndex else { return }
            self.viewModel.pushToEditClientView(source: self, client: self.viewModel.fetchClients(index: index))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let client = viewModel.fetchClients(index: indexPath.item)
        viewModel.popToNewInvoiceView(source: self)
        viewModel.passClientToNewInvoiceView(client: client)
        viewModel.passFormStateToInvoiceView(formState: .clientSelected)
    }
}

extension ClientsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        viewModel.searchClient(searchClient: searchText)
        collectionView.reloadData()
    }
}



