//
//  ViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 28.07.2021.
//
import SnapKit
import UIKit
import LocalAuthentication

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
        DispatchQueue.main.asyncAfter(deadline: .now()+1.6) { [weak self] in
            self?.verify()
        }
    }
    
    func verify(){
        let context = LAContext()
        var error: NSError? = nil
        let reason = "Please authorize with touchID"
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else{
                        
                        let vc = UINavigationController(rootViewController: PasswordViewController()) 
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc, animated: true)
                        
                        let alert = UIAlertController(title: "Is it you?", message: "Bro, drink less! I can't let you in(", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                        self?.present(alert, animated: true, completion: nil)
                        return
                    }
                    self?.successEntry()
                }
            }
        }
        else{
            let alert = UIAlertController(title: "You are sick!", message: "Bro, you can't use it(", preferredStyle: .alert)
            alert.view.tintColor = .systemPink
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func successEntry(){
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
        
        self.navigationController?.pushViewController(tabBarController, animated: true)
    }
}


