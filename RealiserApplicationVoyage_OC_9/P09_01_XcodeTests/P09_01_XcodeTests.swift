//
//  P09_01_XcodeTests.swift
//  P09_01_XcodeTests
//
//  Created by charlesCalvignac on 28/06/2022.
//

import XCTest
@testable import P09_01_Xcode

class P0901XcodeTests: XCTestCase {

    var change: Change?

    func testConversion_AboutDeviceChange_GiveResult() {
        XCTAssertFalse(((change?.conversion(device: "Euro", montant: "10")) != nil), "10")
    }

    func testConversion_AboutDeviceChange_GiveResult2() {
        XCTAssertFalse(((change?.conversion(device: "Dollar", montant: "10")) != nil), "0")
    }

    func test() {
        
    }

}
