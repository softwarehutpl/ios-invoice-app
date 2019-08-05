import Foundation
import Swinject
import RxCocoa
import RxSwift

class  ViewControllerResolver {
    // MARK: - Private Properties
    private let assembler: Assembler
    
    // MARK: - Lifecycle
    init(assembler: Assembler) {
        self.assembler = assembler
    }
}

extension ViewControllerResolver: ViewControllerResolverType {
    func companySelectController() -> CompanySelectViewController? {
        return assembler.resolver.resolve(CompanySelectViewController.self)
    }
    
    func invoiceListController() -> InvoiceListViewController? {
        return assembler.resolver.resolve(InvoiceListViewController.self)
    }
}
