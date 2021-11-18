//
//  SignOutTableViewCell.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 18.11.2021.
//

import UIKit

class SignOutTableViewCell: UITableViewCell {

    static let id = "row"
    
    let signOut: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.font(15, .main)
        button.setTitleColor(.systemRed, for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(signOut)
        signOut.snp.makeConstraints(){maker in
            maker.centerY.equalToSuperview()
            maker.centerX.equalToSuperview()
            maker.width.equalTo(100)
            maker.height.equalTo(100)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
