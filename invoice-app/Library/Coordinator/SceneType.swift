import UIKit
import Swinject

protocol SceneType {
    func viewController(resolver: ViewControllerResolverType) -> UIViewController?
}
