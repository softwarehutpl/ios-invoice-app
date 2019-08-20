import Foundation
import Swinject

class ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        ServiceAssembly().assemble(container: container)
        container.register(CompanySelectViewModel.self) { r in
            let sceneCoordinator = r.resolve(SceneCoordinatorType.self)!
            let persistanceManager = r.resolve(PersistanceManager.self)!
            return CompanySelectViewModel(sceneCoordinator: sceneCoordinator, persistanceManager: persistanceManager)
        }
        container.register(InvoiceListViewModel.self) { r in
            let sceneCoordinator = r.resolve(SceneCoordinatorType.self)!
            return InvoiceListViewModel(sceneCoordinator: sceneCoordinator)
        }
    }
}
