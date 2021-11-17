//
//  ErrorVerifyViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 13.08.2021.
//

import UIKit
import SnapKit
import SpriteKit
import LocalAuthentication

class PasswordViewController: UIViewController {
    
    var faceContainer: UIView!
    var passwordContainer: UIView!
    var passwordFieldContainer: UIView!
    var leftEye: EyeView!
    var rightEye: EyeView!
    var mouthView: MouthView!
    let buttons = [[ButtonsView(value: 1, name: "1", img: nil),ButtonsView(value: 2, name: "2", img: nil),ButtonsView(value: 3, name: "3", img: nil)],[ButtonsView(value: 4, name: "4", img: nil),ButtonsView(value: 5, name: "5", img: nil),ButtonsView(value: 6, name: "6", img: nil)],[ButtonsView(value: 7, name: "7", img: nil),ButtonsView(value: 8, name: "8", img: nil),ButtonsView(value: 9, name: "9", img: nil)],[ButtonsView(value: nil, name: "Exit", img: UIImage(systemName: "power")),ButtonsView(value: 0, name: "0", img: nil),ButtonsView(value: nil, name: "Delete", img: UIImage(systemName: "delete.left.fill"))]]
    //MARK: Counting password to delete and input
    var k = 0
    var appPass = ""
    // MARK: Password ia a PIN from Firebase.
    let password = UserDefaults.standard.string(forKey: "password") ?? "1234"
    
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
        
        verify()
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
            LogIn().Home(self.view)
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
    
    func verify(){
        let context = LAContext()
        var error: NSError? = nil
        let reason = "Please authorize with touchID"
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else{
                        
                        //                        let vc = UINavigationController(rootViewController: PasswordViewController())
                        //                        vc.modalPresentationStyle = .fullScreen
                        //                        self?.present(vc, animated: true)
                        //                        let alert = UIAlertController(title: "Is it you?", message: "Bro, drink less! I can't let you in(", preferredStyle: .alert)
                        //                        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                        //                        self?.present(alert, animated: true, completion: nil)
                        return
                    }
                    self?.success()
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
    
    func checkGesture(){
        passwordFieldContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(fail)))
        for i in 0..<4{
            for j in 0..<3{
                buttons[i][j].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(identButton(sender: ))))
            }
        }
        // MARK: Button of logging out of profile.
//        buttons[3][0].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(identButton(sender: ))))
        buttons[3][2].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deletePass(sender: ))))
    }
    @objc func identButton(sender: UITapGestureRecognizer){
        if let button = sender.view as? ButtonsView {
            guard let val = button.value else{return}
            appPass += String(val)
            passwordStars()
        }
    }
    
    @objc func deletePass(sender: UITapGestureRecognizer){
        guard appPass != "" else {return}
        appPass.removeLast()
        guard k>0 && k<=4 else {return}
        k-=1
        view.viewWithTag(100*(k+1))?.removeFromSuperview()
    }
    
    func removeAllPass(){
        for i in 0...3{
            view.viewWithTag(100*(i+1))?.removeFromSuperview()
        }
        appPass = ""
        k=0
    }
    
    func checkPass(){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            if (self.appPass == self.password){
                self.success()
            }
            else {
                self.fail()
                self.removeAllPass()
            }
        }
    }
    
    func passwordStars(){
        guard k<4 else {return}
        let container = UIView()
        passwordFieldContainer.addSubview(container)
        container.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
            maker.width.equalToSuperview().inset(view.frame.size.width/4)
            maker.height.equalToSuperview()
        }
        let point = UIView()
        point.layer.cornerRadius = 20
        point.tag = 100*(k+1)
        point.backgroundColor = .secondaryLabel
        container.addSubview(point)
        point.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(Double(view.frame.size.width/(4*3))*Double(k))
            maker.centerY.equalToSuperview()
            maker.width.equalTo(view.frame.size.width/(4*4))
            maker.height.equalTo(view.frame.size.width/(4*4))
        }
        guard k<=3 else {return}
        k+=1
        if (k==4){
            checkPass()
        }
    }
}
