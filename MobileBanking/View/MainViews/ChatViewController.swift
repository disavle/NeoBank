//
//  ActivityViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 12.08.2021.
//

import UIKit

class ChatViewController: UIViewController {
    
    var labelTitle: UILabel!
    //MARK: Delete after realization
    var labelSoon: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = .systemBackground
        
        labelTitle = {
            let label = UILabel()
            label.text = "Чат"
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
        
        labelSoon = {
            let label = UILabel()
            label.text = "Soon..."
            label.textAlignment = .center
            label.font = UIFont.font(30, .contemp)
            label.textColor = .systemOrange
            Utils.animateSoon(label, view)
            view.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.top.equalTo(labelTitle.snp.bottom).inset(10)
                maker.width.equalToSuperview().dividedBy(2)
                maker.height.equalTo(50)
            }
            return label
        }()
    }
}
