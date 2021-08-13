//
//  ViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 28.07.2021.
//
import SnapKit
import UIKit

class ViewController: UIViewController {
    
    var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.isHidden = true
        
        label = {
            let label = UILabel()
            label.text = "NeoBank"
            label.textAlignment = .center
            label.font = UIFont(name: "Kepler-296", size: 35)
            label.textColor = .label
            label.clipsToBounds = true
            label.layer.cornerRadius = 10
            label.backgroundColor = .systemPink
            label.alpha = 0
            UIView.animate(withDuration: 1.5) {
                label.alpha = 1
                label.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            }
            view.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.centerY.equalToSuperview()
                maker.width.equalToSuperview().dividedBy(2)
                maker.height.equalTo(50)
            }
            return label
        }()
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            TapticManager.shared.vibrateFeedback(for: .success)
            let homeVC = HomeViewController()
            homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "nairasign.square"), tag: 0)
            homeVC.tabBarItem.selectedImage = UIImage(systemName: "nairasign.square.fill")
            let paymentsVC = PaymentsViewController()
            paymentsVC.tabBarItem = UITabBarItem(title: "Payments", image: UIImage(systemName: "wave.3.right.circle"), tag: 1)
            paymentsVC.tabBarItem.selectedImage = UIImage(systemName: "wave.3.right.circle.fill")
            let chatVC = ChatViewController()
            chatVC.tabBarItem = UITabBarItem(title: "Chat", image: UIImage(systemName: "bolt.horizontal"), tag: 2)
            chatVC.tabBarItem.selectedImage = UIImage(systemName: "bolt.horizontal.fill")
            let accountVC = ProfileViewController()
            accountVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "eye"), tag: 3)
            accountVC.tabBarItem.selectedImage = UIImage(systemName: "eye.fill")
            let accountNav = UINavigationController(rootViewController: accountVC)

            let tabBarController = BubbleTabBarController()
            tabBarController.viewControllers = [homeVC, paymentsVC, chatVC, accountNav]

            tabBarController.modalPresentationStyle = .fullScreen
            self.present(tabBarController, animated: true)
        }
    }
}


