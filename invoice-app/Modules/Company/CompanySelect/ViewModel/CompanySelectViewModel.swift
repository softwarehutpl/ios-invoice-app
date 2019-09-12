import UIKit

class CompanySelectViewModel {
    
    var testCompanyModel = [CompanyModel]()
    var filteredCompanyModel = [CompanyModel]()
    
    var filteredCompany: String = "" {
        didSet {
            if filteredCompany.isEmpty {
                filteredCompanyModel = testCompanyModel
            } else {
                filteredCompanyModel.removeAll()
                filteredCompanyModel.append(contentsOf: testCompanyModel.filter( {$0.name.lowercased().contains(filteredCompany.lowercased())} ))
            }
        }
    }
    
    
    func loadTestCompany() {
        for _ in 0...25 {
            // let randomString = UUID().uuidString
            let testCompany = CompanyModel(name: "SoftwareX", description: "Software Development Company", domain: "https://www.google.com", address: "Sienkiewicza", phone: "555-555-555", email: "softwarex@gmail.com", isExpanded: false)
            testCompanyModel.append(testCompany)
            filteredCompanyModel = testCompanyModel
        }
    }
    
    let persistanceManager: PersistanceManager
    
    func createCompany() {
        let company = Company(context: persistanceManager.context)
        company.name = "ABCDEFGH"
        persistanceManager.save()
    }
    
    func readCompany() {
        let company = persistanceManager.fetch(Company.self)
        company.forEach({ print($0.name) })
    }

    // MARK: - Private
    private let sceneCoordinator: SceneCoordinatorType
    
    // MARK: - Lifecycle
    init(sceneCoordinator: SceneCoordinatorType, persistanceManager: PersistanceManager) {
        self.sceneCoordinator = sceneCoordinator
        self.persistanceManager = persistanceManager
        loadTestCompany()
        
        persistanceManager.fetch(Company.self).forEach { (company) in
            print(company)
        }
    }
}

extension CompanySelectViewModel: CompanySelectViewModelType {
    func changeParameter(letter: String) {
        filteredCompany = letter
    }
    
    func companyModel(indexPath: Int) -> CompanyModel {
        return filteredCompanyModel[indexPath]
    }

    var companyCount: Int {
        return filteredCompanyModel.count
    }
    
    func showList(source: UIViewController) {
        sceneCoordinator.transition(to: StartupScene.invoiceList, type: .push, source: source)
    }
    
    func toggleIsExpanded(at indexPath: IndexPath) {
        filteredCompanyModel[indexPath.row].isExpanded = !filteredCompanyModel[indexPath.row].isExpanded
    }
}
