//
//  Card.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 20.11.2021.
//

import Foundation
import UIKit
import Firebase

class Card{
    var labelCardNum: UILabel!
    var labelCardName: UILabel!
    var labelPIN: UILabel!
    var labelCVV: UILabel!
    var labelDate: UILabel!
    var mcLabel: UIImageView!
    var form: UIView!
    var ac: UIAlertController!
    var view: UIView!
    
    init(_ view: UIView){
        self.view = view
        form = {
            let form = UIView()
            form.backgroundColor = .systemPink
            form.layer.cornerRadius = 15
            view.addSubview(form)
            form.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.top.equalToSuperview().inset(30)
                maker.width.equalToSuperview().dividedBy(1.25)
                maker.height.equalToSuperview().dividedBy(4)
            }
            return form
        }()
        
        mcLabel = {
            let image = UIImage(named: "mc")
            let label = UIImageView(image: image)
            form.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.right.equalToSuperview().inset(20)
                maker.bottom.equalToSuperview().inset(10)
                maker.width.equalTo(62.94)
                maker.height.equalTo(44.71)
            }
            return label
        }()
        
        labelCardNum = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.font(13, .contemp)
            label.textColor = .label
            form.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.centerY.equalToSuperview().offset(30)
                maker.width.equalToSuperview().dividedBy(1.1)
                maker.height.equalTo(20)
            }
            return label
        }()
        
        labelCardName = {
            let label = UILabel()
            label.textAlignment = .left
            label.font = UIFont.font(25, .logo)
            label.textColor = .label
            form.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.left.equalToSuperview().offset(40)
                maker.top.equalToSuperview().offset(30)
                maker.width.equalToSuperview().dividedBy(1.25)
                maker.height.equalTo(25)
            }
            return label
        }()
        
        labelPIN = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.font(25, .contemp)
            label.textColor = .label
            label.alpha = 0
            form.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.centerY.equalToSuperview()
                maker.width.equalToSuperview().dividedBy(1.25)
                maker.height.equalTo(25)
            }
            return label
        }()
        
        labelCVV = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.font(13, .contemp)
            label.textColor = .label
            label.alpha = 0
            form.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.centerY.equalToSuperview().offset(30)
                maker.width.equalToSuperview().dividedBy(1.1)
                maker.height.equalTo(20)
            }
            return label
        }()
        
        labelDate = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.font(9, .contemp)
            label.textColor = .label
            label.alpha = 1
            form.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.left.equalToSuperview().offset(35)
                maker.centerY.equalTo(mcLabel.snp.centerY)
                maker.width.equalToSuperview().dividedBy(4)
                maker.height.equalTo(20)
            }
            return label
        }()
    }
    
    func getFront(){
        guard let id = Auth.auth().currentUser?.uid else {return}
        DB.shared.get(col: "user", docName: id) { doc in
            self.labelCardName.text = doc!.name
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.animationCard))
            self.form.addGestureRecognizer(tapGesture)
            self.form.isUserInteractionEnabled = true
        }
    }
    
    func getBack(_ viewController: UIViewController?){
        let userId = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        db.collection("card").whereField("userId", isEqualTo: userId!).getDocuments  { snapshot, err in
            if err == nil && snapshot != nil{
                let docData = snapshot!.documents[0]
                let changeCardNum = docData["cardNum"].map(String.init(describing:))!
                self.labelCardNum.text = "xxxx xxxx xxxx "+changeCardNum.dropFirst(12)
                self.labelPIN.text = docData["PIN"].map(String.init(describing:))!
                self.labelCVV.text = "CVV: \(docData["CVV"].map(String.init(describing:))!)"
                self.labelDate.text = self.dateForm(str: docData["expiredDate"].map(String.init(describing:))!)
                if(UserDefaults.standard.value(forKey: "alert") as? Bool != true){
                    self.ac = UIAlertController(title: "Твой PIN - код от приложения", message: "Твой код-пароль: \(docData["PIN"].map(String.init(describing:))!.separate(every: 4, with: " "))", preferredStyle: .alert)
                    self.ac.addAction(UIAlertAction(title: "Понял", style: .default, handler: nil))
                    viewController!.present(self.ac, animated: true, completion: nil)
                    UserDefaults.standard.setValue(true, forKey: "alert")
                }
            }
        }
    }
    
    @objc func animationCard(sender: UITapGestureRecognizer) {
        guard let a = sender.view else { return }
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
            if (self.mcLabel.alpha == 0){
                self.labelCardNum.alpha = 1
                self.labelCardName.alpha = 1
                self.mcLabel.alpha = 1
                self.labelPIN.alpha = 0
                self.labelCVV.alpha = 0
                self.labelDate.alpha = 1
                TapticManager.shared.vibrateFeedback(for: .success)
            } else {
                self.labelCVV.alpha = 1
                self.labelPIN.alpha = 1
                self.mcLabel.alpha = 0
                self.labelCardName.alpha = 0
                self.labelCardNum.alpha = 0
                self.labelDate.alpha = 0
                TapticManager.shared.vibrateFeedback(for: .warning)
            }
            self.getFront()
            self.getBack(nil)
        }
        UIView.animate(withDuration: 1, delay: 0.25, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.2, options: [], animations: {
            a.center.x = self.view.bounds.width - 100
        },completion: {_ in
            
            UIView.animate(withDuration: 1, delay: 0.25, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.2, options: [], animations: {
                a.center.x = self.view.center.x
            },completion: {_ in })})
    }
    
    
    func dateForm(str: String) -> String{
        var r: String!
        let b = str.components(separatedBy: CharacterSet(charactersIn: "/"))
        if (Int(b[0])! <= 9){
            r = "0"+str
        } else {
            r = str
        }
        return r
    }
}
