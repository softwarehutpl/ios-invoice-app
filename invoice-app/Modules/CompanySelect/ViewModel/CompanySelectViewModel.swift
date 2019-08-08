import UIKit

class CompanySelectViewModel {
    
    // MARK: - Private
    private let sceneCoordinator: SceneCoordinatorType
    
    // MARK: - Lifecycle
    init(sceneCoordinator: SceneCoordinatorType) {
        self.sceneCoordinator = sceneCoordinator
    }
}

extension CompanySelectViewModel: CompanySelectViewModelType {
    func showList(source: UIViewController) {
        sceneCoordinator.transition(to: StartupScene.invoiceList, type: .push, source: source)
    }
}
