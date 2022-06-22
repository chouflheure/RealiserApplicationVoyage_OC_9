import UIKit

extension WeatherPageViewController: WeatherDelegate {

    func printBoard(element: String) {
        // ☀️ ⛅ ☁️ 🌧️
        weatherData.append("test")
        print("test = \(weatherData)")
    }

    func localisation(element: String) {
        cities.remove(at: 2)
        cities.append(element)
        //print("ici = \(cities)")
    }

    func callMessageErrorOperator() {
    }

    func callMessageErrorWidth() {
    }

    func reloadData() {
        localisation(element: cities[2])
        populateItems()
        print(cities)
    }
}
