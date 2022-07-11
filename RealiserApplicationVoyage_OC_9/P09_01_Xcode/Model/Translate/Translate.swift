import Foundation

class Translate {

    var translate: TranslateDecode?
    var inputTranslate = String()
    var langueInputTranslate = String()
    var apiKey = Bundle.main.object(forInfoDictionaryKey: "API_Key_Translate") as? String

    weak var delegate: TranslateDelegate?

    func callApiToTranslate(callback: @escaping (Bool) -> Void) {

        // convert spacing by %20 in url
        let stringUrl = inputTranslate.replacingOccurrences(of: " ", with: "%20", options: .literal)

        guard let key = apiKey, !key.isEmpty else {
            apiKey = ""
            return
        }

        let urlBody = "https://api-free.deepl.com/v2/translate"
        let urlAppid = "auth_key=\(key)"
        let urlText = "text=\(stringUrl)"
        let urlLangageSelected = "target_lang=\(langueInputTranslate)"

        let defaultUrl = URL(string:
                                urlBody
                                + "?" + ""
                                + "&" + ""
                                + "&" + urlLangageSelected
            )

        let url = URL(string:
                    urlBody
                    + "?" + urlAppid
                    + "&" + urlText
                    + "&" + urlLangageSelected
        )

        URLSession.shared.dataTask(with: url ?? defaultUrl!) {data, _ /* response */, error in
            DispatchQueue.main.async {
                do {
                    guard let data = data else { callback(false); return }
                    self.translate = try JSONDecoder().decode(TranslateDecode.self, from: data)
                    self.delegate?.updateTranslate(element: self.translate?.translations[0]["text"] ?? "")
                    callback(true)
                } catch {
                    callback(false)
                    print(error)
                }
            }
        }.resume()
    }
}
