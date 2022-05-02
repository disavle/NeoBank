//
//  MainViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 12.08.2021.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDataSource {
    
    static let shared = HomeViewController()
    
    var tableView: UITableView!
    //MARK: Pull to update
    let refControl: UIRefreshControl! = {
        let ref = UIRefreshControl()
        ref.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return ref
    }()
    //MARK: Support views
    var card: Card!
    var sum: SumView!
    var pay: PaymentView!
    var indecator: UIActivityIndicatorView!
    private var filter: UIButton!
    
    var flag = UserDefaults.standard.value(forKey: "fullCardNum") as? Bool ?? true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemBackground
        
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
        
        card = Card(tableView)
        sum = SumView(view: tableView, extraView: card.form)
        pay = PaymentView(frame: .zero, style: .plain)
        HomeViewController.shared.pay = pay
        
        tableView.addSubview(pay)
        pay.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(sum.sum.snp.bottom).offset(5)
            maker.width.equalTo(sum.sum.snp.width)
            maker.height.equalToSuperview().dividedBy(2.23)
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "d")
        tableView.refreshControl = refControl
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        tableView.dataSource = self
        
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
        
        card.getBack(self, flag)
        card.getFront()
        sum.getSum()
        pay.get {k in
            if k{
                self.indecator.stopAnimating()
            }
        }
        
        filter = {
            let lab = UIButton()
            lab.setTitle("Анализ", for: .normal)
            lab.addTarget(self, action: #selector(goToFilter), for: .touchUpInside)
            lab.setTitleColor(.systemPink, for: .normal)
            lab.titleLabel?.font = UIFont.font(17, UIFont.FontType.main)
            lab.tintColor = .systemPink
            lab.sizeToFit()
            lab.backgroundColor = .tertiarySystemBackground
            lab.layer.cornerRadius = 15
            lab.layer.masksToBounds = true
            pay.addSubview(lab)
            pay.contentInset = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
            lab.snp.makeConstraints { snap in
                snap.top.equalToSuperview().offset(-20)
                snap.centerX.equalToSuperview()
                snap.width.equalToSuperview().dividedBy(1.2)
            }
            return lab
        }()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "d", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    @objc private func refresh(_ sender: UIRefreshControl){
        card.getBack(nil,flag)
        card.getFront()
        sum.getSum()
        pay.get {k in
            if k{
                sender.endRefreshing()
            }
        }
        
    }
    
    @objc func goToFilter(){
        let vc = FilterViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
  
    // MARK: - Gesture shake for showing full numCard
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
        if motion == .motionShake {
            self.flag = !flag
            print("flagView = \(flag)")
            UserDefaults.standard.set(flag, forKey: "fullCardNum")
            card.getBack(nil,flag)
            TapticManager.shared.vibrateFeedback(for: .success)
        }
    }
}
