import UIKit

enum StartupScene {
    case companySelect
    // Invoice
    case invoiceList
    case invoiceDetail(invoice: InvoiceModel)
    case newInvoice
    // Client
    case clientsView(delegate: ClientViewModelDelegate)
    case newClientView
    case editClientView(client: ClientModel)
}

extension StartupScene: SceneType {
    func viewController(resolver: ViewControllerResolverType) -> UIViewController? {
        switch self {
        case .companySelect: return resolver.companySelectController()
        case .invoiceList: return resolver.invoiceListController()
        case .invoiceDetail(let invoice): return resolver.invoiceDetailController(invoice: invoice)
        case .newInvoice: return resolver.newInvoiceViewController()
        case .clientsView(let delegate): return resolver.clientsViewControler(delegate: delegate)
        case .newClientView: return resolver.newClientViewController()
        case .editClientView(let client): return resolver.editClientViewController(client: client)
        }
    }
}
