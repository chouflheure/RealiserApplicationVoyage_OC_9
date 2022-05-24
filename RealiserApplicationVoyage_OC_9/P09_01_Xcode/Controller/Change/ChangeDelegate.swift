//
//  ChangeDelegate.swift
//  P09_01_Xcode
//
//  Created by charles Calvignac on 15/12/2021.
//

import UIKit

extension ChangeController: ChangeDelegate {
    func callMessageErrorOperator() {
        messageErrorOperator()
    }

    func callMessageErrorWidth() {
        messageErrorWidth()
    }

    func printBoard(element: String) {
        change.text = element
    }
}
