import Foundation
import Lottie
import UIKit

extension TranslateViewController: TranslateDelegate {
    func updateTranslate(element: String) {
        traductionText.text = element
    }
}
