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
        
        container.register(ClientsViewController.self) { (r,delegate: ClientViewModelDelegate) in
            let viewModel = r.resolve(ClientViewModel.self,argument: delegate)!
            return ClientsViewController(with: viewModel)
        }
        
        container.register(NewClientViewController.self) { r in
            let viewModel = r.resolve(NewClientViewModel.self)!
            return NewClientViewController(with: viewModel)
        }
        
        container.register(EditClientViewController.self) { (r, client: ClientModel) in
            let viewModel = r.resolve(EditClientViewModel.self, argument: client)!
            return EditClientViewController(with: viewModel)
        }
    }
}
