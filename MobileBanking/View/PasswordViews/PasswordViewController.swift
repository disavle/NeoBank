//
//  ErrorVerifyViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 13.08.2021.
//

import UIKit
import SnapKit
import SpriteKit

class PasswordViewController: UIViewController {
    
    var faceContainer: UIView!
    var passwordContainer: UIView!
    var passwordFieldContainer: UIView!
    var leftEye: EyeView!
    var rightEye: EyeView!
    var mouthView: MouthView!
    let buttons = [[ButtonsView(value: 1, name: "1", img: nil)        ,ButtonsView(value: 2, name: "2", img: nil),ButtonsView(value: 3, name: "3", img: nil)],[ButtonsView(value: 4, name: "4", img: nil),ButtonsView(value: 5, name: "5", img: nil),ButtonsView(value: 6, name: "6", img: nil)],[ButtonsView(value: 7, name: "7", img: nil),ButtonsView(value: 8, name: "8", img: nil),ButtonsView(value: 9, name: "9", img: nil)],[ButtonsView(value: nil, name: "Exit", img: UIImage(systemName: "power")),ButtonsView(value: 0, name: "0", img: nil),ButtonsView(value: nil, name: "Delete", img: UIImage(systemName: "delete.left.fill"))]]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        navigationController?.navigationBar.isHidden = true
        
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
            container.backgroundColor = .secondarySystemBackground
            container.layer.cornerRadius = 20
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
            container.backgroundColor = .secondarySystemBackground
            container.layer.cornerRadius = 20
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
        
        // MARK: Generator buttons for password.
        
        buttonsGenerate()
        
        checkGesture()
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
            
            self.navigationController?.pushViewController(tabBarController, animated: true)
        }
    }
    
    func shake() {
        faceContainer.shake(count: 10, amplitude: 4.5)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var position: CGPoint!
        if let touch = touches.first {
            position = touch.location(in: view)
        }
        [leftEye, rightEye].forEach {
            $0?.track(to: $0?.convert(position, from: view), animated: ($0?.trackPoint == nil))
        }
    }
    
    func buttonsGenerate(){
        for i in 0..<4{
            for j in 0..<3{
                let button = buttons[i][j]
                let buttonContainer = ButtonContainer()
                passwordContainer.addSubview(buttonContainer)
                buttonContainer.snp.makeConstraints { maker in
                    maker.top.equalToSuperview().inset(Int(view.frame.size.height/2.7/4)*i)
                    maker.left.equalToSuperview().inset(Int(view.frame.size.width/1.2/3)*j)
                    maker.width.equalToSuperview().dividedBy(3)
                    maker.height.equalToSuperview().dividedBy(4)
                }
                buttonContainer.addSubview(button)
                button.snp.makeConstraints { maker in
                    if(j==0 && i != 3){
                        maker.centerY.equalToSuperview()
                        maker.right.equalToSuperview()
                        maker.width.equalToSuperview().dividedBy(1.4)
                        maker.height.equalToSuperview().dividedBy(1.4)
                    }
                    if(j==1 && i != 3){
                        maker.centerY.equalToSuperview()
                        maker.centerX.equalToSuperview()
                        maker.width.equalToSuperview().dividedBy(1.4)
                        maker.height.equalToSuperview().dividedBy(1.4)
                    }
                    if(j==2 && i != 3){
                        maker.centerY.equalToSuperview()
                        maker.left.equalToSuperview()
                        maker.width.equalToSuperview().dividedBy(1.4)
                        maker.height.equalToSuperview().dividedBy(1.4)
                    }
                    if (button.img != nil && i==3){
                        maker.top.equalToSuperview().inset(12)
                        maker.width.equalToSuperview().dividedBy(2)
                        maker.height.equalToSuperview().dividedBy(2)
                        button.button.layer.cornerRadius = 10
                        if(button.name == "Exit"){
                            maker.right.equalToSuperview()
                        }else {
                            maker.left.equalToSuperview()
                        }
                    }
                    if (button.img == nil && i==3){
                        maker.centerX.equalToSuperview()
                        maker.centerY.equalToSuperview()
                        maker.width.equalToSuperview().dividedBy(1.4)
                        maker.height.equalToSuperview().dividedBy(1.4)
                    }
                }
            }
        }
    }
    
    func checkGesture(){
        passwordFieldContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(fail)))
        passwordContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(success)))
    }
}
