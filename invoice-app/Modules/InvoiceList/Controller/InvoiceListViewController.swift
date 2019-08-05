import UIKit

class InvoiceListViewController: BaseViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
