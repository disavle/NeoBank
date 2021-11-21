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
    
    static func darkMode(sender: UISwitch){
        //MARK: Dark mode switcher
        if (sender.isOn == false){
            AppDelegate.window?.overrideUserInterfaceStyle = .light
        } else {
            AppDelegate.window?.overrideUserInterfaceStyle = .dark
        }
    }
    
    static func animateSoon(_ sender: UILabel?,_ senderView: UIView?, _ view: UIView){
        UIView.animate(withDuration: 1, delay: 0.25, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.2, options: [.repeat, .autoreverse], animations: {
            if sender == nil{
                senderView!.center.x = view.bounds.width - 100
            } else {
                sender!.center.x = view.bounds.width - 100
            }
        },completion : nil)
    }
    
    static func sumForm(str: String) -> String{
        var s: String!
        let b = str.components(separatedBy: CharacterSet(charactersIn: "."))
        s = String(Decimal(Int(b[0])!).formattedWithSeparator)
        return s+"."+b[1]
    }
    
    static func payForm(str: String) -> String{
        var s: String!
        let b = str.components(separatedBy: CharacterSet(charactersIn: "."))
        s = String(Decimal(Int(b[0])!).formattedWithSeparator)
        return s
    }
}

extension UIFont{
    enum FontType: String {
        case logo = "Kepler-296"
        case main = "MusticaPro-SemiBold"
        case contemp = "StretchProRegular"
    }
    static func font(_ size: CGFloat, _ type: FontType) -> UIFont{
        return UIFont(name: type.rawValue, size: size)!
    }
}
//MARK: Separator for cardNum
extension String {
    func separate(every stride: Int = 4, with separator: Character = " ") -> String {
        return String(enumerated().map { $0 > 0 && $0 % stride == 0 ? [separator, $1] : [$1]}.joined())
    }
}
//MARK: Separator for sum
extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}

