import UIKit
import Swinject
import RxSwift
import RxCocoa

enum CoordinatorError: Error {
    case navigationError(reason: String?)
}

class SceneCoordinator {
    
    // MARK: - Private Properties
    private let resolver: ViewControllerResolverType
    
    // MARK: - Properties
    var currentViewController: UIViewController?
    
    // MARK: - Lifecycle
    init(resolver: ViewControllerResolverType) {
        self.resolver = resolver
    }
    
    func actualViewController(for viewController: UIViewController) -> UIViewController {
        if let navigationController = viewController as? UINavigationController {
            return navigationController.viewControllers.first!
        } else {
            return viewController
        }
    }
}

extension SceneCoordinator: SceneCoordinatorType {
    @discardableResult
    func transition(to scene: SceneType, type: SceneTransitionType, source: UIViewController? = nil) -> Completable {
        let subject = PublishSubject<Void>()
        guard let viewController = scene.viewController(resolver: resolver) else {
            subject.onError(CoordinatorError.navigationError(reason: ""))
            return subject.asObservable()
                    .take(1)
                    .ignoreElements()
        }
        switch type {
        case .root:
            guard let app = UIApplication.shared.delegate as? AppDelegate else {
                subject.onError(CoordinatorError.navigationError(reason: ""))
                return subject.asObservable()
                        .take(1)
                        .ignoreElements()
            }
            let nvc = BaseNavigationController(rootViewController: viewController)
            app.window?.rootViewController = nvc
            subject.onCompleted()

        case .push:
            guard let source = source, let navController = source.navigationController else {
                subject.onError(CoordinatorError.navigationError(reason: ""))
                return subject.asObservable()
                        .take(1)
                        .ignoreElements()
            }

            _ = navController.rx.delegate
                    .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                    .map { _ in }
                    .bind(to: subject)
            navController.pushViewController(viewController, animated: true)
            currentViewController = actualViewController(for: viewController)

        case .modal:
            guard let source = source else {
                subject.onError(CoordinatorError.navigationError(reason: ""))
                return subject.asObservable()
                        .take(1)
                        .ignoreElements()
            }
            currentViewController = actualViewController(for: viewController)
            source.present(viewController, animated: true) {
                subject.onCompleted()
            }
        }
        return subject.asObservable()
                .take(1)
                .ignoreElements()
    }

    @discardableResult
    func pop(source: UIViewController?, animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()
        guard let strongSource = source else {
            subject.onError(CoordinatorError.navigationError(reason: ""))
            return subject.asObservable()
                    .take(1)
                    .ignoreElements()
        }
        if let _ = strongSource.presentingViewController {
            strongSource.dismiss(animated: animated) {
                subject.onCompleted()
            }
        } else if let navigationController = strongSource.navigationController {
            _ = navigationController.rx.delegate
                    .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                    .map { _ in }
                    .bind(to: subject)
            guard navigationController.popViewController(animated: animated) != nil else {
                fatalError("can't navigate back from \(strongSource)")
            }
            currentViewController = actualViewController(for: navigationController.viewControllers.last!)
        } else {
            fatalError("Not a modal, no navigation controller: can't navigate back from \(strongSource)")
        }
        return subject.asObservable()
                .take(1)
                .ignoreElements()
    }

    func pop(source: UIViewController?, to controllerType: UIViewController.Type, animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()
        guard let strongSource = source, let nav = strongSource.navigationController else {
            subject.onError(CoordinatorError.navigationError(reason: ""))
            return subject.asObservable()
                    .take(1)
                    .ignoreElements()
        }
        let controllers = nav.viewControllers.filter { type(of: $0.self) == controllerType }
        guard let destination = controllers.first else {
            subject.onError(CoordinatorError.navigationError(reason: ""))
            return subject.asObservable()
                    .take(1)
                    .ignoreElements()
        }

        if let _ = strongSource.presentingViewController {
            strongSource.dismiss(animated: animated) {
                subject.onCompleted()
            }
        } else if let navigationController = strongSource.navigationController {
            _ = navigationController.rx.delegate
                    .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                    .map { _ in }
                    .bind(to: subject)
            navigationController.popToViewController(destination, animated: true)
            currentViewController = actualViewController(for: navigationController.viewControllers.last!)
        } else {
            fatalError("Not a modal, no navigation controller: can't navigate back from \(strongSource)")
        }


        return subject.asObservable()
                .take(1)
                .ignoreElements()
    }

    @discardableResult
    func openURL(_ url: URL) -> Completable {
        let subject = PublishSubject<Void>()
        
        UIApplication.shared.open(url, options: [:]) { result in
            result ? subject.onCompleted() : subject.onError(CoordinatorError.navigationError(reason: ""))
        }
        
        return subject.asObservable()
                .take(1)
                .ignoreElements()
    }
}
