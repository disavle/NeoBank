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
    private var sumBefore = ""
    private var indecator: UIActivityIndicatorView!
    
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
        
        indecator = {
            let ind = UIActivityIndicatorView()
            ind.style = .large
            ind.color = .systemPink
            sum.addSubview(ind)
            ind.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            return ind
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
                        self.sumBefore = docData1["sum"].map(String.init(describing:))!
                        self.labelSum.text = Utils.sumForm(str: docData1["sum"].map(String.init(describing:))!)+docData1["currency"].map(String.init(describing:))!
                    }
                }
            }
        }
    }
    
    //MARK: Add payment Fix for demonstration
    @objc func addPay(sender: UITapGestureRecognizer) {
        indecator.startAnimating()
        let userId = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        let paymentId = UUID().uuidString
        let changedSum = Int.random(in: 50...9999)
        db.collection("card").whereField("userId", isEqualTo: userId!).getDocuments  { snapshot, err in
            if err == nil && snapshot != nil{
                let docData = snapshot!.documents[0]
                let doc = docData["accountId"] as! [Any]
                db.collection("payment").document(paymentId).setData(["id":paymentId,"MCC":"\(Int.random(in: 1000...9999))", "accountId": doc[0] as! String, "sum":"\(changedSum)", "timeStamp": Date(timeIntervalSinceNow: 2), "currency":Currency.dol.rawValue, "name":Target.allCases.randomElement()!.rawValue ]){ (err) in
                    if err != nil{
                        print("Error auth")
                    } else {
                        self.changeSum(change: changedSum)
                        HomeViewController.shared.pay.get { k in
                            if k{
                                TapticManager.shared.vibrateFeedback(for: .success)
                                self.indecator.stopAnimating()
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    func changeSum(change: Int){
        let userId = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        db.collection("card").whereField("userId", isEqualTo: userId!).getDocuments  { snapshot, err in
            if err == nil && snapshot != nil{
                let docData = snapshot!.documents[0]
                db.collection("account").whereField("cardId", isEqualTo: docData["id"].map(String.init(describing:))!).getDocuments  { snapshot1, err1 in
                    if err1 == nil && snapshot1 != nil{
                        let docData1 = snapshot1!.documents.first
                        docData1?.reference.updateData(["sum": "\(Double(self.sumBefore)!-Double(change))"])
                        self.getSum()
                    }
                }
            }
        }
    }
}

