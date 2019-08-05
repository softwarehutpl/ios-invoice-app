import UIKit

class CompanySelectViewController: BaseViewController {
    // MARK: - Private
    private let viewModel: CompanySelectViewModelType
    
    // MARK: - Lifecycle
    init(with viewModel: CompanySelectViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        
    }
}

// MARK: - Actions
extension CompanySelectViewController {
    @IBAction func showList(_ sender: Any) {
        viewModel.showList(source: self)
    }
}
