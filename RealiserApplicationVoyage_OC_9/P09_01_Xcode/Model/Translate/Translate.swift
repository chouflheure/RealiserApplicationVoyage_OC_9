import Foundation

class Translate {

    var dataTranslate: DataInfoTranslate!
    var inputTranslate = String()
    var langueInputTranslate = String()

    weak var delegate: TranslateDelegate?

    // https://api-free.deepl.com/v2/translate
    // ?auth_key=218cbfe4-65de-21d9-1cea-b987c94501c4:fx
    // &text=Hello, world
    // &target_lang=FR

    func callData(callback: @escaping (Bool) -> Void) {
        // delegate?.animation(animated: true)
        let urlBody = "https://api-free.deepl.com/v2/translate"
        let urlAppid = "auth_key=218cbfe4-65de-21d9-1cea-b987c94501c4:fx"
        let urlText = "text=\(inputTranslate)"
        let urlLangage = "target_lang=\(langueInputTranslate)"

        let defaultUrl = URL(string:
                                urlBody
                                + "?" + urlAppid
                                + "&" + ""
                                + "&" + urlLangage
            )

        let url = URL(string:
                    urlBody
                    + "?" + urlAppid
                    + "&" + urlText
                    + "&" + urlLangage
        )

        URLSession.shared.dataTask(with: url ?? defaultUrl!) { data, response, error in
            DispatchQueue.main.async {
                do {
                    guard let data = data else { callback(false); return }
                    self.dataTranslate = try JSONDecoder().decode(DataInfoTranslate.self, from: data)
                    print(self.dataTranslate.translations[0]["text"] ?? "")
                    print("data")
                    print(data)
                    self.delegate?.printBoard(element: self.dataTranslate.translations[0]["text"] ?? "")
                    callback(true)
                } catch {
                    callback(false)
                }
            }
        }.resume()
    }
}
