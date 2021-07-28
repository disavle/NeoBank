//
//  ViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 28.07.2021.
//
import SnapKit
import UIKit

class ViewController: UIViewController {
    
    var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        
        label = {
            let label = UILabel()
            label.text = "DarkMoon"
            label.textAlignment = .center
            label.font = UIFont(name: "Kepler-296", size: 35)
            label.textColor = .label
            label.alpha = 0
            UIView.animate(withDuration: 2) {
                label.alpha = 1
            }
            view.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.centerY.equalToSuperview()
                maker.width.equalToSuperview().dividedBy(2)
                maker.height.equalTo(50)
            }
            return label
        }()
    }
}

