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
        tableView = {
            let tableView = UITableView()
            tableView.backgroundColor = .cyan
            tableView.isScrollEnabled = true
            view.addSubview(tableView)
            tableView.snp.makeConstraints(){maker in
                maker.centerX.equalToSuperview()
                maker.top.equalTo(extraView!.snp.bottom).inset(20)
                maker.width.equalTo(extraView!.snp.width)
                maker.height.equalTo(extraView!.snp.height)
            }
            return tableView
        }()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "d", for: indexPath)
        return cell
    }
}
