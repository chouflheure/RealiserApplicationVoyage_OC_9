import UIKit
import Lottie

class ChangeController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var change: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var amountChangeInput: UITextField!
    @IBOutlet weak var changeRate: UILabel!
    @IBOutlet weak var btnChange: UIButton!
    @IBOutlet weak var lottiView: UIView!

    // MARK: - Variable
    let dataRecept = Change()
    var pickerValueSelected = "Euro"
    var pickerData = [["Euro", "Dollar"], ["Dollar", "Euro"]]
    let animationLottieView = AnimationView(animation: Animation.named("currency-exchange"))

    // MARK: - Initialisation
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateInitialisation()
        fontInitialisation()
        uiImplementation()
    }

    override func viewWillAppear(_ animated: Bool) {

        // Play the animation
        animationLottieView.play()
        animationLottieView.loopMode = .loop
    }

    // MARK: - Delegate initialisation

    fileprivate func delegateInitialisation() {
        dataRecept.callData()
        picker.delegate = self
        picker.dataSource = self
        amountChangeInput.delegate = self
        dataRecept.delegate = self
    }

    fileprivate func fontInitialisation() {
        changeRate.font = UIFont(name: "Optima", size: 18)
    }

    fileprivate func uiImplementation() {
        btnChange.layer.cornerRadius = 25
        animationLottieView.frame = CGRect(x: 100,
                                     y: UIScreen.main.bounds.size.height/2,
                                     width: lottiView.frame.width,
                                     height: lottiView.frame.height)
        view.addSubview(animationLottieView)
    }
}

extension ChangeController {

    @IBAction func conversion(_ sender: Any) {
        conversion()
    }

    fileprivate func conversion() {
        dataRecept.conversion(device: pickerValueSelected, montant: amountChangeInput.text
        )
    }
}

// MARK: - Text Field Controller
extension ChangeController: UITextFieldDelegate {

    override internal func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // This function is call when the keyboard is hiden and call conversion
    // to do the call API 
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        conversion()
    }
}

// MARK: - Picker Controller
extension ChangeController: UIPickerViewDelegate, UIPickerViewDataSource {

    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }

    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }

    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerData[component][row]
    }

    internal func pickerView(_ pickerView: UIPickerView, viewForRow row: Int,
                             forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let val = view as? UILabel { label = val }
        label.font = UIFont(name: "Optima", size: 25)
        label.text =  pickerData[row][component]
        label.textColor = .black
        label.textAlignment = .center
        return label
    }

    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 && component == 0 {
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerValueSelected = "Euro"
        } else if row == 0 && component == 1 {
            pickerView.selectRow(0, inComponent: 0, animated: true)
            pickerValueSelected = "Euro"
        } else if row == 1 && component == 0 {
            pickerView.selectRow(1, inComponent: 1, animated: true)
            pickerValueSelected = "Dollar"
        } else if row == 1 && component == 1 {
            pickerView.selectRow(1, inComponent: 0, animated: true)
            pickerValueSelected = "Dollar"
        }
    }
}
