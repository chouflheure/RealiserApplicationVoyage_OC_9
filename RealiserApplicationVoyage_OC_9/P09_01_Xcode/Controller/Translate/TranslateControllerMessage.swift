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

    // TODO: - Mettre des commentaires
    // TODO: - déclarer les var en final
    // TODO : Nommage des var
    // TODO : class non utilisées => final
    // TODO : wrap
}
