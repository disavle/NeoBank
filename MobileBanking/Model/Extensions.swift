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

extension UIFont{
    enum FontType: String {
        case logo = "Kepler-296"
        case main = "MusticaPro-SemiBold"
    }
    static func font(_ size: CGFloat, _ type: FontType) -> UIFont{
        print(size)
        print(type.rawValue)
        return UIFont(name: type.rawValue, size: size)!
    }
}
