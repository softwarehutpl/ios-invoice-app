import UIKit

enum StartupScene {
    case companySelect
    case invoiceList
}

extension StartupScene: SceneType {
    func viewController(resolver: ViewControllerResolverType) -> UIViewController? {
        switch self {
        case .companySelect: return resolver.companySelectController()
        case .invoiceList: return resolver.invoiceListController()
        }
    }
}
