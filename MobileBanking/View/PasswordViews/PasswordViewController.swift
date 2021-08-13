//
//  ErrorVerifyViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 13.08.2021.
//

import UIKit
import SnapKit

class PasswordViewController: UIViewController {
    
    var faceContainer: UIView!
    var passwordContainer: UIView! // input password
    var passwordFieldContainer: UIView! // field password
    var leftEye: EyeView!
    var rightEye: EyeView!
    var mouthView: MouthView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        
        faceContainer = {
            let container = UIView()
            view.addSubview(container)
            container.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.top.equalToSuperview().inset(120)
                maker.width.equalToSuperview().dividedBy(1.5)
                maker.height.equalToSuperview().dividedBy(3.5)
            }
            return container
        }()
        
        passwordFieldContainer = {
            let container = UIView()
            container.backgroundColor = .blue
            view.addSubview(container)
            container.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.top.equalTo(faceContainer.snp.bottom).offset(20)
                maker.width.equalToSuperview().dividedBy(1.2)
                maker.height.equalToSuperview().dividedBy(12)
            }
            return container
        }()
        
        passwordContainer = {
            let container = UIView()
            container.backgroundColor = .blue
            view.addSubview(container)
            container.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.top.equalTo(passwordFieldContainer.snp.bottom).offset(20)
                maker.width.equalToSuperview().dividedBy(1.2)
                maker.height.equalToSuperview().dividedBy(2.7)
            }
            return container
        }()
        
        leftEye = {
            let eye = EyeView()
            eye.mode = .left
            faceContainer.addSubview(eye)
            eye.snp.makeConstraints { maker in
                maker.left.equalToSuperview()
                maker.top.equalToSuperview()
                maker.width.equalToSuperview().dividedBy(2)
                maker.height.equalToSuperview().dividedBy(2)
            }
            return eye
        }()
        
        rightEye = {
            let eye = EyeView()
            eye.mode = .right
            faceContainer.addSubview(eye)
            eye.snp.makeConstraints { maker in
                maker.right.equalToSuperview()
                maker.top.equalToSuperview()
                maker.width.equalToSuperview().dividedBy(2)
                maker.height.equalToSuperview().dividedBy(2)
            }
            return eye
        }()
        
        mouthView = {
            let mouth = MouthView()
            faceContainer.addSubview(mouth)
            mouth.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.bottom.equalTo(faceContainer.snp.bottom).offset(10)
                maker.width.equalToSuperview().dividedBy(2.7)
                maker.height.equalToSuperview().dividedBy(3)
            }
            return mouth
        }()
        
        passwordFieldContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(fail)))
        passwordContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(success)))
    }
    
    @objc func fail(){
        TapticManager.shared.vibrateFeedback(for: .error)
        shake()
    }
    
    @objc func success(){
        TapticManager.shared.vibrateFeedback(for: .success)
        view.backgroundColor = .systemGreen
        rightEye.progress = 2
        leftEye.progress = 2
        mouthView.progress = 2
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
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
    
    func shake() {
        faceContainer.shake(count: 10, amplitude: 4.5)
    }
}
