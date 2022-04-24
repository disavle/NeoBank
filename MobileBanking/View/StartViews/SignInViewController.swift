//
//  SignInViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 17.10.2021.
//

import UIKit
import FirebaseAuth
import Firebase

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    var logo: UILabel!
    var email: UILabel!
    var pass: UILabel!
    var emailInput: UITextField!
    var passInput: UITextField!
    var confirm: UIButton!
    var signUp: UIButton!
    var error: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailInput.delegate = self
        passInput.delegate = self
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .tertiarySystemBackground
        
        navigationController?.navigationBar.isHidden = true
            
        //MARK: Hide keyboard
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(dissmisskeyboard))
        self.view.addGestureRecognizer(tap)
        
        logo = {
            let label = UILabel()
            label.text = "NeoBank"
            label.textAlignment = .center
            label.font = UIFont.font(40, .logo)
            label.textColor = .label
            view.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.top.equalToSuperview().offset(180)
                maker.centerX.equalToSuperview()
                maker.width.equalToSuperview().dividedBy(1.5)
                maker.height.equalTo(50)
            }
            return label
        }()
        
        error = {
            let label = UILabel()
            label.text = "Некорректные данные"
            label.alpha = 0
            label.textAlignment = .center
            label.font = UIFont.font(15, .main)
            label.textColor = .systemRed
            view.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.top.equalTo(logo.snp.bottom).offset(17)
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
            field.returnKeyType = .next
            field.font = UIFont.font(15, .main)
            field.autocapitalizationType = .words
            field.autocorrectionType = .no
            field.attributedPlaceholder = NSAttributedString(string: "example@email.com",attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel, NSAttributedString.Key.font: UIFont.font(15, .main)])
            view.addSubview(field)
            field.snp.makeConstraints { maker in
                maker.top.equalTo(error.snp.bottom).offset(40)
                maker.centerX.equalToSuperview()
                maker.width.equalToSuperview().dividedBy(1.2)
                maker.height.equalTo(30)
            }
            return field
        }()
        
        email = {
            let label = UILabel()
            label.text = "Email"
            label.font = UIFont.font(15, .main)
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
            field.returnKeyType = .join
            field.font = UIFont.font(15, .main)
            field.autocapitalizationType = .words
            field.autocorrectionType = .no
            field.attributedPlaceholder = NSAttributedString(string: "bKM46AUzgnXBCWmZ8eCh",attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel, NSAttributedString.Key.font: UIFont.font(15, .main)])
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
            label.text = "Пароль"
            label.font = UIFont.font(15, .main)
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
            button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
            button.setTitle("Войти", for: .normal)
            button.setTitleColor(.label, for: .normal)
            button.titleLabel?.font = UIFont.font(20, .main)
            button.layer.cornerRadius = 15
            button.clipsToBounds = true
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
            button.addTarget(self, action: #selector(goTosignUp), for: .touchUpInside)
            button.setTitle("Зарегистрироваться", for: .normal)
            button.setTitleColor(.secondaryLabel, for: .normal)
            button.titleLabel?.font = UIFont.font(12, .main)
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
    
    // MARK: When authorization will be done - it is disabled.
    @objc func signIn(){
        let cleanedEmail = self.emailInput.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedPass = self.passInput.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: cleanedEmail ?? "", password: cleanedPass ?? "") { result, err in
            if err != nil{
                if let errCode = AuthErrorCode(rawValue: err!._code) {
                    switch errCode {
                    case .unverifiedEmail:
                        self.error.text = "Такого email нет :("
                        self.error.alpha = 1
                    case .wrongPassword:
                        self.error.text = "Забыл пароль что ли?"
                        self.error.alpha = 1
                    default:
                        self.error.text = "Неверный логин и пароль!"
                        self.error.alpha = 1
                    }
                }
            } else {
                //MARK: Check once launch the app
                UserDefaults.standard.set(true, forKey: "verify")
                self.error.alpha = 0
                LogIn().Home(self.view)
            }
        }
    }
    
    @objc func goTosignUp(){
        let vc = SignUpViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
    
    //MARK: Keyboard next/done button
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.emailInput:
            self.passInput.becomeFirstResponder()
        default:
            self.passInput.resignFirstResponder()
        }
    }
    
    //MARK: Keyboard dismiss in touch
    
    @objc func dissmisskeyboard (){
        self.view.endEditing (true)
    }
}
