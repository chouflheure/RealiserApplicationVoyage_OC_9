import Foundation
import UIKit

@IBDesignable
class CarouselItem: UIView {
    static let CAROUSELITEMNIB = "CarouselItem"

    @IBOutlet var vwContent: UIView!
    @IBOutlet var vwBackground: UIView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var weatherData: UILabel!
    @IBOutlet weak var windData: UILabel!
    @IBOutlet weak var temperatureData: UILabel!
    @IBOutlet weak var humidityData: UILabel!

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
    }

    convenience init(titleText: String? = "",
                     background: UIColor? = .red,
                     imageview: UIImage? = UIImage(named: "localisation_weather"),
                     arrayDataWeather: DataWeatherApiCity = DataWeatherApiCity(
                        wind: ["data": 0.0],
                        temp: ["data": 0.0],
                        weather: [WeatherJsonDecode(main: "data", description: "data", icon: "data")],
                        name: "city")
    ) {
        print("heeeeeeere = \(arrayDataWeather)")
        self.init()
        lblTitle.text = titleText
        vwBackground.backgroundColor = background
        image.image = imageview
        weatherData.text = String(arrayDataWeather.wind["speed"] ?? 00.0)
        windData.text = "Error"
        temperatureData.text = "Error"
        humidityData.text = "Error"
    }

    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed(CarouselItem.CAROUSELITEMNIB, owner: self, options: nil)
        vwContent.frame = bounds
        vwContent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(vwContent)
    }
}
