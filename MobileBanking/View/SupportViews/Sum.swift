//
//  Sum.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 20.11.2021.
//

import Foundation
import UIKit

class SumView{
    var sum: UIView!
    var labelSum: UILabel!
    
    
    init(view: UIView, extraView: UIView?){
        sum = {
            let sum = UIView()
            sum.backgroundColor = .tertiarySystemBackground
            sum.layer.cornerRadius = 15
            view.addSubview(sum)
            sum.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.top.equalTo(extraView!.snp.bottom).offset(15)
                maker.width.equalToSuperview().dividedBy(1.1)
                maker.height.equalToSuperview().dividedBy(6)
            }
            return sum
        }()
        
        labelSum = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.font(25, .contemp)
            label.textColor = .label
            label.alpha = 0
            sum.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.centerY.equalToSuperview()
                maker.width.equalToSuperview().dividedBy(1.25)
                maker.height.equalTo(25)
            }
            return label
        }()
    }

}
