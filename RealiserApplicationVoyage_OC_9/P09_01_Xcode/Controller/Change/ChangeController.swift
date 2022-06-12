import UIKit

class ChangeController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var change: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var changeRate: UILabel!
    @IBOutlet weak var btnChange: UIButton!

    // MARK: - Variable
    let dataRecept = Change()
    var pickerValue = "Euro"
    var pickerData = [["Euro", "Dollar"], ["Dollar", "Euro"]]

    // MARK: - Initialisation
    override func viewDidLoad() {
        super.viewDidLoad()
        dataRecept.callData()
        picker.delegate = self
        picker.dataSource = self
        textField.delegate = self
        dataRecept.delegate = self
        btnChange.layer.cornerRadius = 25
    }
}

extension ChangeController {

    @IBAction func conversion(_ sender: Any) {
        conversion()
    }

    func conversion() {
        messageChangeRate()
        dataRecept.conversion(device: pickerValue, montant: textField.text
        )
    }
}

// MARK: - Text Field Controller
extension ChangeController: UITextFieldDelegate {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // This function is call when the keyboard is hiden
    func textFieldDidEndEditing(_ textField: UITextField) {
        conversion()
    }
}

// MARK: - Picker Controller
extension ChangeController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerData[component][row]
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int,
                    forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let val = view as? UILabel { label = val }
        label.font = UIFont(name: "Marker felt", size: 25)
        label.text =  pickerData[row][component]
        label.textColor = .black
        label.textAlignment = .center
        return label
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 && component == 0 {
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerValue = "Euro"
        } else if row == 0 && component == 1 {
            pickerView.selectRow(0, inComponent: 0, animated: true)
            pickerValue = "Euro"
        } else if row == 1 && component == 0 {
            pickerView.selectRow(1, inComponent: 1, animated: true)
            pickerValue = "Dollar"
        } else if row == 1 && component == 1 {
            pickerView.selectRow(1, inComponent: 0, animated: true)
            pickerValue = "Dollar"
        }
    }
}
