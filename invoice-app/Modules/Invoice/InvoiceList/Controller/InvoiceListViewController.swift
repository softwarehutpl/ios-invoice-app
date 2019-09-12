import UIKit

class InvoiceListViewController: BaseViewController{
    
    // MARK: - Outlets
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var topBar: menuBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Private
    private let viewModel: InvoiceListViewModelType
    
    // MARK: - Inits
    init(with viewModel: InvoiceListViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Actions
    @objc private func rightNavBarButtonTap() {
        viewModel.showNewInvoiceView(source: self)
    }
    
    @objc func refresh() {
        viewModel.fetchInvoicesFromCoreData()
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
    // MARK: - Views Setup
    private func refreshControlSetup() {
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        collectionView.alwaysBounceVertical = true
    }
    
    private func setupCollectionView() {
        collectionView.collectionViewLayout = InvoiceCollectionFlowLayout()
        collectionView.backgroundColor = #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1)
        //Cells register
        let nib = UINib(nibName: InvoiceCollectionViewCell.identyfier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: InvoiceCollectionViewCell.identyfier)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Invoices"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1)
        navigationController?.navigationBar.barStyle = .black
        let rightNavBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightNavBarButtonTap))
        navigationItem.rightBarButtonItem = rightNavBarItem
    }
    
    private func setupSearchBar() {
        if let textField = self.searchBar.subviews.first?.subviews.compactMap({ $0 as? UITextField }).first {
            textField.borderStyle = .none
            textField.layer.borderWidth = 1
            textField.layer.borderColor = #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1)
        }
    }
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchInvoicesFromCoreData()
        collectionView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchInvoicesFromCoreData()
        setupCollectionView()
        setupNavigationBar()
        setupSearchBar()
        topBar.delegate = self
        refreshControlSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InvoiceListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getInvoiceCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InvoiceCollectionViewCell.identyfier, for: indexPath) as? InvoiceCollectionViewCell else {
            fatalError("Expected `\(InvoiceCollectionViewCell.self)` type for reuseIdentifier \(InvoiceCollectionViewCell.identyfier). Check the configuration")
        }
        cell.prepareForReuse()
        cell.prepareCell(invoice: viewModel.getInvoices(indexPath: indexPath.item))
        cell.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showInvoiceDetailView(source: self, invoice: viewModel.getInvoices(indexPath: indexPath.item))
    }
}

extension InvoiceListViewController: SegmentControllerProtocol {
    func passFilteringIndexType(index: Int) {
        viewModel.changeFilteringType(index: index)
        collectionView.reloadData()
    }
}

extension InvoiceListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchingText(searchingText: searchText)
        collectionView.reloadData()
        
    }
}


