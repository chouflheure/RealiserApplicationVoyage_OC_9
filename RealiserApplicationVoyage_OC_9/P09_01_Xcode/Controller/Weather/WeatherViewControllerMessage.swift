//
//  WeatherControllerMessage.swift
//  P09_01_Xcode
//
//  Created by charles Calvignac on 15/06/2022.
//

// import Foundation
import UIKit

extension WeatherPageViewController {

    func messageErrorServerConnexion() {
        let alertVC = UIAlertController(title: "Error!",
                                        message: "Nous n'avons pas réussi à établir une conexion avec le serveur",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}
