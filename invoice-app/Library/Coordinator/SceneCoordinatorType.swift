import UIKit
import RxSwift
import Swinject

protocol SceneCoordinatorType {
    var currentViewController: UIViewController? { get }
    
    @discardableResult
    func transition(to scene: SceneType, type: SceneTransitionType, source: UIViewController?) -> Completable

    @discardableResult
    func pop(source: UIViewController?, animated: Bool) -> Completable

    @discardableResult
    func pop(source: UIViewController?, to controllerType: UIViewController.Type, animated: Bool) -> Completable
    
    @discardableResult
    func openURL(_ url: URL) -> Completable
}
