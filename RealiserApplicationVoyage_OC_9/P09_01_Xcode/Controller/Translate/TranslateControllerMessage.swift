import UIKit

extension TranslateViewController {

    func messageErrorServerConnexion() {
        let alertVC = UIAlertController(title: "Erreur!",
                                        message: "Nous n'avons pas réussi à établir une conexion avec le serveur",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }

    func messageErrorLenghtTextInput() {
        let alertVC = UIAlertController(title: "Erreur!",
                                        message: "Text trop long",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }

    // todo: Mettre des commentaires
    // todo: déclarer les var en final
    // todo: Nommage des var
    // todo: class non utilisées => final
    // todo: wrap
}
