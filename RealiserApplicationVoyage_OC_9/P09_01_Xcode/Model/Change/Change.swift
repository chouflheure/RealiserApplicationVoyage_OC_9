import Foundation

class Change {

    var usd: Currency!
    weak var delegate: ChangeDelegate?

    func callData() {

        let urlBody = "http://data.fixer.io/api/latest"
        let urlAppid = "access_key=8663c04304d05e8fdf3fcf4ba739e09b"
        let urlMoneyChange = "symbols=USD"

        let url = URL(string:
                            urlBody +
                            "?" + urlAppid +
                            "&" + urlMoneyChange )

        URLSession.shared.dataTask(with: url!) { data, response, error in
            DispatchQueue.main.async {
                do {
                    guard let data = data else {return }
                    self.usd = try JSONDecoder().decode(Currency.self, from: data)
                } catch {
                    print(error)
                    print(response ?? "good")
                }
            }
        }.resume()
    }

    func conversion(device: String, montant: String?) {
        guard let usd = usd, let rates = usd.rates["USD"] else {
            delegate?.printBoard(element: "ERROR")
            delegate?.callMessageErrorOperator()
            return
        }

        guard let change = montant else {
            delegate?.printBoard(element: "00")
            return
        }

        guard let montant = Double(montant!) else {
            delegate?.printBoard(element: "00")
            return
        }

        if !montant.isLess(than: 1000000) {
            delegate?.printBoard(element: "ERROR")
            delegate?.callMessageErrorWidth()
        }
        if change.isEmpty {
            delegate?.printBoard(element: "0.0")
        } else {
            if device == "Euro" {
                delegate?.printBoard(element: String(format: "%.2f $", montant * rates))
            } else {
                delegate?.printBoard(element: String(format: "%.2f $", montant / rates))
            }
        }
    }
}
