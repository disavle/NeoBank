//
//  FilterViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 04.03.2022.
//

import UIKit
import Firebase

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    private var tableView: UITableView!
    private var count = 0
    private var pays = [QueryDocumentSnapshot]()
    private var filtersView: UIStackView!
    private var scrollView: UIScrollView!
    private var indecator: UIActivityIndicatorView!
    private var filtersArray = [String]()
    
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
            
            self.scrollView = {
                let v = UIScrollView()
                v.delegate = self
                v.sizeToFit()
                v.showsHorizontalScrollIndicator = false
                v.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                self.view.addSubview(v)
                v.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                    make.width.equalToSuperview()
                    make.height.equalToSuperview().dividedBy(10)
                }
                return v
            }()
            
            self.filtersView = {
                let v = UIStackView()
                v.sizeToFit()
                v.alignment = .center
                v.spacing = 10
                v.axis = .horizontal
                v.distribution = .fill
                self.scrollView.addSubview(v)
                v.snp.makeConstraints { make in
                    make.edges.equalTo(self.scrollView)
                    make.height.equalToSuperview()
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
            
            let setSorted = set.sorted()
            
            for button in setSorted{
                let _: UIButton = {
                    let lab = UIButton()
                    lab.setTitle(button, for: .normal)
                    lab.addTarget(self, action: #selector(self.filter), for: .touchUpInside)
                    lab.setTitleColor(.systemPink, for: .normal)
                    lab.titleLabel?.font = UIFont.font(15, UIFont.FontType.main)
                    lab.tintColor = .label
                    lab.layer.cornerRadius = 5
                    lab.layer.masksToBounds = true
                    lab.contentHorizontalAlignment = .center
                    lab.contentVerticalAlignment = .center
                    lab.backgroundColor = .quaternaryLabel
                    lab.sizeToFit()
                    lab.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                    self.filtersView.addArrangedSubview(lab)
                    lab.snp.makeConstraints { snap in
                        snap.height.equalToSuperview().dividedBy(2.7)
                    }
                    return lab
                }()
            }
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
        indecator.startAnimating()
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            filtersArray.append(sender.titleLabel!.text!)
        } else {
            filtersArray = filtersArray.filter({ i in
                i != sender.titleLabel!.text!
            })
        }
        if !sender.isSelected{
            sender.backgroundColor = .quaternaryLabel
        } else {
            sender.backgroundColor = .secondaryLabel
        }
        if filtersArray == []{
            Filter.getCategories(filt: nil) { set,ar  in
                self.count = ar.count
                self.pays = ar
                self.indecator.stopAnimating()
                self.tableView.reloadData()
            }
        } else {
            Filter.getCategories(filt: filtersArray) { set,ar  in
                self.count = ar.count
                self.pays = ar
                self.indecator.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
}
