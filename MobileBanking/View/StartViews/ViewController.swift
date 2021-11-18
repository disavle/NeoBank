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
    
    override func loadView() {
        super.loadView()
        let style = UserDefaults.standard.value(forKey: "style") as! Bool
        setStyle(style)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        label = {
            let label = UILabel()
            label.text = "NeoBank"
            label.textAlignment = .center
            label.font = UIFont.font(35, .logo)
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
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1.6) {
            // MARK: Authorization mode
//            LogIn().goToSignIn(self.view)
            LogIn().Home(self.view)
        }
        
    }
    
    private func setStyle(_ check:Bool){
        if (check == false){
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


