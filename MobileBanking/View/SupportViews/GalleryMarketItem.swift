//
//  GalleryMarketItem.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 27.02.2022.
//

import UIKit

class GalleryMarketItem: UICollectionViewCell{
    static let cell = "cell"
    
    var img: UIImageView!
    var title: UILabel!
    var tocker: UILabel!
    var price: UILabel!
    var priceChange: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 15
        backgroundColor = .secondarySystemBackground
        
        self.img = {
            let lab = UIImageView()
            lab.backgroundColor = .white
            lab.layer.cornerRadius = 15
            lab.layer.masksToBounds = true
            self.addSubview(lab)
            lab.snp.makeConstraints { snap in
                snap.right.equalToSuperview().offset(-30)
                snap.centerY.equalToSuperview()
                snap.width.equalToSuperview().dividedBy(3.5)
                snap.height.equalTo(self.frame.width/3.5)
            }
            return lab
        }()
        
        self.title = {
            let lab = UILabel()
            lab.textAlignment = .left
            lab.font = UIFont.font(17, UIFont.FontType.main)
            tintColor = .label
            lab.numberOfLines = 2
            lab.sizeToFit()
            self.addSubview(lab)
            lab.snp.makeConstraints { snap in
                snap.left.equalToSuperview().offset(30)
                snap.top.equalToSuperview().offset(20)
                snap.width.equalToSuperview().dividedBy(2)
            }
            return lab
        }()
        
        self.tocker = {
            let lab = UILabel()
            lab.textAlignment = .left
            lab.font = UIFont.font(17, UIFont.FontType.logo)
            tintColor = .label
            lab.sizeToFit()
            self.addSubview(lab)
            lab.snp.makeConstraints { snap in
                snap.left.equalToSuperview().offset(30)
                snap.top.equalTo(self.title.snp.bottom).offset(3)
                snap.width.equalToSuperview().dividedBy(2)
            }
            return lab
        }()
        
        self.price = {
            let lab = UILabel()
            lab.textAlignment = .left
            lab.font = UIFont.font(17, UIFont.FontType.main)
            tintColor = .label
            lab.sizeToFit()
            self.addSubview(lab)
            lab.snp.makeConstraints { snap in
                snap.left.equalToSuperview().offset(30)
                snap.top.equalTo(self.tocker.snp.bottom).offset(3)
                snap.width.equalToSuperview().dividedBy(2)
            }
            return lab
        }()
        
        self.priceChange = {
            let lab = UILabel()
            lab.textAlignment = .left
            lab.font = UIFont.font(17, UIFont.FontType.main)
            tintColor = .label
            lab.sizeToFit()
            self.addSubview(lab)
            lab.snp.makeConstraints { snap in
                snap.left.equalToSuperview().offset(30)
                snap.top.equalTo(self.price.snp.bottom).offset(3)
                snap.width.equalToSuperview().dividedBy(2)
            }
            return lab
        }()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
