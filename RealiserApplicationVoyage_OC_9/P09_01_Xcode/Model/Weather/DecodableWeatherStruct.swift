import Foundation

struct DataInfoWeather: Decodable {
    var main: [String: Float]
    var wind: [String: Float]
}
