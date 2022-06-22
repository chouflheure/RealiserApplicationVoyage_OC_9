import Foundation

protocol WeatherDelegate: AnyObject {
    func printBoard(element: String)
    func callMessageErrorOperator()
    func callMessageErrorWidth()
    func localisation(element: String)
    func reloadData()
}
