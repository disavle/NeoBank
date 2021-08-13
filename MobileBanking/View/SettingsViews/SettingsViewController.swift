//
//  SettingsViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 13.08.2021.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Settings"
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor:  UIColor.label, .font: UIFont(name: "Kepler-296", size: 35)!]
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(close))
        
        tableView = {
            let tableView = UITableView()
            view.addSubview(tableView)
            tableView.snp.makeConstraints(){maker in
                maker.centerX.equalToSuperview()
                maker.bottom.equalToSuperview()
                maker.width.equalToSuperview()
                maker.height.equalToSuperview()
            }
            return tableView
        }()
        
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.id)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    @objc func close(){
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.id, for: indexPath) as! SettingsTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
