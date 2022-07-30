import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var buttonReload: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        vwContainer.backgroundColor = UIColor(red: 186/255, green: 238/255, blue: 230/255, alpha: 1.00)
    }
}
