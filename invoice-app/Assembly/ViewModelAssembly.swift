import Foundation
import Swinject

class ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        ServiceAssembly().assemble(container: container)
        
        //TabBar
        container.register(BaseTabBarViewModelType.self) { r in
            let sceneCoordinator = r.resolve(SceneCoordinatorType.self)!
            return BaseTabBarViewModel(sceneCoordinator: sceneCoordinator)
        }
        
        //OverView
        container.register(OverViewViewModelType.self) { r in
            let sceneCoordinator = r.resolve(SceneCoordinatorType.self)!
            return OverViewModel(sceneCoordinator: sceneCoordinator)
        }
        
        // Invoice Views
        container.register(InvoiceListViewModelType.self) { r in
            let sceneCoordinator = r.resolve(SceneCoordinatorType.self)!
            let invoiceStorageService = r.resolve(InvoiceStorageServiceType.self)!
            return InvoiceListViewModel(sceneCoordinator: sceneCoordinator, invoiceStorageService: invoiceStorageService)
        }
        container.register(InvoiceDetailViewModelType.self) { (r, invoice: InvoiceModel) in
            let sceneCoordinator = r.resolve(SceneCoordinatorType.self)!
            let invoiceStorageService = r.resolve(InvoiceStorageServiceType.self)!
            return InvoiceDetailViewModel(sceneCoordinator: sceneCoordinator, invoice: invoice, invoiceStorageService: invoiceStorageService)
        }
        container.register(NewInvoiceViewModelType.self) { (r,invoice: InvoiceModel?, formState: FormState) in
            let sceneCoordinator = r.resolve(SceneCoordinatorType.self)!
            let invoiceStorageService = r.resolve(InvoiceStorageServiceType.self)!
            return NewInvoiceViewModel(sceneCoordinator: sceneCoordinator, invoiceStorageService: invoiceStorageService, invoiceModel: invoice, formState: formState)
        }
        
        // Clients Views
        container.register(ClientViewModelType.self) { (r,delegate: ClientViewModelDelegate?,listState: ClientListState) in
            let sceneCoordinator = r.resolve(SceneCoordinatorType.self)!
            let clientStorageService = r.resolve(ClientStorageServiceType.self)!
            return ClientViewModel(sceneCoordinator: sceneCoordinator, clientStorageService: clientStorageService, delegate: delegate, listState: listState)
        }
        container.register(NewClientViewModelType.self) { r in
            let sceneCoordinator = r.resolve(SceneCoordinatorType.self)!
            let clientStorageService = r.resolve(ClientStorageServiceType.self)!
            return NewClientViewModel(sceneCoordinator: sceneCoordinator, clientStorageService: clientStorageService)
        }
        container.register(EditClientViewModelType.self) { (r, client: ClientModel) in
            let sceneCoordinator = r.resolve(SceneCoordinatorType.self)!
            let clientStorageService = r.resolve(ClientStorageServiceType.self)!
            return EditClientViewModel(sceneCoordinator: sceneCoordinator, clientStorageService: clientStorageService, client: client)
        }
        
    }
}
