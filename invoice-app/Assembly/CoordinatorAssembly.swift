import Foundation
import Swinject

class CoordinatorAssembly: Assembly {
    
    var coordinatorAssembler: Assembler {
        return Assembler([self, ViewControllerAssembly()])
    }
    
    func assemble(container: Container) {
        ManagerAssembly().assemble(container: container)
        container.register(ViewControllerResolver.self) { resolver in
            return ViewControllerResolver(assembler: self.coordinatorAssembler)
        }
        
        container.register(AppCoordinator.self) { resolver in
            let coordinator = resolver.resolve(SceneCoordinatorType.self)!
            return AppCoordinator(sceneCoordinator: coordinator)
        }
        
        container.register(SceneCoordinatorType.self) { resolver in
            let presenter = resolver.resolve(PresentationManagerType.self)!
            return SceneCoordinator(resolver: resolver.resolve(ViewControllerResolver.self)!, presentationManager: presenter)
        }
    }
}
