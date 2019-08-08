
import UIKit

protocol InvoiceListViewModelType {
    var invoiceCount: Int { get }
    func getTestData(indexPath: Int) -> InvoiceModel
    func showInvoiceDetailView(source: UIViewController)
}
