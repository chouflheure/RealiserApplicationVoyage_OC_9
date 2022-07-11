import Foundation

class Change {

    var currency: Currency!
    weak var delegate: ChangeDelegate?
    var apiKey = Bundle.main.object(forInfoDictionaryKey: "API_Key_Change") as? String

    public private (set) var value =  String()

    func callData() {

        guard let key = apiKey, !key.isEmpty else {
            apiKey = ""
            return
        }

        let urlBody = "http://data.fixer.io/api/latest"
        let urlAppid = "access_key=\(key)"
        let urlMoneyChange = "symbols=USD"

        let defaultUrl = URL(string:
                                urlBody
                                + "?" + urlAppid
                                + "&" + ""
            )

        let url = URL(string:
                            urlBody +
                            "?" + urlAppid +
                            "&" + urlMoneyChange )

        // We can unwrap default url because it's a true link
        URLSession.shared.dataTask(with: url ?? defaultUrl!) { data, _/*response*/, _ /*error*/ in
            DispatchQueue.main.async {
                do {
                    guard let data = data else {return }
                    self.currency = try JSONDecoder().decode(Currency.self, from: data)
                } catch {
                    self.delegate?.updateChange(element: "ERROR")
                }
            }
        }.resume()
    }

    // todo : - découper la méthode

    public func conversion(device: String, montant: String?) {
        guard let currency = currency, let rates = currency.rates["USD"] else {
            delegate?.updateChange(element: "ERROR")
            delegate?.messageErrorServerConnexionDelegate()
            return
        }

        guard let change = montant else {
            delegate?.updateChange(element: "0")
            delegate?.changeRate(element:
                                    "Taux de change \n"
                                    + " \n€ - $ : \(String(format: "%.2f", rates))"
                                    + " \n $ - € : \(String(format: "%.2f", 1/rates))"
            )
            return
        }

        guard let amount = Double(montant!) else {
            delegate?.updateChange(element: "0")
            delegate?.changeRate(element:
                                    "Taux de change \n"
                                    + " \n€ - $ : \(String(format: "%.2f", rates))"
                                    + " \n $ - € : \(String(format: "%.2f", 1/rates))"
            )
            return
        }

        if !amount.isLess(than: 1000000) {
            delegate?.updateChange(element: "ERROR")
            delegate?.messageErrorLengthChangeInputDelegate()
        }
        if change.isEmpty {
            delegate?.updateChange(element: "0.0")
        } else {
            if device == "Euro" {
                delegate?.updateChange(element: String(format: "%.2f $", amount * rates))
            } else {
                delegate?.updateChange(element: String(format: "%.2f €", amount / rates))
            }
            delegate?.changeRate(element:
                                    "Taux de change \n"
                                    + " \n€ - $ : \(String(format: "%.2f", rates))"
                                    + " \n $ - € : \(String(format: "%.2f", 1/rates))"
            )
        }
    }
}
