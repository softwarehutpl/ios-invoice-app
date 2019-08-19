import UIKit

protocol CompanySelectViewModelType {
    func showList(source: UIViewController)
    func companyModel(indexPath: Int) -> CompanyModel
    func toggleIsExpanded(at indexPath: IndexPath)
    var companyCount: Int { get }
    func changeParameter (letter: String)
}
