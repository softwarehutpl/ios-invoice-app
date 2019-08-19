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
        container.register(InvoiceDetailViewModel.self) { (r, invoice: InvoiceModel) in
            let sceneCoordinator = r.resolve(SceneCoordinatorType.self)!
            return InvoiceDetailViewModel(sceneCoordinator: sceneCoordinator, invoice: invoice)
        }
        container.register(NewInvoiceViewModel.self) { r in
            let sceneCoordinator = r.resolve(SceneCoordinatorType.self)!
            return NewInvoiceViewModel(sceneCoordinator: sceneCoordinator)
        }
    }
}
