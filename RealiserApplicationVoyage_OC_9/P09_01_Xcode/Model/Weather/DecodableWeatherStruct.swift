//
//  DecodableStruct.swift
//  P09_01_Xcode
//
//  Created by charles Calvignac on 15/12/2021.
//

import Foundation

struct DataInfoWeather: Decodable {
    var main: [String: Float]
    var wind: [String: Float]
}
