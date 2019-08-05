import Foundation

protocol ViewControllerResolverType {
    func companySelectController() -> CompanySelectViewController?
    func invoiceListController() -> InvoiceListViewController?
}
