//
//  Translate.swift
//  P09_01_Xcode
//
//  Created by charles Calvignac on 15/11/2021.
//

import Foundation

class Translate {

    var dataTranslate: DataInfoTranslate!
    var inputTranslate = String()
    var langueInputTranslate = String()

    weak var delegate: TranslateDataSource?

    // https://api-free.deepl.com/v2/translate
    // ?auth_key=218cbfe4-65de-21d9-1cea-b987c94501c4:fx
    // &text=Hello, world
    // &target_lang=FR

    func callData(callback: @escaping (Bool) -> Void) {
        let urlBody = "https://api-free.deepl.com/v2/translate"
        let urlAppid = "auth_key=218cbfe4-65de-21d9-1cea-b987c94501c4:fx"
        let urlText = "text=\(inputTranslate)"
        let urlLangage = "target_lang=\(langueInputTranslate)"

        let url = URL(string:
                    urlBody
                    + "?" + urlAppid
                    + "&" + urlText
                    + "&" + urlLangage )
                    // + "&" + urlMoneyChange )

        URLSession.shared.dataTask(with: url!) { data, response, error in
            DispatchQueue.main.async {
                do {
                    guard let data = data else {return }
                    print(data)
                    self.dataTranslate = try JSONDecoder().decode(DataInfoTranslate.self, from: data)
                } catch {
                    print(error)
                    print(response ?? "good")
                }
            }
        }.resume()
    }
}
