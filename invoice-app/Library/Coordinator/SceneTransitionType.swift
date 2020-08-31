import Foundation

enum SceneTransitionType {
    case root
    case push
    case modal
    case customModal(direction: PresentationDirection)
}
