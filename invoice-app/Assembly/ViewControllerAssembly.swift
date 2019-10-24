import Foundation
import Swinject


class ViewControllerAssembly: Assembly {
    var assembler: Assembler {
        return Assembler([self])
    }

    func assemble(container: Container) {
        ViewModelAssembly().assemble(container: container)
        
        // Overview
        container.register(BaseTabBarController.self) { r in
            let viewModel = r.resolve(BaseTabBarViewModelType.self)!
            let resolver = r.resolve(ViewControllerResolverType.self)!
            return BaseTabBarController(viewModel: viewModel, resolver: resolver)
        }
        
        container.register(OverViewViewController.self) { r in
            let viewModel = r.resolve(OverViewViewModelType.self)!
            return OverViewViewController(viewModel: viewModel)
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
        container.register(NewInvoiceViewController.self) { (r, invoice: InvoiceModel?, formState: FormState) in
            let newInvoiceViewModel = r.resolve(NewInvoiceViewModelType.self, arguments: invoice, formState)!
            return NewInvoiceViewController(with: newInvoiceViewModel)
        }
        
        // Client Views
        container.register(ClientsViewController.self) { (r,delegate: ClientViewModelDelegate?, listState: ClientListState) in
            let viewModel = r.resolve(ClientViewModelType.self, arguments: delegate, listState)!
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
