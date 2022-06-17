import Foundation
import Lottie
import UIKit

extension TranslateViewController: TranslateDelegate {
    func printBoard(element: String) {
        traductionText.text = element
    }
}
