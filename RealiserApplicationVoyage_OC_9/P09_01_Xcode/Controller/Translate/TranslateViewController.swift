import UIKit
import Lottie

class TranslateViewController: UIViewController {

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
        print(lanageSelected(selected: picker.selectedRow(inComponent: 0)))
        printData(lanageSelected: lanageSelected(selected: picker.selectedRow(inComponent: 0)))
        animationPrint(animated: true)
    }

    // MARK: - Variable
    var pickerData: [[String]] = [[String]]()
    let translate = Translate()

    // Load animation to AnimationView
    let animationView = AnimationView(animation: Animation.named("loading"))

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add animationView as subview
        view.addSubview(animationView)
        animationPrint(animated: false)
        placeholder()
        imputTradView.delegate = self

        translateButton.layer.cornerRadius = 25
        backgroundInitialisation()
        pickerData = [["Francais", "Anglais"],
                      ["English", "French"]]

        picker.delegate = self
        picker.dataSource = self
        traductionText.delegate = self
        translate.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        // Play the animation
        animationView.play()
        animationView.loopMode = .loop
    }

    func lanageSelected(selected: Int) -> String {
        if selected == 0 {
            return "fr"
        } else {
            return "en"
        }
    }
    func printData(lanageSelected: String) {
        print("imputTradView = \(imputTradView.text!)")
        translate.inputTranslate = imputTradView.text!
        translate.langueInputTranslate = lanageSelected
        translate.callData { (success) in
            if success {
                self.animationPrint(animated: false)
                // self.animationView.stop()
            } else {
                self.animationPrint(animated: false)
                self.messageErrorOperation()
            }
        }
    }

    func animationPrint(animated: Bool) {
        if animated {
            animationView.frame = CGRect(
                x: (UIScreen.main.bounds.maxX / 2) - 100,
                y: UIScreen.main.bounds.maxY / 2,
                width: 200,
                height: 200
            )
        } else {
            animationView.frame = CGRect(
                x: (UIScreen.main.bounds.maxX / 2) - 100,
                y: UIScreen.main.bounds.maxY / 2,
                width: 0,
                height: 0
            )
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func placeholder() {
        imputTradView.text = "Votre text"
        imputTradView.tintColor = .lightGray
    }

    @objc func keyBoardWillShow(notification: Notification) {
        if let userInfo = notification.userInfo as? [String: AnyObject] {
            let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
            let keyBoardRect = frame?.cgRectValue
            if let keyBoardHeight = keyBoardRect?.height {
                self.txtBC.constant = keyBoardHeight - spaceHideKeyboardAppear[0].frame.height
                UIView.animate(withDuration: 0.5, animations: { self.view.layoutIfNeeded() })
            }
        }
    }

    func backgroundInitialisation() {
        for index in 0 ..< viewTampon.count {
            viewTampon[index].backgroundColor = #colorLiteral(red: 0.7294117647, green: 0.9333333333, blue: 0.9019607843, alpha: 1)
        }
    }
}

extension TranslateViewController: UITextViewDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textViewDidChange(_ textView: UITextView) {
        if imputTradView.text.isEmpty || imputTradView.text == "Votre text" {
            imputTradView.text.removeAll()
        } else {
            imputTradView.textColor = UIColor.black
        }
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if imputTradView.text.isEmpty || imputTradView.text == "Votre text"{
            imputTradView.text.removeAll()
        } else {
            imputTradView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
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
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerData[component][row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
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

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int,
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

// MARK: - Message
extension TranslateViewController {
}
