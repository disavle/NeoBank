//
//  MainViewCell.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 20.11.2021.
//

import UIKit

class MainViewCell: UITableViewCell {

    static let id = "main"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        var card = Card(contentView)
        SumView(view: contentView, extraView: card.form)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

