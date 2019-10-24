import UIKit

enum StartupScene {
    // OverView
    case overView
    
    // Invoice
    case invoiceList
    case invoiceDetail(invoice: InvoiceModel)
    case newInvoice(invoice: InvoiceModel?,formState: FormState)
    
    // Client
    case clientsView(delegate: ClientViewModelDelegate, listState: ClientListState)
    case newClientView
    case editClientView(client: ClientModel)
}



extension StartupScene: SceneType {
    func viewController(resolver: ViewControllerResolverType) -> UIViewController? {
        switch self {
        //Overview
        case .overView: return resolver.overViewViewController()
            
        //Invoice Views
        case .invoiceList: return resolver.invoiceListController()
        case .invoiceDetail(let invoice): return resolver.invoiceDetailController(invoice: invoice)
        case .newInvoice(let invoice, let formState): return resolver.newInvoiceViewController(invoice: invoice, formState: formState)
            
        //Client Views
        case .clientsView(let delegate, let listState): return resolver.clientsViewControler(delegate: delegate, listState: listState)
        case .newClientView: return resolver.newClientViewController()
        case .editClientView(let client): return resolver.editClientViewController(client: client)
        }
    }
}
