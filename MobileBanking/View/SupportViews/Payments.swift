//
//  Payments.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 20.11.2021.
//

import Foundation
import UIKit
import Firebase

class PaymentView: UITableView, UITableViewDelegate, UITableViewDataSource{
    
    var count: Int = 0 {
        didSet {
            reloadData()
        }
    }
    
    var payments: [QueryDocumentSnapshot] = []
   
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        backgroundColor = .secondarySystemBackground
        isScrollEnabled = true
        layer.cornerRadius = 15
        tableFooterView = UIView()
        register(PayViewCell.self, forCellReuseIdentifier: PayViewCell.id)
        rowHeight = 70
        delegate = self
        dataSource = self
        
    }
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (payments.isEmpty){
            let cell = tableView.dequeueReusableCell(withIdentifier: PayViewCell.id, for: indexPath) as! PayViewCell
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: PayViewCell.id, for: indexPath) as! PayViewCell
        cell.selectionStyle = .none
        cell.labelName.text = payments[indexPath.row].data()["name"] as! String
        
        //MARK: Set the date format
        let date = payments[indexPath.row].data()["timeStamp"] as! Timestamp
        let time = date.dateValue()
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "HH:mm, d MM y"

        cell.labelDate.text = formatter1.string(from: time)
        let str = Utils.payForm(str: payments[indexPath.row].data()["sum"] as! String)
        let str2 = payments[indexPath.row].data()["currency"] as! String
        cell.labelSum.text = str+str2
        return cell
    }
    
    func get(){
        let userId = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        db.collection("card").whereField("userId", isEqualTo: userId!).getDocuments  { snapshot, err in
            if err == nil && snapshot != nil{
                let docData = snapshot!.documents[0]
                db.collection("payment").whereField("accountId", in: docData["accountId"] as! [Any]).order(by: "timeStamp", descending: true).getDocuments  { snapshot1, err1 in
                    if err1 == nil && snapshot1 != nil{
                        let docData1 = snapshot1!.documents
                        self.payments = docData1
                        self.count = docData1.count
                    }
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

