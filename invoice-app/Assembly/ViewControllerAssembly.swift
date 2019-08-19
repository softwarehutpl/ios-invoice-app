import Foundation
import Swinject


class ViewControllerAssembly: Assembly {
    var assembler: Assembler {
        return Assembler([self])
    }

    func assemble(container: Container) {
        ViewModelAssembly().assemble(container: container)

        container.register(CompanySelectViewController.self) { r in
            let viewModel = r.resolve(CompanySelectViewModel.self)!
            return CompanySelectViewController(with: viewModel)
        }

        container.register(InvoiceListViewController.self) { r in
            let viewModel = r.resolve(InvoiceListViewModel.self)!
            return InvoiceListViewController(with: viewModel)
        }
        
        container.register(InvoiceDetailViewController.self) { (r,invoice: InvoiceModel) in
            let viewModel = r.resolve(InvoiceDetailViewModel.self, argument: invoice)!
            return InvoiceDetailViewController(with: viewModel)
        }
        
        container.register(NewInvoiceViewController.self) { r in
            let viewModel = r.resolve(NewInvoiceViewModel.self)!
            return NewInvoiceViewController(with: viewModel)
        }

        
        
        
    }
}
