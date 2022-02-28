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
        paymentsVC.tabBarItem = UITabBarItem(title: "Акции", image: UIImage(systemName: "coloncurrencysign.circle"), tag: 1)
        paymentsVC.tabBarItem.selectedImage = UIImage(systemName: "coloncurrencysign.circle.fill")
        let paymentsNav = UINavigationController(rootViewController: paymentsVC)
        let chatVC = ChatViewController()
        chatVC.tabBarItem = UITabBarItem(title: "Чат", image: UIImage(systemName: "bolt.horizontal"), tag: 2)
        chatVC.tabBarItem.selectedImage = UIImage(systemName: "bolt.horizontal.fill")
        let accountVC = ProfileViewController()
        accountVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "eye"), tag: 3)
        accountVC.tabBarItem.selectedImage = UIImage(systemName: "eye.fill")
        let accountNav = UINavigationController(rootViewController: accountVC)
        let tabBarController = BubbleTabBarController()
        tabBarController.viewControllers = [homeVC, paymentsNav, chatVC, accountNav]
        view.window?.rootViewController = tabBarController
        view.window?.makeKeyAndVisible()
    }
    func goToPass(_ view: UIView){
        let vc = PasswordViewController()
        view.window?.rootViewController = vc
        view.window?.makeKeyAndVisible()
    }
    func goToSignIn(_ view: UIView){
        let vc = SignInViewController()
        view.window?.rootViewController = vc
        view.window?.makeKeyAndVisible()
    }
}
