import Foundation

class Translate {

    var translate: TranslateDecode?
    var inputTranslate = String()
    var langueInputTranslate = String()

    weak var delegate: TranslateDelegate?

    func callApiToTranslate(callback: @escaping (Bool) -> Void) {

        // convert spacing by %20 in url
        let newString = inputTranslate.replacingOccurrences(of: " ", with: "%20", options: .literal)
        // newString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlBody = "https://api-free.deepl.com/v2/translate"

        // A modifier ( xconfig )
        let urlAppid = "auth_key=218cbfe4-65de-21d9-1cea-b987c94501c4:fx"

        let urlText = "text=\(newString)"
        let urlLangageSelected = "target_lang=\(langueInputTranslate)"

        let defaultUrl = URL(string:
                                urlBody
                                + "?" + urlAppid
                                + "&" + ""
                                + "&" + urlLangageSelected
            )

        let url = URL(string:
                    urlBody
                    + "?" + urlAppid
                    + "&" + urlText
                    + "&" + urlLangageSelected
        )

        URLSession.shared.dataTask(with: url ?? defaultUrl!) {data, _ /* response */, _ /*error*/ in
            DispatchQueue.main.async {
                do {
                    guard let data = data else { callback(false); return }
                    self.translate = try JSONDecoder().decode(TranslateDecode.self, from: data)
                    self.delegate?.updateTranslate(element: self.translate?.translations[0]["text"] ?? "")
                    callback(true)
                } catch {
                    callback(false)
                }
            }
        }.resume()
    }
}
