import Foundation

protocol ChangeDelegate: AnyObject {
    func updateChange(element: String)
    func messageErrorServerConnexionDelegate()
    func messageErrorLengthChangeInputDelegate()
    func changeRate(element: String)
}
