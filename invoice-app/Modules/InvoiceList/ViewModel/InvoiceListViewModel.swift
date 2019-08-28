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
    private let invoiceStorageService: InvoiceStorageServiceType
    
    // MARK: - Lifecycle
    init(sceneCoordinator: SceneCoordinatorType, invoiceStorageService: InvoiceStorageServiceType) {
        self.sceneCoordinator = sceneCoordinator
        self.invoiceStorageService = invoiceStorageService
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
                invoicesToShow.append(contentsOf: baseInvoices.filter({$0.client.name.lowercased().contains(searchingString.lowercased())}))
            case filteringType.paidinvoices.rawValue:
                invoicesToShow.append(contentsOf: baseInvoices.filter({ $0.status == true && $0.client.name.lowercased().contains(searchingString.lowercased())}))
            case filteringType.unpaidinvoices.rawValue:
                invoicesToShow.append(contentsOf: baseInvoices.filter({ $0.status == false && $0.client.name.lowercased().contains(searchingString.lowercased())}))
                
            default:
                fatalError("Filtering not specified")
            }
        }
    }
    // Loading fake data into view
    private func loadTestData() {
        //        let invoice1 = InvoiceModel(invoiceTitle: "TestTitle", date: "TestDate", dueDate: "01-01-01", amount: "100", status: true, client: ClientModel(name: "abc", email: "abc@wp.pl", phone: "694521521", address: "adres", postcode: "postcode", city: "city", country: "country"), items: [ItemModel(itemName: "item", amount: "100", price: "200")])
        
        //        baseInvoices += [invoice1]
        //        invoicesToShow = baseInvoices
        //    }
    }
}

extension InvoiceListViewModel: InvoiceListViewModelType, SegmentControllerProtocol {
    
    func fetchInvoicesFromCoreData() {
        self.baseInvoices = invoiceStorageService.fetchInvoice()
        invoicesToShow = baseInvoices
    }
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
