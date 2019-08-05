import UIKit

class InvoiceListViewModel {
    // MARK: - Private
    private let sceneCoordinator: SceneCoordinatorType
    
    // MARK: - Lifecycle
    init(sceneCoordinator: SceneCoordinatorType) {
        self.sceneCoordinator = sceneCoordinator
    }
}

extension InvoiceListViewModel: InvoiceListViewModelType {
    
}
