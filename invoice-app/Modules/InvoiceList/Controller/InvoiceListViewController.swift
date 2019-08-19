import UIKit

class InvoiceListViewController: BaseViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var topBar: menuBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Private
    private let viewModel: InvoiceListViewModelType
    
    // MARK: - Lifecycle
    init(with viewModel: InvoiceListViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Collection View Setup
    private func setupCollectionView() {
        //Cells register
        let nib = UINib(nibName: InvoiceCollectionViewCell.identyfier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: InvoiceCollectionViewCell.identyfier)
    }
    
    // MARK: - Navigation Bar Setup
    private func setupNavigationBar() {
        navigationItem.title = "Invoices"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1)
        navigationController?.navigationBar.barStyle = .black
        let rightNavBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightNavBarButton))
        navigationItem.rightBarButtonItem = rightNavBarItem
    }

    // MARK: - Search Bar Setup
    private func setupSearchBar() {
    if let textField = self.searchBar.subviews.first?.subviews.compactMap({ $0 as? UITextField }).first {
        textField.borderStyle = .line
        textField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}
    
    @objc private func rightNavBarButton() {
        viewModel.showNewInvoiceView(source: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationBar()
        setupSearchBar()
        topBar.delegate = self
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
        print("reloaded")
    }
}

