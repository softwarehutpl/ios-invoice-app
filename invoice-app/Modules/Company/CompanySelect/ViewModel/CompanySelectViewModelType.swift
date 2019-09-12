import UIKit

protocol CompanySelectViewModelType {
    func showList(source: UIViewController)
    func companyModel(indexPath: Int) -> CompanyModel
    var companyCount: Int { get }
}
