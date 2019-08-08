import UIKit


class InvoiceListViewController: BaseViewController {
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        navigationItem.title = "Invoices"
    }
}

extension InvoiceListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.invoiceCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InvoiceCollectionViewCell.identyfier, for: indexPath) as? InvoiceCollectionViewCell else {
            fatalError("Expected `\(InvoiceCollectionViewCell.self)` type for reuseIdentifier \(InvoiceCollectionViewCell.identyfier). Check the configuration")
        }
        cell.prepareForReuse()
        cell.prepareCell(invoice: viewModel.getTestData(indexPath: indexPath.item))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showInvoiceDetailView(source: self)
    }
}


