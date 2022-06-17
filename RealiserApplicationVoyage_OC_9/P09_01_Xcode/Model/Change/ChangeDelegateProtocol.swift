import Foundation

protocol ChangeDelegate: AnyObject {
    func printBoard(element: String)
    func callMessageErrorOperation()
    func callMessageErrorWidth()
    func changeRate(element: String)
}
