import Foundation
import Swinject

class ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        ServiceAssembly().assemble(container: container)
        
        // Overview
        container.register(CompanySelectViewModel.self) { r in
            let sceneCoordinator = r.resolve(SceneCoordinatorType.self)!
            return CompanySelectViewModel(sceneCoordinator: sceneCoordinator)
        }
        
        // Invoice Views
        container.register(InvoiceListViewModel.self) { r in
            let sceneCoordinator = r.resolve(SceneCoordinatorType.self)!
            let invoiceStorageService = r.resolve(InvoiceStorageService.self)!
            return InvoiceListViewModel(sceneCoordinator: sceneCoordinator, invoiceStorageService: invoiceStorageService)
        }
        container.register(InvoiceDetailViewModel.self) { (r, invoice: InvoiceModel) in
            let sceneCoordinator = r.resolve(SceneCoordinatorType.self)!
            let invoiceStorageService = r.resolve(InvoiceStorageService.self)!
            return InvoiceDetailViewModel(sceneCoordinator: sceneCoordinator, invoice: invoice, invoiceStorageService: invoiceStorageService)
        }
        container.register(NewInvoiceViewModel.self) { r in
            let sceneCoordinator = r.resolve(SceneCoordinatorType.self)!
            let invoiceStorageService = r.resolve(InvoiceStorageService.self)!
            return NewInvoiceViewModel(sceneCoordinator: sceneCoordinator, invoiceStorageService: invoiceStorageService)
        }
        container.register(NewItemViewModel.self) { r in
            let sceneCoordinator = r.resolve(SceneCoordinatorType.self)!
            return NewItemViewModel(sceneCoordinator: sceneCoordinator)
        }
        
        // Clients Views
        container.register(ClientViewModel.self) { (r,delegate: ClientViewModelDelegate) in
            let sceneCoordinator = r.resolve(SceneCoordinatorType.self)!
            let clientStorageService = r.resolve(ClientStorageService.self)!
            return ClientViewModel(sceneCoordinator: sceneCoordinator, clientStorageService: clientStorageService, delegate: delegate)
        }
        container.register(NewClientViewModel.self) { r in
            let sceneCoordinator = r.resolve(SceneCoordinatorType.self)!
            let clientStorageService = r.resolve(ClientStorageService.self)!
            return NewClientViewModel(sceneCoordinator: sceneCoordinator, clientStorageService: clientStorageService)
        }
        container.register(NewClientViewModel.self) { r in
            let sceneCoordinator = r.resolve(SceneCoordinatorType.self)!
            let clientStorageService = r.resolve(ClientStorageService.self)!
            return NewClientViewModel(sceneCoordinator: sceneCoordinator, clientStorageService: clientStorageService)
        }
        container.register(EditClientViewModel.self) { (r, client: ClientModel) in
            let sceneCoordinator = r.resolve(SceneCoordinatorType.self)!
            let clientStorageService = r.resolve(ClientStorageService.self)!
            return EditClientViewModel(sceneCoordinator: sceneCoordinator, clientStorageService: clientStorageService, client: client)
        }
        
    }
}
