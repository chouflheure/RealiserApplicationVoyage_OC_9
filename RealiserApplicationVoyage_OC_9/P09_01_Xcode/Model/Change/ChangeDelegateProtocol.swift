import Foundation

protocol ChangeDelegate: AnyObject {
    func printBoard(element: String)
    func callMessageErrorOperator()
    func callMessageErrorWidth()
    func changeRate(element: String)
}
