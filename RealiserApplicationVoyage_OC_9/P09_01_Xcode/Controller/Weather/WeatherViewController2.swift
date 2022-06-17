//
//  WeatherViewController.swift
//  P09_01_Xcode
//
//  Created by charles Calvignac on 15/11/2021.
//

import UIKit
import CoreLocation
// import UserNotifications

class WeatherViewController2: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var newYorkButton: UIButton!
    @IBOutlet weak var localisation: UIButton!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var temperature: UILabel!

    // MARK: - Variables
    let weather = Weather()
    let testPersistance = MainTabBarViewController()
    let localisationTrack: CLLocationManager = CLLocationManager()

    override func viewDidLoad() {
        printData()
        super.viewDidLoad()
        backgroundImageButton(button: "NY")
        backgroundImageButton(button: "localisation")
        // localisationInitialisation()
    }

    @IBAction func butonLocalisation(_ sender: Any) {
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "" }
        print("timezone = \(localTimeZoneAbbreviation.last!)")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        print(dateFormatter.string(from: NSDate() as Date))
        // localisationInitialisation()
    }

    @IBAction func butonNewYork(_ sender: Any) {
        printData()
    }

    func printData() {
        weather.callData { (success) in
            if success {
                self.dataTest()
            } else {
                self.messageErrorOperator()
            }
        }
    }

    func dataTest() {
        self.temperature.text = " Temperature : "
        self.temperature.text! += "\n\n\t max = "
        + "\(self.weather.dataTemperatureParis(dataWant: "temp_max"))°C"
        self.temperature.text! += "\n\t min = "
        + "\(self.weather.dataTemperatureParis(dataWant: "temp_min"))°C"
    }
}

// MARK: - Localisation
/*
extension WeatherViewController2: CLLocationManagerDelegate, UNUserNotificationCenterDelegate {
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
 */

// MARK: - Image
extension WeatherViewController2 {
}

/*
 Bonus :
 - adapter image en fonction de l'heure et du temps du pays
 */

// MARK: - Initialisation

extension WeatherViewController2 {

    func backgroundImageButton(button: String) {
        if button == "NY" {
            let imageNY = UIImage(named: "NY")!
                .withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            newYorkButton.imageView?.contentMode = UIView.ContentMode.scaleToFill
            newYorkButton.setImage(imageNY, for: UIControl.State.normal)
        } else {
            let imageLocalsation = UIImage(named: "localisation")!
                .withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            localisation.imageView?.contentMode = UIView.ContentMode.scaleToFill
            localisation.setImage(imageLocalsation, for: UIControl.State.normal)
        }
    }
}
