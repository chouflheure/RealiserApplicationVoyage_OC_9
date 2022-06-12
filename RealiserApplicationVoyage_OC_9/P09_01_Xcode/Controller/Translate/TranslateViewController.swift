//
//  TranslateViewController.swift
//  P09_01_Xcode
//
//  Created by charles Calvignac on 15/11/2021.
//

import UIKit
import Lottie

class TranslateViewController: UIViewController {

    @IBOutlet weak var translateButton: UIButton!
    // MARK: - IBOutlet
    @IBOutlet var viewGeneral: UIView!
    @IBOutlet var textTradInput: UITextView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet var viewTampon: [UIView]!
    @IBOutlet weak var txtBC: NSLayoutConstraint!
    @IBOutlet var spaceHideKeyboardAppear: [UIView]!
    @IBOutlet weak var tradTextInput: UITextView!
    @IBOutlet weak var tradTextView: UIView!
    @IBOutlet weak var imageTextTranslater: UIImageView!
    @IBOutlet weak var traductionText: UITextView!
    @IBOutlet weak var imputTradView: UITextView!
    // MARK: - Variable
    @IBAction func clickButonTranslate(_ sender: Any) {
        printData()
    }

    var pickerData: [[String]] = [[String]]()
    let translate = Translate()

    override func viewDidLoad() {
        super.viewDidLoad()

        // let jsonName = "loading-animation"
        // let animation = Animation.named(jsonName)

        // Load animation to AnimationView
        // let traductionText = AnimationView(animation: animation)
        // traductionText.frame = CGRect(x: 100, y: 300, width: 200, height: 200)

        // Add animationView as subview
        // view.addSubview(traductionText)

        // Play the animation
        // traductionText.play()

        placeholder()
        imputTradView.delegate = self

        translateButton.layer.cornerRadius = 25
        backgroundInitialisation()
        pickerData = [["Francais", "Anglais"],
                      ["English", "French"]]

        picker.delegate = self
        picker.dataSource = self
    }

    func printData() {
        translate.inputTranslate = "hello"
        translate.langueInputTranslate = "FR"
        translate.callData { (success) in
            if success {
                // self.dataTest()
            } else {
                // self.messageErrorOperator()
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func placeholder(){
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
            print("editing")
            imputTradView.text.removeAll()
            imputTradView.textColor = UIColor.lightGray
        } else {
            imputTradView.textColor = UIColor.black
            print(imputTradView.text)
        }
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if imputTradView.text.isEmpty || imputTradView.text == "Votre text"{
            print("begin editing")
            imputTradView.text.removeAll()
            imputTradView.textColor = UIColor.lightGray
        } else {
            imputTradView.textColor = UIColor.black
            print(imputTradView.text)
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if imputTradView.text.isEmpty {
            print("end editing")
            imputTradView.text.removeAll()
            imputTradView.text = "Votre text"
            imputTradView.textColor = UIColor.lightGray
        } else {
            imputTradView.textColor = UIColor.black
            print(imputTradView.text)

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
}

// MARK: - Message
extension TranslateViewController {
}
