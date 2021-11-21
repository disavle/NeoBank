//
//  MainViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 12.08.2021.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDataSource {
    
    static let shared = HomeViewController()
    
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
        
        card = Card(tableView)
        sum = SumView(view: tableView, extraView: card.form)
        pay = PaymentView(frame: .zero, style: .plain)
        HomeViewController.shared.pay = pay
        
        tableView.addSubview(pay)
        pay.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(sum.sum.snp.bottom).offset(5)
            maker.width.equalTo(sum.sum.snp.width)
            maker.height.equalToSuperview().dividedBy(2.23)
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "d")
        tableView.refreshControl = refControl
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        tableView.dataSource = self
        
        DispatchQueue.main.async {
            self.card.getBack(self)
            self.card.getFront()
            self.sum.getSum()
            self.pay.get()
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
        pay.get()
        sender.endRefreshing()
    }
}
