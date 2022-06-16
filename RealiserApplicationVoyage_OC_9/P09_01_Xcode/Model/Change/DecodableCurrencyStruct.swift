import Foundation

struct Currency: Decodable {
    let base: String
    let date: String
    var rates: [String: Double]
}
