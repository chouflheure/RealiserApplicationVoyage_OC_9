//
//  TranslateViewController.swift
//  P09_01_Xcode
//
//  Created by charles Calvignac on 15/11/2021.
//

import UIKit

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
    
    @IBAction func clickButonTranslate(_ sender: Any) {
        printData()
    }

    // MARK: - Variable
    var pickerData: [[String]] = [[String]]()
    let translate = Translate()

    override func viewDidLoad() {
        super.viewDidLoad()

        placeholder()
        translateButton.layer.cornerRadius = 25
        backgroundInitialisation()
        pickerData = [["Francais", "Anglais"],
                      ["English", "French"]]

        picker.delegate = self
        picker.dataSource = self
//        textTradInput.delegate = self
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

    func placeholder() {
        //textTradInput.text = "Placeholder"
        //textTradInput.textColor = .lightGray
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

    func textViewDidBeginEditing(_ textView: UITextView) {
        textTradInput.text.removeAll()
        textTradInput.textColor = .black
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textTradInput.text.isEmpty {
            placeholder()
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
