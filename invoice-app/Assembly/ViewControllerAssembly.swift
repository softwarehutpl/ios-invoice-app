import Foundation
import Swinject


class ViewControllerAssembly: Assembly {
    var assembler: Assembler {
        return Assembler([self])
    }

    func assemble(container: Container) {
        ViewModelAssembly().assemble(container: container)
        // Overview
        container.register(CompanySelectViewController.self) { r in
            let viewModel = r.resolve(CompanySelectViewModelType.self)!
            return CompanySelectViewController(with: viewModel)
        }
        
        // Invoice Views
        container.register(InvoiceListViewController.self) { r in
            let viewModel = r.resolve(InvoiceListViewModelType.self)!
            return InvoiceListViewController(with: viewModel)
        }
        container.register(InvoiceDetailViewController.self) { (r,invoice: InvoiceModel) in
            let viewModel = r.resolve(InvoiceDetailViewModelType.self, argument: invoice)!
            return InvoiceDetailViewController(with: viewModel)
        }
        container.register(NewInvoiceViewController.self) { r in
            let viewModel = r.resolve(NewInvoiceViewModelType.self)!
            return NewInvoiceViewController(with: viewModel)
        }
        container.register(NewItemViewController.self) { r in
            let viewModel = r.resolve(NewItemViewModelType.self)!
            return NewItemViewController(with: viewModel)
        }
        
        // Client Views
        container.register(ClientsViewController.self) { (r,delegate: ClientViewModelDelegate) in
            let viewModel = r.resolve(ClientViewModelType.self, argument: delegate)!
            return ClientsViewController(with: viewModel)
        }
        container.register(NewClientViewController.self) { r in
            let viewModel = r.resolve(NewClientViewModelType.self)!
            return NewClientViewController(with: viewModel)
        }
        container.register(EditClientViewController.self) { (r, client: ClientModel) in
            let viewModel = r.resolve(EditClientViewModelType.self, argument: client)!
            return EditClientViewController(with: viewModel)
        }
    }
}
