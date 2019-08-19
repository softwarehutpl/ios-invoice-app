import UIKit

class CompanySelectViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchController = UISearchController(searchResultsController: nil)
    
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
        setupNavBar()
        cellRegister()
    }
    
    func setupNavBar() {
        navigationItem.title = "Companies"
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func cellRegister() {
        let nib = UINib(nibName: "CompanyCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CompanyCell")
        tableView.estimatedRowHeight = 10
    }
}

// MARK: - Actions
extension CompanySelectViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.companyCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath) as! CompanyCell
        cell.prepareCell(company: viewModel.companyModel(indexPath: indexPath.item))
        cell.callback = { [weak self] in
            guard let `self` = self else { return }
            self.viewModel.toggleIsExpanded(at: indexPath)
            self.tableView.reloadRows(at: [indexPath], with: .fade)
        }
        return cell
    }
}

extension CompanySelectViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showList(source: self)
    }
}

extension CompanySelectViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.changeParameter(letter: searchText)
        tableView.reloadData()
    }
}


