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
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
        return viewModel.getClientCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClientCollectionViewCell.identyfier, for: indexPath) as? ClientCollectionViewCell else {
            fatalError("Expected `\(ClientCollectionViewCell.self)` type for reuseIdentifier \(ClientCollectionViewCell.identyfier). Check the configuration")
        }
        cell.prepareView(client: viewModel.fetchClients(index: indexPath.item))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let client = viewModel.fetchClients(index: indexPath.item)
        
        viewModel.popToNewInvoiceView(source: self)
        viewModel.passClientToNewInvoiceView(client: client)
    }
}


