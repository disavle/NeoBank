//
//  MarketViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 27.02.2022.
//

import UIKit

class MarketViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var gallery: UICollectionView!
    private var currencyView: UIView!
    private var marketButton: UIButton!
    private var USDLabel: UILabel!
    private var USDLabelPrice: UILabel!
    private var EURLabel: UILabel!
    private var EURLabelPrice: UILabel!
    private var currency: [CurrencyRateModel]!
    private let refControl: UIRefreshControl! = {
        let ref = UIRefreshControl()
        ref.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return ref
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = .systemBackground
        
        currencyView = {
            let vie = UIView()
            vie.backgroundColor = .systemPink
            vie.layer.cornerRadius = 15
            view.addSubview(vie)
            vie.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                make.width.equalTo(view.frame.width - (view.frame.width/(view.frame.width/10)))
                make.height.equalToSuperview().dividedBy(6)
            }
            return vie
        }()
        
        USDLabel = {
            let lab = UILabel()
            lab.textAlignment = .center
            lab.font = UIFont.font(15, UIFont.FontType.contemp)
            lab.tintColor = .label
            lab.layer.cornerRadius = 15
            lab.layer.masksToBounds = true
            lab.sizeToFit()
            lab.textAlignment = .center
            currencyView.addSubview(lab)
            lab.snp.makeConstraints { snap in
                snap.centerX.equalToSuperview().offset(-70)
                snap.centerY.equalToSuperview().offset(-10)
                snap.width.equalToSuperview().dividedBy(1.2)
            }
            return lab
        }()
        
        USDLabelPrice = {
            let lab = UILabel()
            lab.textAlignment = .center
            lab.font = UIFont.font(20, UIFont.FontType.main)
            lab.tintColor = .label
            lab.layer.cornerRadius = 15
            lab.layer.masksToBounds = true
            lab.sizeToFit()
            lab.textAlignment = .center
            currencyView.addSubview(lab)
            lab.snp.makeConstraints { snap in
                snap.centerX.equalToSuperview().offset(-70)
                snap.top.equalTo(self.USDLabel.snp.bottom).offset(15)
                snap.width.equalToSuperview().dividedBy(1.2)
            }
            return lab
        }()
        
        EURLabel = {
            let lab = UILabel()
            lab.textAlignment = .center
            lab.font = UIFont.font(15, UIFont.FontType.contemp)
            lab.tintColor = .label
            lab.layer.cornerRadius = 15
            lab.layer.masksToBounds = true
            lab.sizeToFit()
            lab.textAlignment = .center
            currencyView.addSubview(lab)
            lab.snp.makeConstraints { snap in
                snap.centerX.equalToSuperview().offset(70)
                snap.centerY.equalToSuperview().offset(-10)
                snap.width.equalToSuperview().dividedBy(1.2)
            }
            return lab
        }()
        
        EURLabelPrice = {
            let lab = UILabel()
            lab.textAlignment = .center
            lab.font = UIFont.font(20, UIFont.FontType.main)
            lab.tintColor = .label
            lab.layer.cornerRadius = 15
            lab.layer.masksToBounds = true
            lab.sizeToFit()
            lab.textAlignment = .center
            currencyView.addSubview(lab)
            lab.snp.makeConstraints { snap in
                snap.centerX.equalToSuperview().offset(70)
                snap.top.equalTo(self.USDLabel.snp.bottom).offset(15)
                snap.width.equalToSuperview().dividedBy(1.2)
            }
            return lab
        }()
        
        marketButton = {
            let vie = UIButton()
            vie.backgroundColor = .systemPink
            vie.layer.cornerRadius = 15
            vie.layer.masksToBounds = true
            vie.setTitle("Назад", for: .normal)
            vie.titleLabel?.font = UIFont.font(17, .main)
            vie.addTarget(self, action: #selector(back), for: .touchUpInside)
            vie.setTitleColor(.label, for: .normal)
            view.addSubview(vie)
            vie.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(view.snp.bottom).offset(-70)
                make.width.equalToSuperview().dividedBy(3.5)
                make.height.equalToSuperview().dividedBy(14)
            }
            return vie
        }()
        
        CurrencyRate.getCurrencyList { currencies, er in
            
            self.currency = currencies!
            
            self.currency.sort(by: { key1, key2 in
                key1.title < key2.title

            })
            
            self.gallery = {
                let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .vertical
                let gal = UICollectionView(frame: .zero, collectionViewLayout: layout)
                gal.register(GalleryItem.self, forCellWithReuseIdentifier: GalleryItem.cell)
                gal.dataSource = self
                gal.delegate = self
                gal.backgroundColor = .clear
                gal.contentInsetAdjustmentBehavior = .always
                gal.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
                gal.refreshControl = self.refControl
                self.view.insertSubview(gal, belowSubview: self.marketButton)
                gal.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.top.equalTo(self.currencyView.snp.bottom)
                    make.width.equalToSuperview()
                    make.height.equalToSuperview().dividedBy(1.3)
                }
                return gal
            }()
            for i in currencies!{
                if (i.title == "USD"){
                    self.USDLabel.text = i.title
                    self.USDLabelPrice.text = "\(i.price!)₽"
                }
                if (i.title == "EUR"){
                    self.EURLabel.text = i.title
                    self.EURLabelPrice.text = "\(i.price!)₽"
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currency.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryItem.cell, for: indexPath) as! GalleryItem
        cell.title.text = currency[indexPath.row].title
        cell.price.text = "\(currency[indexPath.row].price!)₽"
        return cell
    }
    
    //MARK: Just gag
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.1, height: collectionView.frame.height/10)
    }
    
    @objc private func refresh(_ sender: UIRefreshControl){
        CurrencyRate.getCurrencyList { currencies, er in
            self.currency = currencies!
            self.currency.sort(by: { key1, key2 in
                key1.title < key2.title

            })
            self.gallery.reloadData()
            for i in currencies!{
                if (i.title == "USD"){
                    self.USDLabel.text = i.title
                    self.USDLabelPrice.text = "\(i.price!)"
                }
                if (i.title == "EUR"){
                    self.EURLabel.text = i.title
                    self.EURLabelPrice.text = "\(i.price!)"
                }
            }
            sender.endRefreshing()
        }
    }
    
    @objc func back(){
        navigationController?.popViewController(animated: true)
    }
}

