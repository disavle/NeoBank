//
//  Extensions.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 16.11.2021.
//

import Foundation
import UIKit

class Utils {
    static func isPasswordValid(_ password: String) -> Bool{
        let passwordTest = NSPredicate (format: "SELF MATCHES %@",
                                        "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate (with: password)
    }
}
