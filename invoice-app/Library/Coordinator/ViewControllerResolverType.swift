import Foundation
import UIKit

protocol ViewControllerResolverType {
    // Overview
    func companySelectController() -> CompanySelectViewController?
    // InvoiceViews
    func invoiceListController() -> InvoiceListViewController?
    func invoiceDetailController(invoice: InvoiceModel) -> InvoiceDetailViewController?
    func newInvoiceViewController() -> NewInvoiceViewController?
    func newItemViewController() -> NewItemViewController?
    // ClientsViews
    func clientsViewControler(delegate: ClientViewModelDelegate) -> ClientsViewController?
    func newClientViewController() -> NewClientViewController?
    func editClientViewController(client: ClientModel) -> EditClientViewController?
}
