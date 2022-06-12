import UIKit

extension ChangeController: ChangeDelegate {
    func callMessageErrorOperator() {
        messageErrorOperator()
    }

    func callMessageErrorWidth() {
        messageErrorWidth()
    }

    func printBoard(element: String) {
        change.text = element
    }
}
