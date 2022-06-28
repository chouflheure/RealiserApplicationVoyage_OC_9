import Foundation

struct WeatherJsonDecode: Decodable {
    let main: String
    let description: String
    let icon: String
}

struct DataInfoWeather: Decodable {
    var name: String
    var main: [String: Float]
    var wind: [String: Float]
    var weather: [WeatherJsonDecode]
}
