import UIKit


class InvoiceListViewModel {
    
    var testData = [InvoiceModel]()
    // MARK: - Private
    private let sceneCoordinator: SceneCoordinatorType
    
    // MARK: - Lifecycle
    init(sceneCoordinator: SceneCoordinatorType) {
        self.sceneCoordinator = sceneCoordinator
        loadTestData()
    }
    private func loadTestData() {
        for _ in 0...30 {
            let testInvoice = InvoiceModel(name: "InvoiceTestLabel", price: "1000$")
            testData.append(testInvoice)
        }
    }
}

extension InvoiceListViewModel: InvoiceListViewModelType {
    var invoiceCount: Int {
        return testData.count
    }
    func getTestData(indexPath: Int) -> InvoiceModel {
        return testData[indexPath]
    }
}
