//
//  MainViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 12.08.2021.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDataSource {
    
    var tableView: UITableView!
    //MARK: Pull to update
    let refControl: UIRefreshControl! = {
        let ref = UIRefreshControl()
        ref.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return ref
    }()
    //MARK: Once alert
    var ac: UIAlertController!
    var card: Card!
    var sum: SumView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: Check once launch the app
        UserDefaults.standard.set(true, forKey: "verify")
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemBackground
    }
    
    override func loadView() {
        super.loadView()
        
        tableView = {
            let tableView = UITableView()
            view.addSubview(tableView)
            tableView.snp.makeConstraints(){maker in
                maker.centerX.equalToSuperview()
                maker.bottom.equalToSuperview()
                maker.width.equalToSuperview()
                maker.height.equalToSuperview()
            }
            return tableView
        }()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "d")
        tableView.refreshControl = refControl
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        tableView.dataSource = self
        
        DispatchQueue.main.async {
            self.getFront()
//            self.getSum()
            self.getBack()
        }
        
        card = Card(tableView)
        sum = SumView(view: tableView, extraView: card.form)
        PaymentView(view: tableView, extraView: sum.sum)
    }
    
    func getFront(){
        guard let id = Auth.auth().currentUser?.uid else {return}
        DB.shared.get(col: "user", docName: id) { doc in
            self.card.labelCardName.text = doc!.name
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.animationCard))
            self.card.form.addGestureRecognizer(tapGesture)
            self.card.form.isUserInteractionEnabled = true
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "d", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    @objc private func refresh(_ sender: UIRefreshControl){
        getFront()
        getBack()
        sender.endRefreshing()
    }
    
    @objc func animationCard(sender: UITapGestureRecognizer) {
        guard let a = sender.view else { return }
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
            if (self.card.mcLabel.alpha == 0){
                self.card.labelCardNum.alpha = 1
                self.card.labelCardName.alpha = 1
                self.card.mcLabel.alpha = 1
                self.card.labelPIN.alpha = 0
                self.card.labelCVV.alpha = 0
                self.card.labelDate.alpha = 1
            } else {
                self.card.labelCVV.alpha = 1
                self.card.labelPIN.alpha = 1
                self.card.mcLabel.alpha = 0
                self.card.labelCardName.alpha = 0
                self.card.labelCardNum.alpha = 0
                self.card.labelDate.alpha = 0
            }
            self.getFront()
            self.getBack()
        }
        UIView.animate(withDuration: 1, delay: 0.25, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.2, options: [], animations: {
            a.center.x = self.view.bounds.width - 100
        },completion: {_ in
            
            UIView.animate(withDuration: 1, delay: 0.25, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.2, options: [], animations: {
                a.center.x = self.view.center.x
            },completion: {_ in })})
    }
    
    func getBack(){
        let userId = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        db.collection("card").whereField("userId", isEqualTo: userId!).getDocuments  { snapshot, err in
            if err == nil && snapshot != nil{
                let docData = snapshot!.documents[0]
                let changeCardNum = docData["cardNum"].map(String.init(describing:))!.separate(every: 4, with: " ")
                self.card.labelCardNum.text = changeCardNum
                self.card.labelPIN.text = docData["PIN"].map(String.init(describing:))!
                self.card.labelCVV.text = "CVV: \(docData["CVV"].map(String.init(describing:))!)"
                self.card.labelDate.text = self.dateForm(str: docData["expiredDate"].map(String.init(describing:))!)
                self.sum.labelSum.text = docData["CVV"].map(String.init(describing:))!
                if(UserDefaults.standard.value(forKey: "alert") as? Bool != true){
                    self.ac = UIAlertController(title: "Твой PIN - код от приложения", message: "Твой код-пароль: \(docData["PIN"].map(String.init(describing:))!.separate(every: 4, with: " "))", preferredStyle: .alert)
                    self.ac.addAction(UIAlertAction(title: "Понял", style: .default, handler: nil))
                    self.present(self.ac, animated: true, completion: nil)
                    UserDefaults.standard.setValue(true, forKey: "alert")
                }
            }
        }
    }
    
    func dateForm(str: String) -> String{
        var r: String!
        let b = str.components(separatedBy: CharacterSet(charactersIn: "/"))
        if (b[0] > "24"){
            r = "0"+str
        } else {
            r = str
        }
        return r
    }
    
//    func getSum(){
//        let userId = Auth.auth().currentUser?.uid
//        let db = Firestore.firestore()
//        db.collection("card").whereField("userId", isEqualTo: userId!).getDocuments  { snapshot, err in
//            if err == nil && snapshot != nil{
//                let docData = snapshot!.documents[0]
//                db.collection("account").whereField("cardId", isEqualTo: docData["cardNum"].map(String.init(describing:))!).getDocuments  { snapshot, err in
//                    if err == nil && snapshot != nil{
//                        let docData = snapshot!.documents[0]
//                        self.sum.labelSum.text = docData["sum"].map(String.init(describing:))!
//                    }
//                }
//            }
//        }
//    }
}
