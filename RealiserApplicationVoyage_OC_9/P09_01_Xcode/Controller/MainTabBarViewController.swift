//
//  MainTabBarViewController.swift
//  P09_01_Xcode
//
//  Created by charles Calvignac on 15/11/2021.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    @IBOutlet weak var myTabBar: UITabBar?

    let change = Change()
    let weather = Weather()
    var test = 0

     override func viewDidLoad() {
        super.viewDidLoad()
        tabBarCustom()
        // weather.callData()
     }

    // MARK: - Tab Bar custum

    func testPersistance() {
        test += 1
        print(test)
    }
    func tabBarCustom() {
        myTabBar?.tintColor = UIColor.black

        guard var myTabBarItem0 = tabBar.items?[0] else {return}
        myTabBarItem0 = (tabBar.items?[0])! as UITabBarItem
        myTabBarItem0.image = UIImage(named: "cloudy")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem0.selectedImage = UIImage(named: "cloudy_bold")?
            .withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem0.title = "Weather"

        let myTabBarItem1 = (tabBar.items?[1])! as UITabBarItem
        myTabBarItem1.image = UIImage(named: "language")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem1.selectedImage = UIImage(named: "language_bold")?
            .withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem1.title = "Translate"

        let myTabBarItem2 = (tabBar.items?[2])! as UITabBarItem
        myTabBarItem2.image = UIImage(named: "dollar")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem2.selectedImage = UIImage(named: "dollar_bold")?
            .withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem2.title = "Change"
    }
}
