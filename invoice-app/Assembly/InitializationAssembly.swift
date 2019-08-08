
import Foundation
import Swinject

class InitializationAssembly {
    func resolveDependencies(appDelegate: AppDelegate) {
        let assembler = Assembler([CoordinatorAssembly()])
        appDelegate.appCoordinator = assembler.resolver.resolve(AppCoordinator.self)
    }
}
