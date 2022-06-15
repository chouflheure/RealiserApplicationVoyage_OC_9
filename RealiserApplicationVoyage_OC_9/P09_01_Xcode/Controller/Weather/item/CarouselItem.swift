import Foundation
import UIKit

@IBDesignable
class CarouselItem: UIView {
    static let CAROUSELITEMNIB = "CarouselItem"

    @IBOutlet var vwContent: UIView!
    @IBOutlet var vwBackground: UIView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet weak var image: UIImageView!

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
                     imageview: UIImage? = UIImage(named: "localisation_weather")) {
        self.init()
        lblTitle.text = titleText
        vwBackground.backgroundColor = background
        image.image = imageview
    }

    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed(CarouselItem.CAROUSELITEMNIB, owner: self, options: nil)
        vwContent.frame = bounds
        vwContent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(vwContent)
    }
}
