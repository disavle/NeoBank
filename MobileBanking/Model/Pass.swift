//
//  Pass.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 18.11.2021.
//

import Foundation
import UIKit

class Pass{
    func goToPass(_ view: UIView){
    let vc = PasswordViewController()
        view.window?.rootViewController = vc
        view.window?.makeKeyAndVisible()
    }
}
