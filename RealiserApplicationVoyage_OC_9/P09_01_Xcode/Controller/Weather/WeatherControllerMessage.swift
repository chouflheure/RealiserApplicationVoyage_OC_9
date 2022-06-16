//
//  WeatherControllerMessage.swift
//  P09_01_Xcode
//
//  Created by charles Calvignac on 15/06/2022.
//

// import Foundation
import UIKit

extension WeatherViewController2 {

    func messageErrorOperator() {
        let alertVC = UIAlertController(title: "Error!",
                                        message: "We can't etablish a connection with the server ",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Retry", style: .default) { (_) in self.printData() })
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}
