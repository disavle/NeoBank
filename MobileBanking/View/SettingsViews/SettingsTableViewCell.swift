//
//  SettingsTableViewCell.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 13.08.2021.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    static let id = "cell"
    
    let toggle: UISwitch = {
        let toggle = UISwitch()
        toggle.onTintColor = .systemPink
        toggle.isOn = false
        toggle.thumbTintColor = .label
        return toggle
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(toggle)
        toggle.snp.makeConstraints(){maker in
            maker.centerY.equalToSuperview()
            maker.right.equalToSuperview().inset(20)
            maker.width.equalTo(toggle.bounds.width)
            maker.height.equalTo(toggle.bounds.height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
