import Foundation

protocol ViewControllerResolverType {
    func companySelectController() -> CompanySelectViewController?
    func invoiceListController() -> InvoiceListViewController?
    func invoiceDetailController(invoice: InvoiceModel) -> InvoiceDetailViewController?
    func newInvoiceViewController() -> NewInvoiceViewController?
    func clientsViewControler(delegate: ClientViewModelDelegate) -> ClientsViewController?
    func newClientViewController() -> NewClientViewController?
    func editClientViewController(client: ClientModel) -> EditClientViewController?
}
