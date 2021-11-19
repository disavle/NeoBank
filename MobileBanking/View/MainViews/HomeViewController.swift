//
//  MainViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 12.08.2021.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDataSource {

    var labelName: UILabel!
    var labelCardNum: UILabel!
    var labelCVV: UILabel!
    var labelPIN: UILabel!
    var tableView: UITableView!
    //MARK: Pull to update
    let refControl: UIRefreshControl! = {
        let ref = UIRefreshControl()
        ref.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return ref
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

        DispatchQueue.main.async {
            self.getData()
        }
        
        labelPIN = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.font(35, .main)
            label.textColor = .label
            
            tableView.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.centerY.equalToSuperview()
                maker.width.equalToSuperview().dividedBy(2)
                maker.height.equalTo(50)
            }
            return label
        }()
    }
    
    func getData(){
        guard let id = Auth.auth().currentUser?.uid else {return}
        DB.shared.get(col: "users", docName: id) { doc in
            self.labelPIN.text = doc!.PIN
            let changeCardNum = doc!.cardNum?.separate(every: 4, with: " ")
            CardView.card(view: self.tableView, cardNum: changeCardNum, cardName: doc!.name)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "d", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    @objc private func refresh(_ sender: UIRefreshControl){
        getData()
        sender.endRefreshing()
    }
}
