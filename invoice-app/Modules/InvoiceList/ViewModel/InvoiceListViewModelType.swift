import Foundation

protocol InvoiceListViewModelType {
    var invoiceCount: Int { get }
    func getTestData(indexPath: Int) -> InvoiceModel
}
