//
//  WeatherViewController.swift
//  P09_01_Xcode
//
//  Created by charles Calvignac on 15/11/2021.
//

import UIKit
import CoreLocation
import UserNotifications

class WeatherViewController: UIViewController, CLLocationManagerDelegate, UNUserNotificationCenterDelegate {

    @IBOutlet weak var newYorkPictureWeather: UIView!
    @IBOutlet weak var parisPictureWheather: UILabel!
    @IBOutlet weak var newYorkWind: UILabel!
    @IBOutlet weak var parisWind: UILabel!
    @IBOutlet weak var newYorkTemperature: UILabel!
    @IBOutlet weak var parisTemperature: UILabel!
    @IBOutlet weak var cardNyewYorkWeather: UIStackView!
    @IBOutlet weak var cardParisWeather: UIStackView!
    @IBOutlet weak var test: UIView!
    @IBOutlet weak var cardCornerRadiusNewYorkBottom: UIView!

// --------------------------------------------------------------------------
    let localisation: CLLocationManager = CLLocationManager()
// --------------------------------------------------------------------------

    let weather = Weather()
    let testPersistance = MainTabBarViewController()
    let newYorkTime = -5
    var localisationTimeZone = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        // printData()

// --------------------------------------------------------------------------
        // requestPermissionNotifications()

        localisation.delegate = self
        localisation.requestWhenInUseAuthorization()
        localisation.startUpdatingLocation()

        // localisation.startMonitoring()

// --------------------------------------------------------------------------
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        for currentLocation in locations {
            // print("\(index): \(currentLocation)")
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
            localisation.stopUpdatingLocation()
            // "0: [locations]"
        }
    }

    @IBAction func click(_ sender: Any) {
        printData()
    }

    func printData() {
        weather.callData { (success) in
            if success {
                self.testPersistance.testPersistance()

                self.newYorkTemperature.text = " Temperature : "
                self.newYorkTemperature.text! += "\n\n\t max = "
                + "\(self.weather.dataTemperatureParis(dataWant: "temp_max"))°C"
                self.newYorkTemperature.text! += "\n\t min = "
                + "\(self.weather.dataTemperatureParis(dataWant: "temp_min"))°C"

                self.newYorkWind.text = " Vent : "
                self.newYorkWind.text! += "\n\t \(self.weather.dataWindAndHumidityParis(dataWant: "wind")) km/h "
                self.newYorkWind.text! += "\n\n Humidité : "
                self.newYorkWind.text! += "\n\t \(self.weather.dataWindAndHumidityParis(dataWant: "humidity"))%"

                self.parisTemperature.text = " Temperature : "
                self.parisTemperature.text! += "\n\n\t max = \(self.weather.dataTemperatureNY(dataWant: "temp_max"))°C"
                self.parisTemperature.text! += "\n\t min = \(self.weather.dataTemperatureNY(dataWant: "temp_min"))°C"

                self.parisWind.text = " Vent : "
                self.parisWind.text! += "\n\t \(self.weather.dataWindAndHumidityNY(dataWant: "wind")) km/h "
                self.parisWind.text! += "\n\n Humidité : "
                self.parisWind.text! += "\n\t \(self.weather.dataWindAndHumidityNY(dataWant: "humidity"))%"
            } else {
                self.messageErrorOperator()
            }
        }
    }

    func messageErrorOperator() {
        let alertVC = UIAlertController(title: "Error!",
                                        message: "We can't etablish a connection with the server ",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Retry", style: .default) { (_) in self.printData() })
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}

/*
 Bonus :
 - adapter image en fonction de l'heure et du temps du pays
 */
