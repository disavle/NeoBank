//
//  SettingsViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 13.08.2021.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Настройки"
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor:  UIColor.label, .font: UIFont.font(35, .main)]
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
        tableView.register(SignOutTableViewCell.self, forCellReuseIdentifier: SignOutTableViewCell.id)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func close(){
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.id, for: indexPath) as! SettingsTableViewCell
            cell.selectionStyle = .none
            cell.label.text = "Космический режим 🚀"
            checkStyle(sender: cell.toggle)
            cell.toggle.addTarget(self, action: #selector(mode), for: .primaryActionTriggered)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: SignOutTableViewCell.id, for: indexPath) as! SignOutTableViewCell
        cell.signOut.setTitle("Выйти", for: .normal)
        cell.signOut.tag = indexPath.row
        cell.signOut.addTarget(self, action: #selector(SignOut), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    @objc func mode(sender: UISwitch){
        //MARK: Dark mode switcher
        Utils.darkMode(sender: sender)
        UserDefaults.standard.setValue(sender.isOn, forKey: "style")
    }
    
    //MARK: Check dark mode style
    func checkStyle(sender: UISwitch){
        if (self.traitCollection.userInterfaceStyle == .dark){
            sender.isOn = true
        } else {
            sender.isOn = false
        }
    }
    
    @objc func SignOut(){
        do{
            try Auth.auth().signOut()
            LogIn().goToSignIn(self.view)
        }   catch{
            print(error)
        }
    }
}
