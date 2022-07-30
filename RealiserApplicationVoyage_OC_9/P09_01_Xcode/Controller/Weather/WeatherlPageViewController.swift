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
        let button = self.makeButton(title: "",
                                     titleColor: .blue,
                                     cornerRadius: 3.0,
                                     borderWidth: 2,
                                     borderColor: .black)

        view.addSubview(button)
        reloadButton()
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.addTarget(self, action: #selector(pressed(_ :)), for: .touchUpInside)
    }

    func makeButton(title: String? = nil,
                    titleColor: UIColor = .black,
                    background: UIColor = .clear,
                    cornerRadius: CGFloat = 0,
                    borderWidth: CGFloat = 0,
                    borderColor: UIColor = .clear) -> UIButton {

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6.0
        return button
}

    func reloadButton() {
        let image = UIImage(named: "reload")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 20, y: 100, width: 40, height: 40)
        view.addSubview(imageView)
    }

    @objc func pressed(_ sender: UIButton) {
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
        self.populateItems()
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
        self.populateItems()
    }

     func callDataApi() {
        weather.callData { (success) in
            if success {
                // self.weather.delegate?.reloadData(element: "")
                if let firstViewController = self.items.first {
                    self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
                }
            } else {
                self.messageErrorServerConnexion()
            }
        }
    }

    /// rendre chaque page responsable de récupérer les données

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

         if (items.count > 3 ) {items.removeAll()}
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
