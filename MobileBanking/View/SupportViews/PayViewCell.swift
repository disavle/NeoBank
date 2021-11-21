//
//  PayViewCell.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 21.11.2021.
//

import UIKit
import Firebase

class PayViewCell: UITableViewCell {

    static let id = "pay"
    var labelName: UILabel!
    var labelSum: UILabel!
    var labelDate: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .secondarySystemBackground
        
        labelName = {
            let label = UILabel()
            label.textAlignment = .left
            label.font = UIFont.font(17, .main)
            label.textColor = .label
            addSubview(label)
            label.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.left.equalToSuperview().inset(20)
                maker.width.equalToSuperview().dividedBy(2)
                maker.height.equalToSuperview()
            }
            return label
        }()
        
        labelDate = {
            let label = UILabel()
            label.textAlignment = .left
            label.font = UIFont.font(8, .contemp)
            label.textColor = .label
            addSubview(label)
            label.snp.makeConstraints { maker in
                maker.bottom.equalToSuperview()
                maker.left.equalToSuperview().inset(20)
                maker.width.equalToSuperview().dividedBy(2)
                maker.height.equalToSuperview().dividedBy(2).inset(7)
            }
            return label
        }()
        
        labelSum = {
            let label = UILabel()
            label.textAlignment = .right
            label.font = UIFont.font(20, .contemp)
            label.textColor = .label
            addSubview(label)
            label.snp.makeConstraints { maker in
                maker.top.equalToSuperview()
                maker.right.equalToSuperview().inset(20)
                maker.width.equalToSuperview().dividedBy(2.2)
                maker.height.equalToSuperview()
            }
            return label
        }()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
