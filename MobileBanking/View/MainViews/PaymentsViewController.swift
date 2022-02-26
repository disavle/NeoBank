//
//  PaymentsViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 12.08.2021.
//

import UIKit

class PaymentsViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var gallery: UICollectionView!
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
        
        CurrencyRate.getCurrencyList { currencies, er in
            self.currency = currencies!
            
            self.gallery = {
                let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .vertical
                let gal = UICollectionView(frame: .zero, collectionViewLayout: layout)
                gal.register(GalleryItem.self, forCellWithReuseIdentifier: GalleryItem.cell)
                gal.dataSource = self
                gal.delegate = self
                gal.backgroundColor = .clear
                gal.contentInsetAdjustmentBehavior = .always
                gal.refreshControl = self.refControl
                gal.contentInset = UIEdgeInsets(top: 0, left: self.view.frame.width/(self.view.frame.width/10), bottom: 0, right: self.view.frame.width/(self.view.frame.width/10))
                self.view = gal
                gal.reloadData()
                return gal
            }()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currency.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryItem.cell, for: indexPath) as! GalleryItem
        cell.title.text = currency[indexPath.row].title
        cell.price.text = "\(Double(round(100 * (1/currency[indexPath.row].price!)) / 100).description)₽"
        return cell
    }
    
    //MARK: Just gag
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.2, height: collectionView.frame.height/10)
    }
    
    @objc private func refresh(_ sender: UIRefreshControl){
        CurrencyRate.getCurrencyList { currencies, er in
            self.currency = currencies!
            self.gallery.reloadData()
            sender.endRefreshing()
        }
        
    }
}
