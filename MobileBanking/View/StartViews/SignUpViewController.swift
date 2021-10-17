//
//  SignUpViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 17.10.2021.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var logo: UILabel!
    var name: UILabel!
    var email: UILabel!
    var pass: UILabel!
    var passConf: UILabel!
    var agreeLab: UILabel!
    var agree: Checkbox!
    var nameInput: UITextField!
    var emailInput: UITextField!
    var passInput: UITextField!
    var passConfInput: UITextField!
    var confirm: UIButton!
    var signIn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .tertiarySystemBackground
        
        navigationController?.navigationBar.isHidden = true
        
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
        
        nameInput = {
            let field = UITextField()
            field.backgroundColor = .secondarySystemBackground
            field.layer.cornerRadius = 10
            field.textColor = .label
            field.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
            field.returnKeyType = .done
            field.font = UIFont(name: "Kepler-296", size: 15)
            field.autocapitalizationType = .words
            field.autocorrectionType = .no
            field.attributedPlaceholder = NSAttributedString(string: "Alex",attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel, NSAttributedString.Key.font: UIFont(name: "Kepler-296", size: 15)!])
            view.addSubview(field)
            field.snp.makeConstraints { maker in
                maker.top.equalTo(logo.snp.bottom).offset(70)
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
            field.returnKeyType = .done
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
                maker.left.equalTo(nameInput)
                maker.width.equalTo(100)
                maker.height.equalTo(20)
            }
            return label
        }()
        
        passConfInput = {
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
                maker.top.equalTo(passInput.snp.bottom).offset(70)
                maker.centerX.equalToSuperview()
                maker.width.equalToSuperview().dividedBy(1.2)
                maker.height.equalTo(30)
            }
            return field
        }()
        
        passConf = {
            let label = UILabel()
            label.text = "Confirm password"
            label.font = UIFont(name: "Kepler-296", size: 15)
            label.textColor = .label
            view.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.bottom.equalTo(passConfInput.snp.top).inset(-10)
                maker.left.equalTo(nameInput)
                maker.width.equalTo(200)
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
                maker.top.equalTo(passConfInput.snp.bottom).offset(50)
                maker.left.equalTo(pass)
                maker.width.equalTo(view.frame.size.width/16)
                maker.height.equalTo(view.frame.size.width/16)
            }
            return agree
        }()
        
        agreeLab = {
            let label = UILabel()
            label.text = "Agree with ..."
            label.font = UIFont(name: "Kepler-296", size: 10)
            label.textColor = .label
            view.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.centerY.equalTo(agree.snp.centerY)
                maker.left.equalTo(agree.snp.right).inset(-15)
                maker.width.equalTo(200)
                maker.height.equalTo(20)
            }
            return label
        }()
        
        confirm = {
            let button = UIButton()
            button.addTarget(self, action: #selector(test), for: .touchUpInside)
            button.backgroundColor = .systemGray3
            button.setTitle("Sign Up", for: .normal)
            button.setTitleColor(.label, for: .normal)
            button.titleLabel?.font = UIFont(name: "Kepler-296", size: 20)
            button.layer.cornerRadius = 15
            button.clipsToBounds = true
            button.isEnabled = false
            view.addSubview(button)
            button.snp.makeConstraints { maker in
                maker.top.equalTo(agree.snp.bottom).offset(60)
                maker.centerX.equalToSuperview()
                maker.width.equalToSuperview().dividedBy(2)
                maker.height.equalTo(40)
            }
            return button
        }()
        
        signIn = {
            let button = UIButton()
            button.addTarget(self, action: #selector(goTosignIn), for: .touchUpInside)
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
    
    @objc func goTosignIn(){
        let vc = SignInViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
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
    // MARK: When authorization will be done - it is disabled.
    @objc func test(){
        let vc = PasswordViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
