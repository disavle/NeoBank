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
    //MARK: Support views
    var card: Card!
    var sum: SumView!
    var pay: PaymentView!
    
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
        
        card = Card(tableView)
        sum = SumView(view: tableView, extraView: card.form)
        pay = PaymentView(view: tableView, extraView: sum.sum)
        
        DispatchQueue.main.async {
            self.card.getBack(self)
            self.card.getFront()
            self.sum.getSum()
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
        card.getBack(nil)
        card.getFront()
        sum.getSum()
        sender.endRefreshing()
    }
}
