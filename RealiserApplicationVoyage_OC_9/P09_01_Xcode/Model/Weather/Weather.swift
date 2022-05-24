//
//  Weather.swift
//  P09_01_Xcode
//
//  Created by charles Calvignac on 15/11/2021.
//

import Foundation

class Weather {

    var dataWeatherParis: DataInfoWeather?
    var dataWeatherNY: DataInfoWeather?

    func callData(callback: @escaping (Bool) -> Void) {
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

        URLSession.shared.dataTask(with: urlParis!) { data, _, error in
            DispatchQueue.main.async {
                do {
                    guard let data = data else { callback(false); return }
                    self.dataWeatherParis = try JSONDecoder().decode(DataInfoWeather.self, from: data)
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
        guard let dataWeatherParis = dataWeatherParis else {return "Error"}
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
