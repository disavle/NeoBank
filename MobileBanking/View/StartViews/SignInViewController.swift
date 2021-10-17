//
//  SignInViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 17.10.2021.
//

import UIKit

class SignInViewController: UIViewController {
    
    var logo: UILabel!
    var email: UILabel!
    var pass: UILabel!
    var emailInput: UITextField!
    var passInput: UITextField!
    var confirm: UIButton!
    var signUp: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .tertiarySystemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeSignIn))
        
        logo = {
            let label = UILabel()
            label.text = "NeoBank"
            label.textAlignment = .center
            label.font = UIFont(name: "Kepler-296", size: 40)
            label.textColor = .label
            view.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.top.equalToSuperview().offset(100)
                maker.centerX.equalToSuperview()
                maker.width.equalToSuperview().dividedBy(1.5)
                maker.height.equalTo(50)
            }
            return label
        }()
        
        emailInput = {
            let field = UITextField()
            field.backgroundColor = .secondarySystemBackground
            field.layer.cornerRadius = 10
            field.textColor = .label
            field.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
            field.returnKeyType = .done
            field.font = UIFont(name: "Kepler-296", size: 15)
            field.autocapitalizationType = .words
            field.autocorrectionType = .no
            field.attributedPlaceholder = NSAttributedString(string: "example@email.com",attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel, NSAttributedString.Key.font: UIFont(name: "Kepler-296", size: 15)!])
            view.addSubview(field)
            field.snp.makeConstraints { maker in
                maker.top.equalTo(logo.snp.bottom).offset(70)
                maker.centerX.equalToSuperview()
                maker.width.equalToSuperview().dividedBy(1.2)
                maker.height.equalTo(30)
            }
            return field
        }()
        
        email = {
            let label = UILabel()
            label.text = "Email"
            label.font = UIFont(name: "Kepler-296", size: 15)
            label.textColor = .label
            view.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.bottom.equalTo(emailInput.snp.top).inset(-10)
                maker.left.equalTo(emailInput)
                maker.width.equalTo(100)
                maker.height.equalTo(20)
            }
            return label
        }()
        
        passInput = {
            let field = UITextField()
            field.backgroundColor = .secondarySystemBackground
            field.layer.cornerRadius = 10
            field.textColor = .label
            field.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
            field.returnKeyType = .done
            field.font = UIFont(name: "Kepler-296", size: 15)
            field.autocapitalizationType = .words
            field.autocorrectionType = .no
            field.attributedPlaceholder = NSAttributedString(string: "qwerty123",attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel, NSAttributedString.Key.font: UIFont(name: "Kepler-296", size: 15)!])
            field.isSecureTextEntry = true
            view.addSubview(field)
            field.snp.makeConstraints { maker in
                maker.top.equalTo(emailInput.snp.bottom).offset(70)
                maker.centerX.equalToSuperview()
                maker.width.equalToSuperview().dividedBy(1.2)
                maker.height.equalTo(30)
            }
            return field
        }()
        
        pass = {
            let label = UILabel()
            label.text = "Password"
            label.font = UIFont(name: "Kepler-296", size: 15)
            label.textColor = .label
            view.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.bottom.equalTo(passInput.snp.top).inset(-10)
                maker.left.equalTo(emailInput)
                maker.width.equalTo(100)
                maker.height.equalTo(20)
            }
            return label
        }()
        
        confirm = {
            let button = UIButton()
            button.backgroundColor = .systemPink
            button.setTitle("Sign In", for: .normal)
            button.setTitleColor(.label, for: .normal)
            button.titleLabel?.font = UIFont(name: "Kepler-296", size: 20)
            button.layer.cornerRadius = 15
            button.clipsToBounds = true
            button.isEnabled = false
            view.addSubview(button)
            button.snp.makeConstraints { maker in
                maker.top.equalTo(passInput.snp.bottom).offset(60)
                maker.centerX.equalToSuperview()
                maker.width.equalToSuperview().dividedBy(2)
                maker.height.equalTo(40)
            }
            return button
        }()
        
        signUp = {
            let button = UIButton()
            button.addTarget(self, action: #selector(closeSignIn), for: .touchUpInside)
            button.setTitle("Sign Up", for: .normal)
            button.setTitleColor(.secondaryLabel, for: .normal)
            button.titleLabel?.font = UIFont(name: "Kepler-296", size: 17)
            view.addSubview(button)
            button.snp.makeConstraints { maker in
                maker.top.equalTo(confirm.snp.bottom).offset(15)
                maker.centerX.equalToSuperview()
                maker.width.equalToSuperview().dividedBy(2)
                maker.height.equalTo(20)
            }
            return button
        }()
    }
    
    @objc func closeSignIn(){
        dismiss(animated: true, completion: nil)
    }
}
