import Foundation
import UIKit

class WeatherPageViewController: UIPageViewController {
    let weather = Weather()
    var items: [UIViewController] = []
    var cities = ["Paris", "New York", "Localisation"]
    var dataParis = [String]()

    /// faire une structure pour récupérer les infos des datas
    var arrayDataWeather = [DataWeatherApiCity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        decoratePageControl()
        weather.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        callDataApi()
        var iiii = 0
        while iiii < 3 {
            arrayDataWeather.append(DataWeatherApiCity(
                wind: ["data": 10.0],
                temp: ["data": 0.0],
                weather: [WeatherJsonDecode(main: "data", description: "data", icon: "data")],
                name: "city"))
            iiii += 1
        }
    }

    fileprivate func callDataApi() {
        weather.callData { (success) in
            if success {
                while self.items.count > 3 {
                    self.items.removeFirst()
                }
                self.weather.delegate?.reloadData(element: "")
                self.populateItems()
            } else {
                self.messageErrorServerConnexion()
            }
        }
    }

    fileprivate func decoratePageControl() {
        let uipc = UIPageControl.appearance(whenContainedInInstancesOf: [WeatherPageViewController.self])
        uipc.currentPageIndicatorTintColor = .blue
        uipc.pageIndicatorTintColor = .gray
    }

     func populateItems() {

        if let firstViewController = items.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        let backgroundColor:[ UIColor ] = [
                UIColor(red: 255/255.0, green: 115/255.0, blue: 71/255.0, alpha: 1.0),
                UIColor(red: 0/255.0, green: 192/255.0, blue: 54/255.0, alpha: 1.0),
                UIColor(red: 0/255.0, green: 194/255.0, blue: 255/255.0, alpha: 1.0)
            ]

        let image = [UIImage(named: "paris_weather"),
                     UIImage(named: "new_york_weather"),
                     UIImage(named: "localisation_weather")]

        for (index, label) in cities.enumerated() {
            let carousel = createCarouselItemControler(
                with: label,
                with: backgroundColor[index],
                with: image[index],
                with: arrayDataWeather[index])
            items.append(carousel)
        }
    }

    func createCarouselItemControler(with titleText: String?,
                                     with color: UIColor?,
                                     with image: UIImage?,
                                     with data: DataWeatherApiCity ) -> UIViewController {
        print("data == \(data)" )
        let carousel = UIViewController()
        carousel.view = CarouselItem(titleText: titleText, background: color, imageview: image, arrayDataWeather: data)
        return carousel
    }
}

// MARK: - DataSource

extension WeatherPageViewController: UIPageViewControllerDataSource {
    internal func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController)
    -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            return items.last
        }

        guard items.count > previousIndex else {
            return nil
        }
        return items[previousIndex]
    }

    internal func pageViewController(_: UIPageViewController,
                                     viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1
        guard items.count != nextIndex else {
            return items.first
        }

        guard items.count > nextIndex else {
            return nil
        }
        return items[nextIndex]
    }

    internal func presentationCount(for _: UIPageViewController) -> Int {
        return 3
    }

    internal func presentationIndex(for _: UIPageViewController) -> Int {
            guard let firstViewController = viewControllers?.first,
                  let firstViewControllerIndex = items.firstIndex(of: firstViewController) else {
                    return 0
            }
        return firstViewControllerIndex
    }
}
