//
//  Filter.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 04.03.2022.
//

import UIKit
import Firebase

class Filter{
    static func getCategories(filt: [String]? ,_ completion: @escaping ([String],[QueryDocumentSnapshot], Int)->()){
        var sum = 0
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
                            var result = [QueryDocumentSnapshot]()
                            for i in docData1{
                                for j in filt!{
                                    if (i.data()["name"] as! String) == j{
                                        result.append(i)
                                        sum += Int(i.data()["sum"] as! String)!
                                    }
                                }
                            }
                            completion(ar,result,sum)
                        } else {
                            for i in docData1{
                                sum += Int(i.data()["sum"] as! String)!
                            }
                            completion(ar,docData1,sum)
                        }
                    }
                }
            }
        }
    }
}
