//
//  DB.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 19.11.2021.
//

import Foundation
import Firebase

class DB{
    static let shared = DB()
    
    func get(col: String, docName: String, completion: @escaping (User?) -> Void){
        let db = Firestore.firestore()
        db.collection(col).document(docName).getDocument { document, err in
            guard err == nil else {return}
            guard document != nil && document!.exists else {return}
            let doc = User(id: (document?.get("id") as! String), name: (document?.get("name") as! String), email: (document?.get("email") as! String))
            completion(doc)
        }
    }
}
