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

    func changeRate(element: String) {
        changeRate.text = element
    }
}
