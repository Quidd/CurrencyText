//
//  CurrencyFormatterTests.swift
//  CurrencyTextDemoTests
//
//  Created by Felipe Lefèvre Marino on 2/11/19.
//  Copyright © 2019 Felipe Lefèvre Marino. All rights reserved.
//

import XCTest
@testable import CurrencyText

class CurrencyFormatterTests: XCTestCase {
    
    var formatter: CurrencyFormatter!

    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
        formatter.locale = CurrencyLocale.englishIreland
        formatter.currency = .euro
    }

    override func tearDown() {
        formatter = nil
        super.tearDown()
    }

    func testComposing() {
        formatter = CurrencyFormatter {
            $0.locale = CurrencyLocale.italianItaly
            $0.currency = .euro
            $0.hasDecimals = false
        }
        
        XCTAssertEqual(formatter.decimalDigits, 0)
        XCTAssertEqual(formatter.hasDecimals, false)
        XCTAssertEqual(formatter.locale.locale, CurrencyLocale.italianItaly.locale)
        XCTAssertEqual(formatter.currencySymbol, "€")
    }
    
    func testMinAndMaxValues() {
        formatter.minValue = nil
        formatter.maxValue = nil
        
        var formattedString = formatter.string(from: 300000.54)
        XCTAssertEqual(formattedString, "€300,000.54")
        
        formatter.minValue = 10
        formatter.maxValue = 100.31
        
        formattedString = formatter.updatedFormattedString(from: "€300,000.54")
        XCTAssertEqual(formattedString, "€100.31")
        
        formattedString = formatter.updatedFormattedString(from: "€2.03")
        XCTAssertEqual(formattedString, "€10.00")
    }
    
    func testFormatting() {
        formatter.locale = CurrencyLocale.portugueseBrazil
        formatter.currency = .euro
        formatter.hasDecimals = true
        
        let formattedString = formatter.string(from: 300000.54)
        XCTAssertEqual(formattedString, "€ 300.000,54")
        
        let unformattedString = formatter.unformatted(string: formattedString!)
        XCTAssertEqual(unformattedString, "30000054")
        
        let doubleValue = formatter.double(from: "30000054")
        XCTAssertEqual(doubleValue, 30000054.00)
    }
}
