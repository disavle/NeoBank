//
//  ProfileViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 12.08.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonSettings = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .done, target: self, action: #selector(openSettings))
        buttonSettings.tintColor = .secondaryLabel
        navigationItem.rightBarButtonItem = buttonSettings

        view.backgroundColor = .systemBackground
        label = {
            let label = UILabel()
            label.text = "Profile"
            label.textAlignment = .center
            label.font = UIFont(name: "Kepler-296", size: 35)
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
    }
    
    @objc func openSettings(){
        TapticManager.shared.vibrateSoft()
        let vc = SettingsViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
}
