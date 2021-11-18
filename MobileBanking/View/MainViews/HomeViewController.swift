//
//  MainViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 12.08.2021.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    var labelName: UILabel!
    var labelCardNum: UILabel!
    var labelCVV: UILabel!
    var labelPIN: UILabel!
    //MARK: Pull to update
//    let refControl: UIRefreshControl! = {
//        let ref = UIRefreshControl()
//        ref.addTarget(self, action: #selector(refresh), for: .valueChanged)
//        return ref
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true

        view.backgroundColor = .systemBackground
        
        let id = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        db.collection("users").document(id!).getDocument { snapshot, err in
            if err == nil{
                if snapshot != nil && snapshot!.exists{
                    let docData = snapshot!.data()
                    DispatchQueue.main.async {
                        self.labelName.text = docData!["name"].map(String.init(describing:))!
                        self.labelCardNum.text = docData!["cardNum"].map(String.init(describing:))!
                        self.labelCVV.text = docData!["CVV"].map(String.init(describing:))!
                        self.labelPIN.text = docData!["PIN"].map(String.init(describing:))!
                    }
                }
            }
        }
        
        labelName = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.font(35, .main)
            label.textColor = .label
            
            view.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.centerY.equalToSuperview()
                maker.width.equalToSuperview().dividedBy(2)
                maker.height.equalTo(50)
            }
            return label
        }()
        
        labelCardNum = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.font(35, .main)
            label.textColor = .label
            
            view.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.top.equalTo(labelName.snp.bottom).offset(20)
                maker.width.equalToSuperview().dividedBy(2)
                maker.height.equalTo(50)
            }
            return label
        }()
        
        labelCVV = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.font(35, .main)
            label.textColor = .label
            
            view.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.top.equalTo(labelCardNum.snp.bottom).offset(20)
                maker.width.equalToSuperview().dividedBy(2)
                maker.height.equalTo(50)
            }
            return label
        }()
        
        labelPIN = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.font(35, .main)
            label.textColor = .label
            
            view.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.top.equalTo(labelCVV.snp.bottom).offset(20)
                maker.width.equalToSuperview().dividedBy(2)
                maker.height.equalTo(50)
            }
            return label
        }()
    }
    
//    @objc private func refresh(_ sender: UIRefreshControl){
//        sender.endRefreshing()
//    }
}
