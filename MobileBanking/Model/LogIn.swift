//
//  LogIn.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 17.11.2021.
//

import Foundation
import UIKit

class LogIn{
    func Home(_ view: UIView){
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "nairasign.square"), tag: 0)
        homeVC.tabBarItem.selectedImage = UIImage(systemName: "nairasign.square.fill")
        let paymentsVC = PaymentsViewController()
        paymentsVC.tabBarItem = UITabBarItem(title: "Переводы", image: UIImage(systemName: "wave.3.right.circle"), tag: 1)
        paymentsVC.tabBarItem.selectedImage = UIImage(systemName: "wave.3.right.circle.fill")
        let chatVC = ChatViewController()
        chatVC.tabBarItem = UITabBarItem(title: "Чат", image: UIImage(systemName: "bolt.horizontal"), tag: 2)
        chatVC.tabBarItem.selectedImage = UIImage(systemName: "bolt.horizontal.fill")
        let accountVC = ProfileViewController()
        accountVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "eye"), tag: 3)
        accountVC.tabBarItem.selectedImage = UIImage(systemName: "eye.fill")
        let accountNav = UINavigationController(rootViewController: accountVC)
        let tabBarController = BubbleTabBarController()
        tabBarController.viewControllers = [homeVC, paymentsVC, chatVC, accountNav]
        view.window?.rootViewController = tabBarController
        view.window?.makeKeyAndVisible()
    }
    func goToPass(_ window: UIWindow){
        let vc = PasswordViewController()
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
    func goToSignIn(_ window: UIWindow){
        let vc = SignInViewController()
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}
