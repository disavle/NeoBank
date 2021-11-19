//
//  ProfileViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 12.08.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    var labelTitle: UILabel!
    //MARK: Delete after realization
    var labelSoon: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonSettings = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .done, target: self, action: #selector(openSettings))
        buttonSettings.tintColor = .secondaryLabel
        navigationItem.rightBarButtonItem = buttonSettings

        view.backgroundColor = .systemBackground
        labelTitle = {
            let label = UILabel()
            label.text = "Профиль"
            label.textAlignment = .center
            label.font = UIFont.font(35, .main)
            label.textColor = .label
            
            view.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.centerY.equalToSuperview()
                maker.width.equalToSuperview().dividedBy(2)
                maker.height.equalTo(50)
            }
            return label
        }()
        
        labelSoon = {
            let label = UILabel()
            label.text = "Soon..."
            label.textAlignment = .center
            label.font = UIFont.font(30, .contemp)
            label.textColor = .systemOrange
            Utils.animateSoon(label, view)
            view.addSubview(label)
            label.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.top.equalTo(labelTitle.snp.bottom).inset(10)
                maker.width.equalToSuperview().dividedBy(2)
                maker.height.equalTo(50)
            }
            return label
        }()
    }
    
    @objc func openSettings(){
        TapticManager.shared.vibrateSoft()
        let vc = SettingsViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
}
