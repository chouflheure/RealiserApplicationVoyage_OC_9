//
//  DecodableStruct.swift
//  P09_01_Xcode
//
//  Created by charles Calvignac on 15/12/2021.
//

import Foundation

struct Currency: Decodable {
    let base: String
    let date: String
    var rates: [String: Double]
}
