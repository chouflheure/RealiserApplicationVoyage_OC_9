import UIKit

extension ChangeController {

    func messageErrorOperator() {
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

    func messageChangeRate() {
        guard let changed = dataRecept.usd, let rates = changed.rates["USD"] else {return}
        changeRate.text = "Taux de change \n\n"
        + " \n€ - $ : \(String(format: "%.2f", rates))"
        + " \n\n $ - € : \(String(format: "%.2f", 1/rates))"
    }
}
