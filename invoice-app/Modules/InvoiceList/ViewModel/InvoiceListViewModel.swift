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
    // Loading fake data into view
    private func loadTestData() {
        for _ in 0...30 {
            let uniqueTitle = UUID().uuidString
            let uniquePrice = UUID().hashValue
            let randomStatus = Bool.random()
            let testInvoice = InvoiceModel(title: "Title \(uniqueTitle)", clientName: "ClientName", date: "08-08-2019", amount: "PLN \(uniquePrice)", status: randomStatus)
            testData.append(testInvoice)
        }
    }
}


extension InvoiceListViewModel: InvoiceListViewModelType {
    func showInvoiceDetailView(source: UIViewController) {
        print("Showing detail view")
    }
    
    var invoiceCount: Int {
        return testData.count
    }
    
    func getTestData(indexPath: Int) -> InvoiceModel {
        return testData[indexPath]
    }
}
