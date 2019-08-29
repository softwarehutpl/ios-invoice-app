import Foundation
import Swinject

class ServiceAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(PersistanceManager.self) { _ in
            return PersistanceManager()
        }
        container.register(ClientStorageService.self) { r in
            return ClientStorageService(persistanceManager: r.resolve(PersistanceManager.self)!)
        }
        container.register(InvoiceStorageService.self) { r in
            return InvoiceStorageService(persistanceManager: r.resolve(PersistanceManager.self)!)
        }
    }
}
