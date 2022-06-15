import Foundation
import UIKit

class CarouselPageViewController: UIPageViewController {
    fileprivate var items: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self

        decoratePageControl()

        populateItems()
        if let firstViewController = items.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    fileprivate func decoratePageControl() {
        let uipc = UIPageControl.appearance(whenContainedInInstancesOf: [CarouselPageViewController.self])
        uipc.currentPageIndicatorTintColor = .blue
        uipc.pageIndicatorTintColor = .gray
    }

    fileprivate func populateItems() {
        let text = ["Paris", "New York", " "]
        let backgroundColor:[ UIColor ] = [
                UIColor(red: 255/255.0, green: 115/255.0, blue: 71/255.0, alpha: 1.0),
                UIColor(red: 0/255.0, green: 192/255.0, blue: 54/255.0, alpha: 1.0),
                UIColor(red: 0/255.0, green: 194/255.0, blue: 255/255.0, alpha: 1.0)
            ]

        let image = [UIImage(named: "paris_weather"),
                     UIImage(named: "new_york_weather"),
                     UIImage(named: "localisation_weather")]

        for (index, label) in text.enumerated() {
            let carousel = createCarouselItemControler(with: label, with: backgroundColor[index], with: image[index])
            items.append(carousel)
        }
    }

    fileprivate func createCarouselItemControler(with titleText: String?,
                                                 with color: UIColor?, with image: UIImage?) -> UIViewController {
        let carousel = UIViewController()
        carousel.view = CarouselItem(titleText: titleText, background: color, imageview: image!)
        return carousel
    }
}

// MARK: - DataSource

extension CarouselPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController)
    -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }

        
        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            print(viewControllerIndex)
            return items.last
        }

        guard items.count > previousIndex else {
            return nil
        }
        print(viewControllerIndex)
        return items[previousIndex]
    }

    func pageViewController(_: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1
        guard items.count != nextIndex else {
            print(viewControllerIndex)
            return items.first
        }

        guard items.count > nextIndex else {
            return nil
        }
        print(viewControllerIndex)
        return items[nextIndex]
    }

    func presentationCount(for _: UIPageViewController) -> Int {
        return items.count
    }

    func presentationIndex(for _: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
              let firstViewControllerIndex = items.firstIndex(of: firstViewController) else {
                return 0
        }

        return firstViewControllerIndex
    }
}
