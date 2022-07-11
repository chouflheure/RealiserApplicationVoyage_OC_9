import UIKit

extension WeatherPageViewController: WeatherDelegate {

    func printBoard(element: String) {
        // ☀️ ⛅ ☁️ 🌧️
    }

    func localisation(element: String) {
        // cities.remove(at: 2)
        // cities.append(element)
        print("ici = \(cities)")
    }

    func callMessageErrorOperator() {
    }

    func callMessageErrorWidth() {
    }

    func messageErrorLocalisation() {
        let alertVC = UIAlertController(title: "Erreur!",
                                        message: "Votre localisation n'a pas été trouvée",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }

    func reloadData(element: String) {
        localisation(element: element)
        populateItems()
    }

    func addDataOnScreen(element: DataWeatherApiCity) {
        arrayDataWeather.append(element)
    }
}
