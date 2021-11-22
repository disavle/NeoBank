//
//  Sum.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 20.11.2021.
//

import Foundation
import UIKit
import Firebase

class SumView{
    var sum: UIView!
    var labelSum: UILabel!
    
    init(view: UIView, extraView: UIView?){
        sum = {
            let sum = UIView()
            sum.backgroundColor = .secondarySystemBackground
            sum.layer.cornerRadius = 15
            
            //MARK: Add payment Fix for demonstration
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.addPay(sender:)))
            sum.addGestureRecognizer(tapGesture)
            sum.isUserInteractionEnabled = true
            
            view.addSubview(sum)
            sum.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.top.equalTo(extraView!.snp.bottom).offset(15)
                maker.width.equalToSuperview().dividedBy(1.1)
                maker.height.equalToSuperview().dividedBy(6)
            }
            return sum
        }()
        
        labelSum = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.font(25, .contemp)
            label.textColor = .label
            sum.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.centerY.equalToSuperview()
                maker.width.equalToSuperview()
                maker.height.equalToSuperview()
            }
            return label
        }()
    }
    
    func getSum(){
        let userId = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        db.collection("card").whereField("userId", isEqualTo: userId!).getDocuments  { snapshot, err in
            if err == nil && snapshot != nil{
                let docData = snapshot!.documents[0]
                db.collection("account").whereField("cardId", isEqualTo: docData["id"].map(String.init(describing:))!).getDocuments  { snapshot1, err1 in
                    if err1 == nil && snapshot1 != nil{
                        let docData1 = snapshot1!.documents[0]
                        self.labelSum.text = Utils.sumForm(str: docData1["sum"].map(String.init(describing:))!)+docData1["currency"].map(String.init(describing:))!
                    }
                }
            }
        }
    }
    
    //MARK: Add payment Fix for demonstration
    @objc func addPay(sender: UITapGestureRecognizer) {
        let userId = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        let paymentId = UUID().uuidString
        db.collection("card").whereField("userId", isEqualTo: userId!).getDocuments  { snapshot, err in
            if err == nil && snapshot != nil{
                let docData = snapshot!.documents[0]
                let doc = docData["accountId"] as! [Any]
                db.collection("payment").document(paymentId).setData(["id":paymentId,"MCC":"\(Int.random(in: 1000...9999))", "accountId": doc[0] as! String, "sum":"\(Int.random(in: 50...99999))", "timeStamp": Date(timeIntervalSinceNow: 2), "currency":Currency.allCases.randomElement()!.rawValue, "name":Target.allCases.randomElement()!.rawValue ]){ (err) in
                    if err != nil{
                        print("Error auth")
                    } else {
                        HomeViewController.shared.pay.get()
                    }
                }
            }
        }
    }
}
