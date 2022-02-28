//
//  PaymentsViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 12.08.2021.
//

import UIKit
import Alamofire

class PaymentsViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var backButton: UIButton!
    private var companiesGet: [Company?]!
    private var gallery: UICollectionView!
    private var companies = [String]()
    private let refControl: UIRefreshControl! = {
        let ref = UIRefreshControl()
        ref.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return ref
    }()
    private var alert: UIAlertController!
    private var indecator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemBackground
        
        indecator = {
            let ind = UIActivityIndicatorView()
            ind.style = .large
            ind.center = view.center
            view.addSubview(ind)
            ind.startAnimating()
            return ind
        }()
        
        backButton = {
            let vie = UIButton()
            vie.backgroundColor = .systemPink
            vie.layer.cornerRadius = 15
            vie.layer.masksToBounds = true
            vie.setTitle("Валюта", for: .normal)
            vie.titleLabel?.font = UIFont.font(17, .main)
            vie.addTarget(self, action: #selector(toMarket), for: .touchUpInside)
            vie.setTitleColor(.label, for: .normal)
            view.addSubview(vie)
            vie.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(view.snp.bottom).offset(-70)
                make.width.equalToSuperview().dividedBy(1.1)
                make.height.equalToSuperview().dividedBy(14)
            }
            return vie
        }()
        
        CompanyInfo.getCompanies { k in
            self.companies = k
            CompanyInfo.getMarkets(tickers: self.companies) { com,er  in
                
                guard er == nil else {
                    self.alertAction(er!)
                    return
                }
                
                self.companiesGet = com!
                
                self.companiesGet!.sort { k, v in
                    k!.title! < v!.title!
                }
                self.gallery.reloadData()
                self.indecator.stopAnimating()
            }
            self.gallery = {
                let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .vertical
                let gal = UICollectionView(frame: .zero, collectionViewLayout: layout)
                gal.register(GalleryMarketItem.self, forCellWithReuseIdentifier: GalleryMarketItem.cell)
                gal.dataSource = self
                gal.delegate = self
                gal.layer.masksToBounds = true
                gal.layer.cornerRadius = 15
                gal.backgroundColor = .tertiarySystemBackground
                gal.contentInsetAdjustmentBehavior = .always
                gal.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
                gal.refreshControl = self.refControl
                self.view.insertSubview(gal, belowSubview: self.indecator)
                gal.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                    make.width.equalToSuperview().dividedBy(1.1)
                    make.height.equalToSuperview().dividedBy(1.22)
                }
                return gal
            }()
        }
    }
    
    @objc func toMarket(){
        navigationController?.pushViewController(MarketViewController(), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        companies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryMarketItem.cell, for: indexPath) as! GalleryMarketItem
        if let com = companiesGet{
            if com.count == companies.count{
                cell.img.image =  com[indexPath.row]?.img ?? UIImage()
                cell.img.contentMode = .scaleAspectFit
                cell.title.text = com[indexPath.row]?.title ?? ""
                cell.tocker.text = com[indexPath.row]?.ticker ?? ""
                cell.price.text = "\(com[indexPath.row]?.price ?? 0.0)"
                if((com[indexPath.row]?.priceChange)! > 0.0){
                    cell.priceChange.textColor = .systemGreen
                }
                else if ((com[indexPath.row]?.priceChange)! < 0.0){
                    cell.priceChange.textColor = .systemRed
                }
                cell.priceChange.text = "\(com[indexPath.row]?.priceChange ?? 0.0)"
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/1.13, height: collectionView.frame.height/4)
    }
    
    @objc private func refresh(_ sender: UIRefreshControl){
        CompanyInfo.getCompanies { k in
            self.companies = k
            CompanyInfo.getMarkets(tickers: self.companies) { com,er  in
                guard er == nil else {
                    self.alertAction(er!)
                    return
                }
                self.companiesGet = com!
                
                self.companiesGet.sort { k, v in
                    k!.title! < v!.title!
                }
            }
            self.gallery.reloadData()
            sender.endRefreshing()
        }
    }
    
    func alertAction(_ er: AFError){
        alert = UIAlertController(title: er.responseCode?.description, message: er.errorDescription!, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .destructive, handler: nil))
        indecator.stopAnimating()
        present(self.alert, animated: true)
    }
}
