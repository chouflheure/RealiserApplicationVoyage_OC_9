import Foundation
import CoreLocation
import UserNotifications

struct DataWeatherApiCity {
    var wind: [String: Float]
    var temp: [String: Float]
    var weather: [WeatherJsonDecode]
    var name: String

    init(wind: [String: Float], temp: [String: Float], weather: [WeatherJsonDecode], name: String) {
        self.wind = wind
        self.temp = temp
        self.weather = weather
        self.name = name
    }
}

class Weather: NSObject {

    var dataWeatherParis: DataInfoWeather?
    var dataWeatherNY: DataInfoWeather?
    weak var delegate: WeatherDelegate?
    let localisationTrack: CLLocationManager = CLLocationManager()
    let weatherIcon = ["☀️", "⛅", "☁️", "🌧️"]
    var apiKey = Bundle.main.object(forInfoDictionaryKey: "API_Key_Weather") as? String
    // ☀️ ⛅ ☁️ 🌧️

    func callData(callback: @escaping (Bool) -> Void) {
        localisationInitialisation()

        guard let key = apiKey, !key.isEmpty else {
            apiKey = ""
            return
        }

        let urlBody = "http://api.openweathermap.org/data/2.5/weather/"
        let urlAppid = "appid=\(key)"
        let urlCountryParis = "q=Paris"
        let urlCountryNY = "q=new%20york"
        let urlUnits = "units=metric"

        let urlParis = URL(string:
                            urlBody +
                            "?" + urlAppid +
                            "&" + urlCountryParis +
                            "&" + urlUnits )

        let urlNY = URL(string:
                            urlBody +
                            "?" + urlAppid +
                            "&" + urlCountryNY +
                            "&" + urlUnits )

        URLSession.shared.dataTask(with: urlNY!) { data, _/*response*/, _/*error*/ in
            DispatchQueue.main.async {

//                let httpResponse = response as? HTTPURLResponse
                self.delegate?.printBoard(element: "")
                do {
                    guard let data = data else { callback(false); return }
                    self.dataWeatherNY = try JSONDecoder().decode(DataInfoWeather.self, from: data)
                  print(self.dataWeatherNY!)
                    self.delegate?.localisation(element: "")

                    self.delegate?.addDataOnScreen(
                        element: DataWeatherApiCity(
                            wind: self.dataWeatherNY?.wind ?? ["Error": 0.0],
                            temp: self.dataWeatherNY?.main ?? ["Error": 0.0],
                            weather: self.dataWeatherNY?.weather ??
                            [WeatherJsonDecode(main: "Error", description: "Error", icon: "Error")],
                            name: self.dataWeatherNY?.name ?? "Error")
                    )
                    callback(true)
                } catch {
                    callback(false)
                }
            }
        }.resume()
    }
}

extension Weather: CLLocationManagerDelegate {

    fileprivate func localisationInitialisation() {
        localisationTrack.delegate = self
        localisationTrack.requestWhenInUseAuthorization()
        localisationTrack.startUpdatingLocation()
    }

    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        for currentLocation in locations {
            print("latitude = \(currentLocation.coordinate.latitude)")
            print("longitude = \(currentLocation.coordinate.longitude)")

            let location = CLLocation(latitude: currentLocation.coordinate.latitude,
                                      longitude: currentLocation.coordinate.longitude)
            location.fetchCityAndCountry { city, country, error in
                guard let city = city, let country = country, error == nil else {
                    self.delegate?.reloadData(element: "Error")
                    self.delegate?.messageErrorLocalisation()
                    return
                }

                print(city + ", " + country)  // Rio de Janeiro, Brazil
                // self.delegate?.localisation(element: city)
                self.delegate?.reloadData(element: city)
            }

            localisationTrack.stopUpdatingLocation()
        }
    }
}

extension CLLocation {
    fileprivate func fetchCityAndCountry(completion: @escaping (_ city: String?,
                                                    _ country: String?, _ error: Error?) -> Void ) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
