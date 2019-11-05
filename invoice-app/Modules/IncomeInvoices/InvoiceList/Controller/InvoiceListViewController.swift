import UIKit

@IBDesignable
class InvoiceListViewController: BaseViewController{
    
    let validator = Validation()
    // MARK: - Outlets
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var topBar: menuBar!
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            if let textField = self.searchBar.subviews.first?.subviews.compactMap({ $0 as? UITextField }).first {
                textField.borderStyle = .none
                textField.layer.borderWidth = 1
                textField.layer.borderColor = #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1)
            }
        }
    }
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.collectionViewLayout = InvoiceCollectionFlowLayout()
            collectionView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        }
    }
    
    
    // MARK: - Private
    private let viewModel: InvoiceListViewModelType
    
    // MARK: - Inits
    init(with viewModel: InvoiceListViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    private func cellRegister() {
        let nib = UINib(nibName: InvoiceCollectionViewCell.identyfier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: InvoiceCollectionViewCell.identyfier)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Income"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1)
        navigationController?.navigationBar.barStyle = .black
        let rightNavBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightNavBarButtonTap))
        navigationItem.rightBarButtonItem = rightNavBarItem
    }
    
    //MARK: - Actions
    @objc private func rightNavBarButtonTap() {
        viewModel.showNewInvoiceView(source: self)
    }
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchInvoicesFromCoreData()
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchInvoicesFromCoreData()
        cellRegister()
        setupNavigationBar()
        topBar.delegate = self
        refreshControlSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Views
extension InvoiceListViewController {
    @objc func refresh() {
        viewModel.fetchInvoicesFromCoreData()
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
    private func refreshControlSetup() {
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        collectionView.alwaysBounceVertical = true
    }
}

extension InvoiceListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.getInvoiceCount == 0 {
            self.collectionView.setEmptyMessage("No invoices to show")
        } else {
            self.collectionView.restore()
        }
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


