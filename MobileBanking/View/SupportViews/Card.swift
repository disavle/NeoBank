//
//  Card.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 20.11.2021.
//

import Foundation
import UIKit

class Card{
    var labelCardNum: UILabel!
    var labelCardName: UILabel!
    var labelPIN: UILabel!
    var labelCVV: UILabel!
    var labelDate: UILabel!
    var mcLabel: UIImageView!
    var form: UIView!
    init(_ view: UIView){
        form = {
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
        
        mcLabel = {
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
        
        labelCardNum = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.font(13, .contemp)
            label.textColor = .label
            form.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.centerY.equalToSuperview().offset(30)
                maker.width.equalToSuperview().dividedBy(1.1)
                maker.height.equalTo(20)
            }
            return label
        }()
        
        labelCardName = {
            let label = UILabel()
            label.textAlignment = .left
            label.font = UIFont.font(25, .logo)
            label.textColor = .label
            form.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.left.equalToSuperview().offset(40)
                maker.top.equalToSuperview().offset(30)
                maker.width.equalToSuperview().dividedBy(1.25)
                maker.height.equalTo(25)
            }
            return label
        }()
        
        labelPIN = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.font(25, .contemp)
            label.textColor = .label
            label.alpha = 0
            form.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.centerY.equalToSuperview()
                maker.width.equalToSuperview().dividedBy(1.25)
                maker.height.equalTo(25)
            }
            return label
        }()
        
        labelCVV = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.font(13, .contemp)
            label.textColor = .label
            label.alpha = 0
            form.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.centerY.equalToSuperview().offset(30)
                maker.width.equalToSuperview().dividedBy(1.1)
                maker.height.equalTo(20)
            }
            return label
        }()
        
        labelDate = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.font(9, .contemp)
            label.textColor = .label
            label.alpha = 1
            form.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.left.equalToSuperview().offset(35)
                maker.centerY.equalTo(mcLabel.snp.centerY)
                maker.width.equalToSuperview().dividedBy(4)
                maker.height.equalTo(20)
            }
            return label
        }()
    }
}
