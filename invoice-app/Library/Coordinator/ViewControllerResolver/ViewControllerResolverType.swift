import Foundation
import UIKit

protocol ViewControllerResolverType {
    // Base Tabbar
    func baseTabBarController() -> BaseTabBarController?
    // Overview
    func overViewViewController() -> OverViewViewController?
    // InvoiceViews
    func invoiceListController() -> InvoiceListViewController?
    func invoiceDetailController(invoice: InvoiceModel) -> InvoiceDetailViewController?
    func newInvoiceViewController(invoice: InvoiceModel?, formState: FormState) -> NewInvoiceViewController?
    // ClientsViews
    func clientsViewControler(delegate: ClientViewModelDelegate?,listState: ClientListState) -> ClientsViewController?
    func newClientViewController() -> NewClientViewController?
    func editClientViewController(client: ClientModel) -> EditClientViewController?
}
