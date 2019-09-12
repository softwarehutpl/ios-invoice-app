import UIKit

class CompanySelectViewModel {
    
    var testCompanyModel = [CompanyModel]()
    var filteredCompanyModel = [CompanyModel]()
    
    // MARK: - Private
    private let sceneCoordinator: SceneCoordinatorType
    
    // MARK: - Lifecycle
    init(sceneCoordinator: SceneCoordinatorType) {
        self.sceneCoordinator = sceneCoordinator
    }
}

extension CompanySelectViewModel: CompanySelectViewModelType {
    
    func companyModel(indexPath: Int) -> CompanyModel {
        return filteredCompanyModel[indexPath]
    }

    var companyCount: Int {
        return filteredCompanyModel.count
    }
    
    func showList(source: UIViewController) {
        sceneCoordinator.transition(to: StartupScene.invoiceList, type: .push, source: source)
    }
}

