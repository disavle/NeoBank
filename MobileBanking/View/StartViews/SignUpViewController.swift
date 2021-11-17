//
//  SignUpViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 17.10.2021.
//

import UIKit
import SafariServices
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    var logo: UILabel!
    var name: UILabel!
    var email: UILabel!
    var pass: UILabel!
    var agreeLab: UILabel!
    var agree: Checkbox!
    var nameInput: UITextField!
    var emailInput: UITextField!
    var passInput: UITextField!
    var confirm: UIButton!
    var license: UIButton!
    var signIn: UIButton!
    var error: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameInput.delegate = self
        emailInput.delegate = self
        passInput.delegate = self
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .tertiarySystemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeSignUp))
        
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
                maker.top.equalToSuperview().offset(100)
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
            label.font = UIFont(name: "Kepler-296", size: 15)
            label.textColor = .systemRed
            view.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.top.equalTo(logo.snp.bottom).offset(10)
                maker.centerX.equalToSuperview()
                maker.width.equalToSuperview().dividedBy(1.5)
                maker.height.equalTo(50)
            }
            return label
        }()
        
        nameInput = {
            let field = UITextField()
            field.backgroundColor = .secondarySystemBackground
            field.layer.cornerRadius = 10
            field.textColor = .label
            field.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
            field.returnKeyType = .next
            field.font = UIFont(name: "Kepler-296", size: 15)
            field.autocapitalizationType = .words
            field.autocorrectionType = .no
            field.attributedPlaceholder = NSAttributedString(string: "Alex",attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel, NSAttributedString.Key.font: UIFont(name: "Kepler-296", size: 15)!])
            view.addSubview(field)
            field.snp.makeConstraints { maker in
                maker.top.equalTo(error.snp.bottom).offset(15)
                maker.centerX.equalToSuperview()
                maker.width.equalToSuperview().dividedBy(1.2)
                maker.height.equalTo(30)
            }
            return field
        }()
        
        name = {
            let label = UILabel()
            label.text = "Name"
            label.font = UIFont(name: "Kepler-296", size: 15)
            label.textColor = .label
            view.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.bottom.equalTo(nameInput.snp.top).inset(-10)
                maker.left.equalTo(nameInput)
                maker.width.equalTo(100)
                maker.height.equalTo(20)
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
            field.font = UIFont(name: "Kepler-296", size: 15)
            field.autocapitalizationType = .words
            field.autocorrectionType = .no
            field.attributedPlaceholder = NSAttributedString(string: "example@email.com",attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel, NSAttributedString.Key.font: UIFont(name: "Kepler-296", size: 15)!])
            view.addSubview(field)
            field.snp.makeConstraints { maker in
                maker.top.equalTo(nameInput.snp.bottom).offset(70)
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
                maker.left.equalTo(nameInput)
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
                maker.left.equalTo(nameInput)
                maker.width.equalTo(100)
                maker.height.equalTo(20)
            }
            return label
        }()
        
        agree = {
            let agree = Checkbox()
            agree.uncheckedBorderColor = .label
            agree.checkedBorderColor = .label
            agree.borderStyle = .circle
            agree.checkmarkColor = .label
            agree.checkmarkStyle = .circle
            agree.useHapticFeedback = true
            agree.increasedTouchRadius = 15
            agree.addTarget(self, action: #selector(checkboxValueChanged(sender:)), for: .valueChanged)
            view.addSubview(agree)
            agree.snp.makeConstraints { maker in
                maker.top.equalTo(passInput.snp.bottom).offset(30)
                maker.left.equalTo(pass)
                maker.width.equalTo(view.frame.size.width/16)
                maker.height.equalTo(view.frame.size.width/16)
            }
            return agree
        }()
        
        agreeLab = {
            let label = UILabel()
            label.text = "Agree with a "
            label.font = UIFont(name: "Kepler-296", size: 10)
            label.textColor = .label
            view.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.centerY.equalTo(agree.snp.centerY)
                maker.left.equalTo(agree.snp.right).inset(-15)
                maker.width.equalTo(69)
                maker.height.equalTo(20)
            }
            return label
        }()
        
        license = {
            let button = UIButton()
            button.addTarget(self, action: #selector(openLicense), for: .touchUpInside)
            button.setTitle("license", for: .normal)
            button.setTitleColor(.systemPink, for: .normal)
            button.titleLabel?.font = UIFont(name: "Kepler-296", size: 10)
            view.addSubview(button)
            button.snp.makeConstraints { maker in
                maker.centerY.equalTo(agree.snp.centerY).offset(1)
                maker.left.equalTo(agreeLab.snp.right)
                maker.width.equalTo(35)
                maker.height.equalTo(20)
            }
            return button
        }()
        
        confirm = {
            let button = UIButton()
            button.backgroundColor = .systemGray3
            button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
            button.setTitle("Sign Up", for: .normal)
            button.setTitleColor(.label, for: .normal)
            button.titleLabel?.font = UIFont(name: "Kepler-296", size: 20)
            button.layer.cornerRadius = 15
            button.clipsToBounds = true
            button.isEnabled = false
            view.addSubview(button)
            button.snp.makeConstraints { maker in
                maker.top.equalTo(agree.snp.bottom).offset(40)
                maker.centerX.equalToSuperview()
                maker.width.equalToSuperview().dividedBy(2)
                maker.height.equalTo(40)
            }
            return button
        }()
        
        signIn = {
            let button = UIButton()
            button.addTarget(self, action: #selector(closeSignUp), for: .touchUpInside)
            button.setTitle("Sign In", for: .normal)
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
    
    func validateFields() -> String?{
        if nameInput.text?.trimmingCharacters(in: . whitespacesAndNewlines) == "" ||
            emailInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passInput.text? .trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        //MARK: Validation
//        let cleanedPassword = passInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        if Utils.isPasswordValid(cleanedPassword) == false{
//            //Password isn't secure
//        }
        return nil
    }
    
    @objc func signUp(){
        let cleanedName = self.nameInput.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedEmail = self.emailInput.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedPass = self.passInput.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().createUser(withEmail: cleanedEmail ?? "", password: cleanedPass ?? "") { (result, err) in
            if err != nil{
                if let errCode = AuthErrorCode(rawValue: err!._code) {
                    switch errCode {
                    case .invalidEmail:
                        self.error.text = "Неподходящий email!"
                        self.error.alpha = 1
                    case .emailAlreadyInUse:
                        self.error.text = "Чел с таким email уже есть!"
                        self.error.alpha = 1
                    case .weakPassword:
                        self.error.text = "Отстойный пароль!"
                        self.error.alpha = 1
                    default:
                        self.error.text = "Какая-то ошибка"
                        self.error.alpha = 1
                    }
                }
            } else {
                self.error.alpha = 0
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["id":result!.user.uid,"name":cleanedName ?? "", "email":cleanedEmail ?? "","password":cleanedPass ?? "", "cardNum":Int.random(in: 100000000000...999999999999), "PIN":Int.random(in: 1000...9999), "CVV":Int.random(in: 100...999)]){ (err) in
                    if err != nil{
                        print("Error auth")
                        self.error.alpha = 1
                        self.error.text = "Траблы с сервером :("
                    } else {
                        LogIn().Home(self.view)
                    }
                }
            }
        }
    }
    
    @objc func closeSignUp(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func checkboxValueChanged(sender: Checkbox) {
        if (sender.isChecked){
            confirm.backgroundColor = .systemPink
            confirm.isEnabled = true
        } else {
            confirm.backgroundColor = .systemGray3
            confirm.isEnabled = false
        }
    }
    
    @objc func openLicense(){
        if let url = URL(string: "https://disavle.github.io/license"){
            let sfvc = SFSafariViewController(url: url)
            present(sfvc, animated: true, completion: nil)
        }
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
        case self.nameInput:
            self.emailInput.becomeFirstResponder()
        case self.emailInput:
            self.passInput.becomeFirstResponder()
        default:
            self.passInput.resignFirstResponder()
        }
    }
}
