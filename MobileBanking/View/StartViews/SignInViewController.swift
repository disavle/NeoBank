//
//  SignInViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 17.10.2021.
//

import UIKit
import FirebaseDatabase
import BCryptSwift

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    var logo: UILabel!
    var email: UILabel!
    var pass: UILabel!
    var emailInput: UITextField!
    var passInput: UITextField!
    var confirm: UIButton!
    var signUp: UIButton!
    
    private let database = Database.database().reference()
    
    var val: [String: Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailInput.delegate = self
        passInput.delegate = self
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .tertiarySystemBackground
        
        navigationController?.navigationBar.isHidden = true
        
        //MARK: It's simple read database code
        
        database.child("3").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                return
            }
            self.val = value
            print ("Value : \(value) ")
        }
        
        
        //MARK: Hide keyboard
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(dissmisskeyboard))
        self.view.addGestureRecognizer(tap)
        
        logo = {
            let label = UILabel()
            label.text = "NeoBank"
            label.textAlignment = .center
            label.font = UIFont(name: "Kepler-296", size: 40)
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
                maker.top.equalTo(logo.snp.bottom).offset(100)
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
            button.addTarget(self, action: #selector(confurm), for: .touchUpInside)
            button.setTitle("Sign In", for: .normal)
            button.setTitleColor(.label, for: .normal)
            button.titleLabel?.font = UIFont(name: "Kepler-296", size: 20)
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
    
    // MARK: When authorization will be done - it is disabled.
    @objc func confurm(){
        if (BCryptSwift.verifyPassword(passInput.text ?? "", matchesHash: val.values.first as! String) ?? true){
            let vc = PasswordViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            print("Da")
        }
        print("pizda")
    }
    
    @objc func goTosignUp(){
        let vc = SignUpViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
    
    @objc func dissmisskeyboard (){
        self.view.endEditing (true)
    }
    
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
}
