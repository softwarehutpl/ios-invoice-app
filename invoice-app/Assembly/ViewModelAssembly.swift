import Foundation
import Swinject

class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CompanySelectViewModel.self) { r in
            let sceneCoordinator = r.resolve(SceneCoordinatorType.self)!
            return CompanySelectViewModel(sceneCoordinator: sceneCoordinator)
        }
        container.register(InvoiceListViewModel.self) { r in
            let sceneCoordinator = r.resolve(SceneCoordinatorType.self)!
            return InvoiceListViewModel(sceneCoordinator: sceneCoordinator)
        }
    }
}
