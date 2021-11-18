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
            UIApplication.shared.connectedScenes.forEach { (scene: UIScene) in
                (scene.delegate as? SceneDelegate)?.window?.overrideUserInterfaceStyle = .light
            }
        } else {
            UIApplication.shared.connectedScenes.forEach { (scene: UIScene) in
                (scene.delegate as? SceneDelegate)?.window?.overrideUserInterfaceStyle = .dark
            }
        }
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
