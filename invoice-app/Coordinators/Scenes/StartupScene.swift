import UIKit

enum StartupScene {
    case companySelect
    case invoiceList
    case invoiceDetail(invoice: InvoiceModel)
    case newInvoice
    case clientsView
    case newClientView
}

extension StartupScene: SceneType {
    func viewController(resolver: ViewControllerResolverType) -> UIViewController? {
        switch self {
        case .companySelect: return resolver.companySelectController()
        case .invoiceList: return resolver.invoiceListController()
        case .invoiceDetail(let invoice): return resolver.invoiceDetailController(invoice: invoice)
        case .newInvoice: return resolver.newInvoiceViewController()
        case .clientsView: return resolver.clientsViewControler()
        case .newClientView: return resolver.newClientViewController()
        }
    }
}
