import UIKit

extension ChangeController: ChangeDelegate {
    internal func messageErrorServerConnexionDelegate() {
        messageErrorServerConnexion()
    }

    internal func messageErrorLengthChangeInputDelegate() {
        messageErrorLengthChangeInput()
    }

    internal func updateChange(element: String) {
        change.text = element
    }

    internal func changeRate(element: String) {
        changeRate.text = element
    }
}
