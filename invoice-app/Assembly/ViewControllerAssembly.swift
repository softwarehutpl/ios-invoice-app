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
    }
}

