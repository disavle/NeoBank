//
//  Payments.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 20.11.2021.
//

import Foundation
import UIKit

class PaymentView{
    
    var tableView: UITableView!
   
    
    init(view: UIView, extraView: UIView?){
        
        let refControl: UIRefreshControl! = {
            let ref = UIRefreshControl()
            ref.addTarget(self, action: #selector(refresh), for: .valueChanged)
            return ref
        }()
        tableView = {
            let tableView = UITableView()
            tableView.backgroundColor = .secondarySystemBackground
            tableView.isScrollEnabled = true
            tableView.refreshControl = refControl
            tableView.layer.cornerRadius = 15
            view.addSubview(tableView)
            tableView.snp.makeConstraints(){maker in
                maker.centerX.equalToSuperview()
                maker.top.equalTo(extraView!.snp.bottom).offset(10)
                maker.width.equalTo(extraView!.snp.width)
                maker.height.equalToSuperview().dividedBy(2)
            }
            return tableView
        }()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "d", for: indexPath)
        return cell
    }
    
    @objc private func refresh(_ sender: UIRefreshControl){
        
        sender.endRefreshing()
    }
}
