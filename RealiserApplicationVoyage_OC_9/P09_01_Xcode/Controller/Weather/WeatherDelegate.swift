import UIKit

extension WeatherPageViewController: WeatherDelegate {

    func printBoard(element: String) {
        // ☀️ ⛅ ☁️ 🌧️
    }

    func localisation(element: String) {
        cities.remove(at: 2)
        cities.append(element)
        print("ici = \(cities)")
    }

    func callMessageErrorOperator() {
    }

    func callMessageErrorWidth() {
    }

    func reloadData(element: String) {
        while items.count > 3 {
            items.removeFirst()
        }
        localisation(element: element)
        populateItems()
    }
}
