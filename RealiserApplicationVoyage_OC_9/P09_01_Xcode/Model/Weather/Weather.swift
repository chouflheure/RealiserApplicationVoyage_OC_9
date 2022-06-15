import Foundation
import CoreLocation
import UserNotifications

class Weather: NSObject {

    var dataWeatherParis: DataInfoWeather?
    var dataWeatherNY: DataInfoWeather?
    weak var delegate: WeatherDelegate?
    let localisationTrack: CLLocationManager = CLLocationManager()

    func callData(callback: @escaping (Bool) -> Void) {
        delegate?.printBoard(element: "")
        print("here")
        localisationInitialisation()
        print("here 2")
        let urlBody = "http://api.openweathermap.org/data/2.5/weather/"
        let urlAppid = "appid=01a551138c4f64c9b8b434bd7fb189db"
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

        //        let urlParis = URL(
        //            string: "http://api.openweathermap.org/data/2.5/weather/"
        //            + "?appid=01a551138c4f64c9b8b434bd7fb189db&q=Paris&units=metric"
        //        )

        URLSession.shared.dataTask(with: urlNY!) { data, _, error in
            DispatchQueue.main.async {
                do {
                    guard let data = data else { callback(false); return }
                    self.dataWeatherNY = try JSONDecoder().decode(DataInfoWeather.self, from: data)
                    callback(true)
                } catch {
                    callback(false)
                    print("Error : \(error)")
                }
            }
        }.resume()

//        let urlNY = URL(
//            string: "http://api.openweathermap.org/data/2.5/weather/?"
//            + "appid=01a551138c4f64c9b8b434bd7fb189db&q=new%20york&units=metric"
//        )

        URLSession.shared.dataTask(with: urlNY!) { data, _, error in
            DispatchQueue.main.async {
                do {
                    guard let data = data else {return }
                    self.dataWeatherNY = try JSONDecoder().decode(DataInfoWeather.self, from: data)
                    callback(true)
                } catch {
                    callback(false)
                    print("Error : \(error)")
                }
            }
        }.resume()
    }

    func dataTemperatureParis(dataWant: String) -> String {
        guard let dataWeatherParis = dataWeatherNY else {return "Error"}
        switch dataWant {
        case "temp":
            guard let data = dataWeatherParis.main["temp"] else {return "Error"}
            return String(Int(data))
        case "temp_min":
            guard let data = dataWeatherParis.main["temp_min"] else {return "Error"}
            return String(Int(data))
        case "temp_max":
            guard let data = dataWeatherParis.main["temp_max"] else {return "Error"}
            return String(Int(data))
        default:
                print("Error")
        }
        return "Error"
    }

    func dataWindAndHumidityParis(dataWant: String) -> String {
        guard let dataWeatherParis = dataWeatherParis else {return "Error"}
        switch dataWant {
        case "wind":
            guard let data = dataWeatherParis.wind["speed"] else {return "Error"}
            return String(Int(data))
        case "humidity":
            guard let data = dataWeatherParis.main["humidity"] else {return "Error"}
            return String(Int(data))
        default:
                print("Error")
        }
        return "Error"
    }

    func dataTemperatureNY(dataWant: String) -> String {
        guard let dataWeatherNY = dataWeatherNY else {return "Error"}
        switch dataWant {
        case "temp":
            guard let data = dataWeatherNY.main["temp"] else {return "Error"}
            return String(Int(data))
        case "temp_min":
            guard let data = dataWeatherNY.main["temp_min"] else {return "Error"}
            return String(Int(data))
        case "temp_max":
            guard let data = dataWeatherNY.main["temp_max"] else {return "Error"}
            return String(Int(data))
        default:
                print("Error")
        }
        return "Error"
    }

    func dataWindAndHumidityNY(dataWant: String) -> String {
        guard let dataWeatherNY = dataWeatherNY else {return "Error"}
        switch dataWant {
        case "wind":
            guard let data = dataWeatherNY.wind["speed"] else {return "Error"}
            return String(Int(data))
        case "humidity":
            guard let data = dataWeatherNY.main["humidity"] else {return "Error"}
            return String(Int(data))
        default:
                print("Error")
        }
        return "Error"
    }

    func time() {

    }
}

extension Weather: CLLocationManagerDelegate {

    func localisationInitialisation() {
        localisationTrack.delegate = self
        localisationTrack.requestWhenInUseAuthorization()
        localisationTrack.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        for currentLocation in locations {
            // print("\(index): \(currentLocation)")
            print("latitude = \(currentLocation.coordinate.latitude)")
            print("longitude = \(currentLocation.coordinate.longitude)")
            localisationTrack.stopUpdatingLocation()
            // "0: [locations]"
            let location = CLLocation(latitude: currentLocation.coordinate.latitude,
                                      longitude: currentLocation.coordinate.longitude)
            location.fetchCityAndCountry { city, country, error in
                guard let city = city, let country = country, error == nil else { return }
                print(city + ", " + country)  // Rio de Janeiro, Brazil
            }
        }
    }
}

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?,
                                                    _ country: String?, _ error: Error?) -> Void ) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
