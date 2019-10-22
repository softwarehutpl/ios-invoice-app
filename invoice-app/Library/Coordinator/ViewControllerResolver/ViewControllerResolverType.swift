import Foundation
import UIKit

protocol ViewControllerResolverType {
    
    // Overview
    func companySelectController() -> CompanySelectViewController?
    // InvoiceViews
    func invoiceListController() -> InvoiceListViewController?
    func invoiceDetailController(invoice: InvoiceModel) -> InvoiceDetailViewController?
    func newInvoiceViewController(invoice: InvoiceModel?, formState: FormState) -> NewInvoiceViewController?
    // ClientsViews
    func clientsViewControler(delegate: ClientViewModelDelegate) -> ClientsViewController?
    func newClientViewController() -> NewClientViewController?
    func editClientViewController(client: ClientModel) -> EditClientViewController?
}
