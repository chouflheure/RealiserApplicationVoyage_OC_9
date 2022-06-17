import UIKit

extension ChangeController: ChangeDelegate {
    func callMessageErrorOperation() {
        messageErrorOperation()
    }

    func callMessageErrorWidth() {
        messageErrorWidth()
    }

    func printBoard(element: String) {
        change.text = element
    }

    func changeRate(element: String) {
        changeRate.text = element
    }
}
