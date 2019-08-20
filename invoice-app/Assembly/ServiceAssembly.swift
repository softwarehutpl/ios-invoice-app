import Foundation
import Swinject

class ServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PersistanceManager.self) { _ in
            return PersistanceManager()
        }
    }
}
