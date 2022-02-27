//
//  GallaryItem.swift
//  TelePort
//
//  Created by Dima Savelyev on 11.02.2022.
//

import UIKit

class GalleryItem: UICollectionViewCell{
    static let cell = "cell"
    
    var title: UILabel!
    var price: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 15
        backgroundColor = .secondarySystemBackground
        
        self.title = {
            let lab = UILabel()
            lab.textAlignment = .center
            lab.font = UIFont.font(15, UIFont.FontType.contemp)
            tintColor = .label
            layer.cornerRadius = 15
            layer.masksToBounds = true
            lab.numberOfLines = 3
            lab.sizeToFit()
            lab.textAlignment = .center
            self.addSubview(lab)
            lab.snp.makeConstraints { snap in
                snap.centerX.equalToSuperview()
                snap.centerY.equalToSuperview().offset(-10)
                snap.width.equalToSuperview().dividedBy(1.2)
            }
            return lab
        }()
        
        self.price = {
            let lab = UILabel()
            lab.textAlignment = .center
            lab.font = UIFont.font(20, UIFont.FontType.main)
            tintColor = .label
            layer.cornerRadius = 15
            layer.masksToBounds = true
            lab.numberOfLines = 3
            lab.textAlignment = .center
            lab.sizeToFit()
            self.addSubview(lab)
            lab.snp.makeConstraints { snap in
                snap.centerX.equalToSuperview()
                snap.top.equalTo(self.title.snp.bottom).offset(5)
                snap.width.equalToSuperview().dividedBy(1.2)
            }
            return lab
        }()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

