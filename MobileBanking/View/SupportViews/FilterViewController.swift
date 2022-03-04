//
//  FilterViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 04.03.2022.
//

import UIKit
import Firebase

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var tableView: UITableView!
    private var count = 0
    private var pays = [QueryDocumentSnapshot]()
    private var filtersView: UIView!
    private var indecator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeView))
        view.backgroundColor = .tertiarySystemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Анализ"
        
        indecator = {
            let ind = UIActivityIndicatorView()
            ind.style = .large
            view.addSubview(ind)
            ind.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            ind.startAnimating()
            return ind
        }()
        
        Filter.getCategories(filt: nil) { set,ar  in
            
            self.filtersView = {
                let v = UIView()
                v.sizeToFit()
                self.view.addSubview(v)
                v.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                    make.width.equalToSuperview()
//                    make.height.equalTo(200)
                }
                return v
            }()
            
            self.tableView = {
                let tab = UITableView()
                tab.isScrollEnabled = true
                tab.tableFooterView = UIView()
                tab.register(PayViewCell.self, forCellReuseIdentifier: PayViewCell.id)
                tab.rowHeight = 70
                tab.delegate = self
                tab.dataSource = self
                tab.sizeToFit()
                self.view.insertSubview(tab, belowSubview: self.indecator)
                tab.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.top.equalTo(self.filtersView.snp.bottom)
                    make.width.equalToSuperview()
                    make.bottom.equalToSuperview()
                }
                return tab
            }()
            
            self.count = ar.count
            self.pays = ar
            
//            for button in set{
                let but: UIButton = {
                    let lab = UIButton()
                    lab.setTitle(set[0], for: .normal)
                    lab.addTarget(self, action: #selector(self.filter), for: .touchUpInside)
                    lab.setTitleColor(.systemPink, for: .normal)
                    lab.titleLabel?.font = UIFont.font(15, UIFont.FontType.main)
                    lab.tintColor = .label
                    lab.layer.cornerRadius = 15
                    lab.layer.masksToBounds = true
                    lab.backgroundColor = .quaternaryLabel
                    self.filtersView.addSubview(lab)
                    lab.snp.makeConstraints { snap in
                        snap.center.equalToSuperview()
                        snap.width.equalToSuperview().dividedBy(3)
                        snap.height.equalToSuperview().dividedBy(5)
                    }
                    return lab
                }()
            
            let but2: UIButton = {
                let lab = UIButton()
                lab.setTitle(set[1], for: .normal)
                lab.addTarget(self, action: #selector(self.filter), for: .touchUpInside)
                lab.setTitleColor(.systemPink, for: .normal)
                lab.titleLabel?.font = UIFont.font(15, UIFont.FontType.main)
                lab.tintColor = .label
                lab.layer.cornerRadius = 15
                lab.layer.masksToBounds = true
                lab.backgroundColor = .quaternaryLabel
                self.filtersView.addSubview(lab)
                lab.snp.makeConstraints { snap in
                    snap.center.equalTo(but.snp.center).offset(50)
                    snap.width.equalToSuperview().dividedBy(3)
                    snap.height.equalToSuperview().dividedBy(5)
                }
                return lab
            }()
                
                
//            }
            self.indecator.stopAnimating()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PayViewCell.id, for: indexPath) as! PayViewCell
        cell.selectionStyle = .none
        cell.labelName.text = (pays[indexPath.row].data()["name"] as! String)
        
        //MARK: Set the date format
        let date = pays[indexPath.row].data()["timeStamp"] as! Timestamp
        let time = date.dateValue()
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "HH:mm, d MM y"
        
        cell.labelDate.text = formatter1.string(from: time)
        let str = Utils.payForm(str: pays[indexPath.row].data()["sum"] as! String)
        let str2 = pays[indexPath.row].data()["currency"] as! String
        cell.labelSum.text = str+str2
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        count
    }
    
    @objc func closeView(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func filter(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        if !sender.isSelected{
            indecator.startAnimating()
            Filter.getCategories(filt: nil) { set,ar  in
                self.count = ar.count
                self.pays = ar
                self.indecator.stopAnimating()
                self.tableView.reloadData()
            }
            sender.backgroundColor = .quaternaryLabel
        } else {
            indecator.startAnimating()
            Filter.getCategories(filt: sender.title(for: .normal)) { set,ar  in
                self.count = ar.count
                self.pays = ar
                self.indecator.stopAnimating()
                self.tableView.reloadData()
            }
            sender.backgroundColor = .secondaryLabel
        }
    }
}
