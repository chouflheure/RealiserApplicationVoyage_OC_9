import UIKit

extension ChangeController {

    func messageErrorOperation() {
        let alertVC = UIAlertController(title: "Erreur!",
                                        message: "Nous n'avons pas réussi à établir une conexion avec le serveur",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ressayer", style: .default) { (_) in self.dataRecept.callData() })
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }

    func messageErrorWidth() {
        let alertVC = UIAlertController(title: "Erreur!",
                                        message: "Montant trop important",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ressayer", style: .default) { (_) in self.dataRecept.callData() })
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}
