//
//  ButtonsView.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 14.08.2021.
//

import UIKit
import SnapKit

class ButtonsView: UIView {
    
    var label: UILabel!
    var button: UIView!
    var value: Int?
    var name: String?
    var img: UIImage?
    var image: UIImageView!
    
    init(value: Int?, name: String?, img: UIImage?) {
        super.init(frame: .zero)
        self.value = value
        self.name = name
        self.img = img
        
        button = {
            let button = UIView()
            button.backgroundColor = .tertiarySystemBackground
            button.layer.cornerRadius = 14
            addSubview(button)
            button.snp.makeConstraints { maker in
                maker.edges.equalToSuperview()
            }
            return button
        }()
        
        if (value != nil){
            label = {
                let label = UILabel()
                label.textAlignment = .center
                label.font = UIFont(name: "Kepler-296", size: 35)
                label.text = name
                label.textColor = .secondaryLabel
                button.addSubview(label)
                label.snp.makeConstraints { maker in
                    maker.centerX.equalToSuperview()
                    maker.centerY.equalToSuperview()
                    maker.width.equalToSuperview().inset(3)
                    maker.height.equalToSuperview().inset(3)
                }
                return label
            }()
        } else {
            image = {
                let image = UIImageView(image: img)
                image.tintColor = .tertiaryLabel
                button.addSubview(image)
                image.snp.makeConstraints { maker in
                    maker.centerX.equalToSuperview()
                    maker.centerY.equalToSuperview()
                    maker.width.equalToSuperview().dividedBy(3.5)
                    maker.height.equalTo(image.snp.width)
                }
                return image
            }()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
