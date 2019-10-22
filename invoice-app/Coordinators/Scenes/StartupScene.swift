import UIKit

enum StartupScene {
    case companySelect
    // Invoice
    case invoiceList
    case invoiceDetail(invoice: InvoiceModel)
    case newInvoice(invoice: InvoiceModel?,formState: FormState)
    // Client
    case clientsView(delegate: ClientViewModelDelegate)
    case newClientView
    case editClientView(client: ClientModel)
}



extension StartupScene: SceneType {
    func viewController(resolver: ViewControllerResolverType) -> UIViewController? {
        switch self {
        //Overview
        case .companySelect: return resolver.companySelectController()
        //Invoice Views
        case .invoiceList: return resolver.invoiceListController()
        case .invoiceDetail(let invoice): return resolver.invoiceDetailController(invoice: invoice)
        case .newInvoice(let invoice, let formState): return resolver.newInvoiceViewController(invoice: invoice, formState: formState)
        //Client Views
        case .clientsView(let delegate): return resolver.clientsViewControler(delegate: delegate)
        case .newClientView: return resolver.newClientViewController()
        case .editClientView(let client): return resolver.editClientViewController(client: client)
        }
    }
}
