//
//  StringTests.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/5/26.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import XCTest
@testable import SwiftMinions

class StringTests: XCTestCase {
    
    override func setUp() {
        
    }

    override func tearDown() {
        
    }
    
    func testStringSafable() {
        let str = "Swift Minions"
        
        XCTAssertEqual(str.safe[0..<5], "Swift") 
        XCTAssertEqual(str.safe[6..<13], "Minions") 
        XCTAssertEqual(str.safe[6..<16], "Minions") 
        XCTAssertEqual(str.safe[12..<16], "s") 
        XCTAssertEqual(str.safe[14..<16], "") 
    }

    func testSuccessRegularExpression() {
        
        let phoneRegex = #"^([0]|[+]?886)(\d{9})$"#
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,64}$"#
        
        print("test success regular expression ----------")
        
        let successRegexs: [String: [String]] = [
            phoneRegex: [
                "0912345678", "+886123456789", "886123456789"
            ],
            emailRegex: [
                "fghz@adyt.sd", "f@a.sd", "lad+kns-knsgkns.kns_kns%@sdfg.sdfg.com"
            ]
        ]
        
        for regex in successRegexs {
            regex.value.forEach {
                let isValidation = $0.isValidate(withRegex: regex.key)
                XCTAssertEqual(isValidation, true)
                
                let firstMatch = $0.regularFirstMatch(withRegex: regex.key) != nil
                XCTAssertEqual(firstMatch, true)
                
                let match = $0.regularMatches(withRegex: regex.key).count == 1
                print( $0.regularMatches(withRegex: regex.key))
                XCTAssertEqual(match, true)
            }
        }
        
        let mail1 = "minions@swiftminions.com"
        let result1 = mail1.regularMatches(withRegex: emailRegex)
        XCTAssertEqual(result1, mail1.split(separator: ",").map { "\($0)" })
        
        let mail2 = """
        minions@swiftminions.com
        minions2@sdf.com
        """
        let result2 = mail2.regularMatches(withRegex: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,64}")
        print(result2)
        XCTAssertEqual(result2, mail2.split(whereSeparator: { $0.isNewline }).map { "\($0)" })
        
        print("test failure regular expression ----------")
        
        let failureRegexs: [String: [String]] = [
            phoneRegex: [
                "09123456781", "+88612345679", "88612345689", "s 0912345678 s"
            ],
            emailRegex: [
                "fghz@adyt.s", "a~f@f@a.sd", "lad+k~ns..-@sdfg+-..sdfg.com1"
            ]
        ]
        
        for regex in failureRegexs {
            regex.value.forEach {
                let result = $0.isValidate(withRegex: regex.key)
                print("\($0): \(result)")
                XCTAssertEqual(result, false)
            }
        }
        
        print("test replace regular expression ----------")
        let regex = #"(\()([0][0-9]{1,2})(\))([\d]{9})"#
        let phone = "(02)123456789"
        let newPhone = phone.regularReplace(withRegex: regex, content: "$2-$4")
        XCTAssertEqual(newPhone, "02-123456789")
    }
}
