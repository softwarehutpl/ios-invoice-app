
import UIKit

protocol InvoiceListViewModelType {
    var getInvoiceCount: Int { get }
    
    func showInvoiceDetailView(source: UIViewController, invoice: InvoiceModel)
    func showNewInvoiceView(source: UIViewController)
    func fetchInvoicesFromCoreData()
    func getInvoices(indexPath: Int) -> InvoiceModel
    func changeFilteringType(index: Int)
    func getFilteringIndex()
    func searchingText(searchingText: String)
}
