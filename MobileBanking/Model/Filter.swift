//
//  Filter.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 04.03.2022.
//

import UIKit
import Firebase

class Filter{
    static func getCategories(filt: String? ,_ completion: @escaping ([String],[QueryDocumentSnapshot])->()){
        let userId = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        db.collection("card").whereField("userId", isEqualTo: userId!).getDocuments  { snapshot, err in
            if err == nil && snapshot != nil{
                let docData = snapshot!.documents[0]
                db.collection("payment").whereField("accountId", in: docData["accountId"] as! [Any]).order(by: "timeStamp", descending: true).getDocuments  { snapshot1, err1 in
                    if err1 == nil && snapshot1 != nil{
                        let docData1 = snapshot1!.documents
                        let set = docData1.map { i in
                            i.data()["name"]
                        }
                        let ar = Array(Set(set as! [String]))
                        if filt != nil{
                            let res = docData1.filter { i in
                                (i.data()["name"] as! String) == filt
                            }
                            completion(ar,res)
                        } else {
                            completion(ar,docData1)
                        }
                    }
                }
            }
        }
    }
}
