//
//  CardView.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 19.11.2021.
//

import Foundation
import UIKit

class CardView{
    static func card(view: UIView, cardNum: String?, cardName: String?){
        var form: UIView = {
            let form = UIView()
            form.backgroundColor = .systemPink
            form.layer.cornerRadius = 15
            view.addSubview(form)
            form.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.top.equalToSuperview().inset(30)
                maker.width.equalToSuperview().dividedBy(1.25)
                maker.height.equalToSuperview().dividedBy(4)
            }
            return form
        }()
        
        var mcLabel: UIImageView = {
            let image = UIImage(named: "mc")
            let label = UIImageView(image: image)
            form.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.right.equalToSuperview().inset(20)
                maker.bottom.equalToSuperview().inset(10)
                maker.width.equalTo(62.94)
                maker.height.equalTo(44.71)
            }
            return label
        }()
        
        var labelCardNum: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.font(13, .contemp)
            label.textColor = .label
            label.text = cardNum
            form.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.centerY.equalToSuperview().offset(30)
                maker.width.equalToSuperview().dividedBy(1.1)
                maker.height.equalTo(20)
            }
            return label
        }()
        
        var labelCardName: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.font(25, .main)
            label.textColor = .label
            label.text = cardName
            form.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.left.equalToSuperview().offset(17)
                maker.top.equalToSuperview().offset(20)
                maker.width.equalToSuperview().dividedBy(3)
                maker.height.equalTo(25)
            }
            return label
        }()
    }
}
