//
//  ChangeDelegateProtocol.swift
//  P09_01_Xcode
//
//  Created by charles Calvignac on 15/12/2021.
//

import Foundation

protocol ChangeDelegate: AnyObject {
    func printBoard(element: String)
    func callMessageErrorOperator()
    func callMessageErrorWidth()
}
