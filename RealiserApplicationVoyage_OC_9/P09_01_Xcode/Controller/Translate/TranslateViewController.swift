import UIKit
import Lottie

final class TranslateViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet var viewGeneral: UIView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet var viewTampon: [UIView]!
    @IBOutlet weak var txtBC: NSLayoutConstraint!
    @IBOutlet var spaceHideKeyboardAppear: [UIView]!
    @IBOutlet weak var tradTextView: UIView!
    @IBOutlet weak var imageTextTranslater: UIImageView!
    @IBOutlet weak var traductionText: UITextView!
    @IBOutlet weak var imputTradView: UITextView!

    @IBAction func clickButonTranslate(_ sender: Any) {
        printData(langageSelected: lanageSelected(selected: picker.selectedRow(inComponent: 0)))
        animationViewOnScreen(animated: true)
    }

    // MARK: - Variable
    var pickerData = [["Francais", "Anglais"], ["English", "French"]]
    let translate = Translate()

    // Load animation to AnimationView
    let animationView = AnimationView(animation: Animation.named("loading"))

    override internal func viewDidLoad() {
        super.viewDidLoad()

        // Add animationView as subview
        view.addSubview(animationView)
        animationViewOnScreen(animated: false)
        placeholder()
        delegateInitialisation()
        backgroundInitialisationColor()
        translateButton.layer.cornerRadius = 25
    }

    internal func delegateInitialisation() {
        picker.delegate = self
        picker.dataSource = self
        traductionText.delegate = self
        translate.delegate = self
        imputTradView.delegate = self
    }

    override internal func viewWillAppear(_ animated: Bool) {
        animationView.play()
        animationView.loopMode = .loop
    }

    internal func lanageSelected(selected: Int) -> String {
        if selected == 0 {
            return "EN"
        } else {
            return "FR"
        }
    }

    internal func printData(langageSelected: String) {
        translate.inputTranslate = imputTradView.text ?? ""
        translate.langueInputTranslate = langageSelected

        translate.callApiToTranslate { (success) in
            if success {
                self.animationViewOnScreen(animated: false)
            } else {
                self.animationViewOnScreen(animated: false)
                self.messageErrorServerConnexion()
            }
        }
    }

    internal func animationViewOnScreen(animated: Bool) {
        var size = CGFloat()
        if animated {
            size = 200
        } else {
            size = 0
        }

        animationView.frame = CGRect(
            x: (UIScreen.main.bounds.maxX / 2) - 100,
            y: UIScreen.main.bounds.maxY / 2,
            width: size,
            height: size)
    }

    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    internal func placeholder() {
        imputTradView.text = "Votre text"
        imputTradView.tintColor = .lightGray
    }

    @objc internal func keyBoardWillShow(notification: Notification) {
        if let userInfo = notification.userInfo as? [String: AnyObject] {
            let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
            let keyBoardRect = frame?.cgRectValue
            if let keyBoardHeight = keyBoardRect?.height {
                self.txtBC.constant = keyBoardHeight - spaceHideKeyboardAppear[0].frame.height
                UIView.animate(withDuration: 0.5, animations: { self.view.layoutIfNeeded() })
            }
        }
    }

    internal func backgroundInitialisationColor() {
        for index in 0 ..< viewTampon.count {
            viewTampon[index].backgroundColor = #colorLiteral(red: 0.7294117647, green: 0.9333333333, blue: 0.9019607843, alpha: 1)
        }
    }
}

extension TranslateViewController: UITextViewDelegate {
    override internal func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    internal func textViewDidChange(_ textView: UITextView) {
        if imputTradView.text.isEmpty || imputTradView.text == "Votre text" {
            imputTradView.text.removeAll()
        } else {
            imputTradView.textColor = UIColor.black
        }
    }

    internal func textViewDidBeginEditing(_ textView: UITextView) {
        if imputTradView.text.isEmpty || imputTradView.text == "Votre text"{
            imputTradView.text.removeAll()
        } else {
            imputTradView.textColor = UIColor.black
        }
    }

    internal func textViewDidEndEditing(_ textView: UITextView) {
        if imputTradView.text.isEmpty {
            imputTradView.text.removeAll()
            imputTradView.text = "Votre text"
            imputTradView.textColor = UIColor.lightGray
        } else {
            imputTradView.textColor = UIColor.black
        }
    }
}

extension TranslateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }

    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }

    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerData[component][row]
    }

    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let modification = pickerData[component][row]
        switch modification {
        case "Francais":
            pickerView.selectRow(0, inComponent: 1, animated: true)
        case "English":
            pickerView.selectRow(0, inComponent: 0, animated: true)
        case "Anglais":
            pickerView.selectRow(1, inComponent: 1, animated: true)
        case "French":
            pickerView.selectRow(1, inComponent: 0, animated: true)
        default:
            pickerView.selectRow(0, inComponent: 0, animated: true)
        }
    }

    internal func pickerView(_ pickerView: UIPickerView, viewForRow row: Int,
                             forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let veee = view as? UILabel { label = veee }
        label.font = UIFont(name: "Optima", size: 25)
        label.text =  pickerData[row][component]
        label.textColor = .black
        label.textAlignment = .center
        return label
    }
}
