import UIKit

class AppCoordinator {
    // MARK: - Private
    private let sceneCoordinator: SceneCoordinatorType
    private weak var window: UIWindow?
    
    // MARK: - Lifecycle
    init(sceneCoordinator: SceneCoordinatorType) {
        self.sceneCoordinator = sceneCoordinator
    }
}

extension AppCoordinator: AppCoordinatorType {
    func start(window: UIWindow) {
        sceneCoordinator.transition(to: StartupScene.companySelect, type: .root, source: nil)
        self.window = window
    }
}
