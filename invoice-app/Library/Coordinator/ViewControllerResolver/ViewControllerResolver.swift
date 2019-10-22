import Foundation
import Swinject
import RxCocoa
import RxSwift
import UIKit

class ViewControllerResolver {
    
    // MARK: - Private Properties
    private let assembler: Assembler
    // MARK: - Lifecycle
    init(assembler: Assembler) {
        self.assembler = assembler
    }
}
extension ViewControllerResolver: ViewControllerResolverType {
    
    // Overview
    func companySelectController() -> CompanySelectViewController? {
           return assembler.resolver.resolve(CompanySelectViewController.self)
       }
    
    // InvoiceViews
    func invoiceListController() -> InvoiceListViewController? {
        return assembler.resolver.resolve(InvoiceListViewController.self)
    }
    func invoiceDetailController(invoice: InvoiceModel) -> InvoiceDetailViewController? {
        return assembler.resolver.resolve(InvoiceDetailViewController.self, argument: invoice)
    }
    func newInvoiceViewController(invoice: InvoiceModel?, formState: FormState) -> NewInvoiceViewController? {
        return assembler.resolver.resolve(NewInvoiceViewController.self, arguments: invoice, formState)
    }
    
    // ClientViews
    func clientsViewControler(delegate: ClientViewModelDelegate) -> ClientsViewController? {
        return assembler.resolver.resolve(ClientsViewController.self, argument: delegate)
    }
    func newClientViewController() -> NewClientViewController? {
        return assembler.resolver.resolve(NewClientViewController.self)
    }
    func editClientViewController(client: ClientModel) -> EditClientViewController? {
        return assembler.resolver.resolve(EditClientViewController.self, argument: client)
    }
}
