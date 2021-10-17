//
//  MainViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 12.08.2021.
//

import UIKit
import FirebaseDatabase

class HomeViewController: UIViewController {
    
    var label: UILabel!
    
    let ref = Database.database().reference(withPath: "dfsdf")
    var refObservers: [DatabaseHandle] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true

        view.backgroundColor = .systemBackground
        label = {
            let label = UILabel()
            label.text = "Home"
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
        
        ref.observe(.value, with: { snapshot in
          print(snapshot.value!)
        })

    }
}
