import UIKit

class CompanySelectViewController: BaseViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private
    private let viewModel: CompanySelectViewModelType
    
    // MARK: - Inits
    init(with viewModel: CompanySelectViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - View Setup
    func setupNavBar() {
        let nib = UINib(nibName: "CompanyViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CompanyViewCell")
        navigationItem.title = "Companies"
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Actions
extension CompanySelectViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let companyViewCell = tableView.dequeueReusableCell(withIdentifier: CompanyViewCell.identyfier) as? CompanyViewCell else {
            fatalError(cellError.showError(cellTitle: CompanyViewCell.self, cellID: CompanyViewCell.identyfier))
        }
        return companyViewCell
    }
}

extension CompanySelectViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showList(source: self)
    }
}
