import UIKit


class InvoiceListViewModel {
    
    // Base Data
    var baseInvoices = [InvoiceModel]()
    
    // Filtered Data
    var invoicesToShow = [InvoiceModel]()
    
    // Filtering from SearchBar
    enum filteringType: Int {
        case allinvoices = 0
        case paidinvoices = 1
        case unpaidinvoices = 2
    }
    
    // MARK: - Private
    private let sceneCoordinator: SceneCoordinatorType
    
    // MARK: - Lifecycle
    init(sceneCoordinator: SceneCoordinatorType) {
        self.sceneCoordinator = sceneCoordinator
        loadTestData()
    }
    
    // Holds currently sorting type
    var filteredIndex = filteringType.allinvoices.rawValue {
        didSet {
            filtering()
        }
    }
    
    // Holds string to search
    var searchingString: String = "" {
        didSet {
            print(searchingString)
            filtering()
        }
    }
    
    private func filtering() {
        invoicesToShow.removeAll()
        if searchingString.isEmpty {
            switch filteredIndex {
            case filteringType.allinvoices.rawValue:
                invoicesToShow = baseInvoices
            case filteringType.paidinvoices.rawValue:
                invoicesToShow.append(contentsOf: baseInvoices.filter({ $0.status == true }))
            case filteringType.unpaidinvoices.rawValue:
                invoicesToShow.append(contentsOf: baseInvoices.filter({ $0.status == false}))
            default:
                fatalError("Filtering not specified")
            }
        } else {
            switch filteredIndex {
            case filteringType.allinvoices.rawValue:
                invoicesToShow.append(contentsOf: baseInvoices.filter({$0.customer.name.lowercased().contains(searchingString.lowercased())}))
            case filteringType.paidinvoices.rawValue:
                invoicesToShow.append(contentsOf: baseInvoices.filter({ $0.status == true && $0.customer.name.lowercased().contains(searchingString.lowercased())}))
            case filteringType.unpaidinvoices.rawValue:
                invoicesToShow.append(contentsOf: baseInvoices.filter({ $0.status == false && $0.customer.name.lowercased().contains(searchingString.lowercased())}))
                
            default:
                fatalError("Filtering not specified")
            }
        }
    }
    // Loading fake data into view
    private func loadTestData() {
        
        let invoice1 = InvoiceModel(invoiceTitle: "Invoice1", date: "01-01-2019", amount: "5000", status: false, customer: Customer(name: "Cameron Bradley", email: "mail@icloud.com", phone: "694329911", address: "2055 Niagara Falls Blvd, Amherst NY 14228"), itemDescription: [ItemDescription(itemName: "Application Development", amount: "14000", price: "1000")])
        let invoice2 = InvoiceModel(invoiceTitle: "Invoice2", date: "01-01-2019", amount: "3200", status: true, customer: Customer(name: "Floyd Thomas", email: "mail@icloud.com", phone: "694329911", address: "20 Soojian Dr, Leicester MA 1524"), itemDescription: [ItemDescription(itemName: "Application Development", amount: "3", price: "990")])
        let invoice3 = InvoiceModel(invoiceTitle: "Invoice3", date: "01-01-2019", amount: "1340", status: false, customer: Customer(name: "Cecilia Simon", email: "mail@icloud.com", phone: "694329911", address: "66-4 Parkhurst Rd, Chelmsford MA 1824"), itemDescription: [ItemDescription(itemName: "Application Development", amount: "1", price: "400")])
        let invoice4 = InvoiceModel(invoiceTitle: "Invoice4", date: "01-01-2019", amount: "2900", status: false, customer: Customer(name: "Archie Mendez", email: "mail@icloud.com", phone: "694329911", address: "700 Oak Street, Brockton MA 2301"), itemDescription: [ItemDescription(itemName: "Application Development", amount: "4", price: "5300")])
        let invoice5 = InvoiceModel(invoiceTitle: "Invoice5", date: "01-01-2019", amount: "8500", status: true, customer: Customer(name: "Edward Rios", email: "mail@icloud.com", phone: "694329911", address: "250 Hartford Avenue, Bellingham MA 2019"), itemDescription: [ItemDescription(itemName: "Application Development", amount: "1", price: "12000")])
        let invoice6 = InvoiceModel(invoiceTitle: "Invoice6", date: "01-01-2019", amount: "400", status: true, customer: Customer(name: "Beatrice Pratt", email: "mail@icloud.com", phone: "694329911", address: "30 Memorial Drive, Avon MA 2322"), itemDescription: [ItemDescription(itemName: "Application Development", amount: "2", price: "3200")])
        let invoice7 = InvoiceModel(invoiceTitle: "Invoice7", date: "01-01-2019", amount: "2500", status: false, customer: Customer(name: "Jeremiah Banks", email: "mail@icloud.com", phone: "694329911", address: "777 Brockton Avenue, Abington MA 2351"), itemDescription: [ItemDescription(itemName: "Application Development", amount: "1", price: "1000"), ItemDescription(itemName: "Design App", amount: "2", price: "500")])
        
        baseInvoices += [invoice1, invoice2,invoice3, invoice4, invoice5, invoice6, invoice7]
        invoicesToShow = baseInvoices
    }
}

extension InvoiceListViewModel: InvoiceListViewModelType, SegmentControllerProtocol {
    
    func showInvoiceDetailView(source: UIViewController, invoice: InvoiceModel) {
        sceneCoordinator.transition(to: StartupScene.invoiceDetail(invoice: invoice), type: .push, source: source)
    }
    
    @objc func showNewInvoiceView(source: UIViewController) {
        sceneCoordinator.transition(to: StartupScene.newInvoice, type: .push, source: source)
    }
        
    func searchingText(searchingText: String) {
        searchingString = searchingText
    }
    
    func changeFilteringType(index: Int) {
        filteredIndex = index
    }
    
    func getFilteringIndex() {
        filteredIndex = menuBar.selectedIndex ?? 0
    }
    
    func passFilteringIndexType(index: Int) {
        filteredIndex = index
    }
    
    var getInvoiceCount: Int {
        return invoicesToShow.count
    }
    
    func getInvoices(indexPath: Int) -> InvoiceModel {
        return invoicesToShow[indexPath]
    }
}
