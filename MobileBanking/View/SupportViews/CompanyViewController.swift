//
//  CompanyViewController.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 28.02.2022.
//

import UIKit
import Alamofire
import SafariServices

class CompanyViewController: UIViewController, UIScrollViewDelegate {
    
    private var image: UIImageView!
    private var ticker: String!
    private var name: UILabel!
    private var nameTitle: UILabel!
    private var tags: UILabel!
    private var tagsTitle: UILabel!
    private var website: UIButton!
    private var websiteTitle: UILabel!
    private var describ: UILabel!
    private var describTitle: UILabel!
    private var CEO: UILabel!
    private var CEOTitle: UILabel!
    private var employees: UILabel!
    private var employeesTitle: UILabel!
    private var country: UILabel!
    private var city: UILabel!
    private var address: UILabel!
    private var addressTitle: UILabel!
    private var scrollView: UIScrollView!
    
    private var ref: String!
    
    private var alert: UIAlertController!
    private var indecator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeView))
        view.backgroundColor = .tertiarySystemBackground
        
        indecator = {
            let ind = UIActivityIndicatorView()
            ind.style = .large
            ind.center = view.center
            view.addSubview(ind)
            ind.startAnimating()
            return ind
        }()
        
        image = {
            let img = UIImageView()
            img.backgroundColor = .white
            img.clipsToBounds = true
            img.layer.cornerRadius = 15
            img.contentMode = .scaleAspectFit
            img.layer.borderColor = UIColor.systemPink.cgColor
            img.layer.borderWidth = 2.0
            view.addSubview(img)
            img.snp.makeConstraints { snap in
                snap.centerX.equalToSuperview()
                snap.top.equalToSuperview().offset(30)
                snap.width.equalToSuperview().dividedBy(2.7)
                snap.height.equalTo(view.frame.width/2.7)
            }
            return img
        }()
        
        CompanyInfo.getCompanyBio(ticker: ticker) { bio, er in
            guard er == nil else {
                self.alertAction(er!)
                return
            }
            
            self.ref = bio?.website
            
            self.name = {
                let lab = UILabel()
                lab.textAlignment = .right
                lab.font = UIFont.font(17, UIFont.FontType.main)
                lab.tintColor = .label
                lab.numberOfLines = 3
                lab.text = bio!.name!
                lab.sizeToFit()
                self.view.addSubview(lab)
                lab.snp.makeConstraints { snap in
                    snap.right.equalToSuperview().offset(-30)
                    snap.top.equalTo(self.image.snp.bottom).offset(30)
                    snap.width.equalToSuperview().dividedBy(2)
                }
                return lab
            }()
            
            var tagsString = ""
            for i in 0..<bio!.tags!.count{
                let word = bio!.tags![i].trimmingCharacters(in: .whitespaces)
                tagsString += word+", "
            }
            tagsString += (bio?.tags?.last)!
            

            self.tags = {
                let lab = UILabel()
                lab.textAlignment = .right
                lab.font = UIFont.font(12, UIFont.FontType.main)
                lab.tintColor = .label
                lab.numberOfLines = 10
                lab.text = tagsString
                lab.sizeToFit()
                self.view.addSubview(lab)
                lab.snp.makeConstraints { snap in
                    snap.top.equalTo(self.name.snp.bottom).offset(10)
                    snap.right.equalToSuperview().offset(-30)
                    snap.width.equalToSuperview().dividedBy(2)
                }
                return lab
            }()

            self.website = {
                let lab = UIButton()
                lab.setTitle(bio!.website, for: .normal)
                lab.contentHorizontalAlignment = .right
                lab.addTarget(self, action: #selector(self.openWebsite), for: .touchUpInside)
                lab.setTitleColor(.systemPink, for: .normal)
                lab.titleLabel?.font = UIFont.font(15, UIFont.FontType.main)
                lab.tintColor = .label
                lab.sizeToFit()
                lab.sizeToFit()
                self.view.addSubview(lab)
                lab.snp.makeConstraints { snap in
                    snap.top.equalTo(self.tags.snp.bottom).offset(10)
                    snap.right.equalToSuperview().offset(-30)
                    snap.width.equalToSuperview().dividedBy(2)
                }
                return lab
            }()
            
            self.scrollView = {
                let lab = UIScrollView()
                lab.sizeToFit()
                lab.isDirectionalLockEnabled = true
                lab.delegate = self
                lab.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
                self.view.addSubview(lab)
                lab.snp.makeConstraints { snap in
                    snap.top.equalTo(self.website.snp.bottom).offset(10)
                    snap.right.equalToSuperview().offset(-30)
                    snap.width.equalToSuperview().dividedBy(2)
                    snap.height.equalToSuperview().dividedBy(5)
                }
                return lab
            }()

            self.describ = {
                let lab = UILabel()
                lab.textAlignment = .right
                lab.font = UIFont.font(15, UIFont.FontType.main)
                lab.tintColor = .label
                lab.numberOfLines = 50
                lab.text = bio!.describ!
                self.scrollView.addSubview(lab)
                lab.snp.makeConstraints { snap in
                    snap.edges.equalTo(self.scrollView)
                    snap.width.equalToSuperview()
                }
                return lab
            }()
                
                self.describTitle = {
                    let lab = UILabel()
                    lab.textAlignment = .left
                    lab.font = UIFont.font(17, UIFont.FontType.main)
                    lab.tintColor = .label
                    lab.text = "Описание:"
                    lab.sizeToFit()
                    self.view.addSubview(lab)
                    lab.snp.makeConstraints { snap in
                        snap.left.equalToSuperview().offset(30)
                        snap.top.equalTo(self.scrollView.snp.top)
                        snap.width.equalToSuperview().dividedBy(3)
                    }
                    return lab
                }()

            self.CEO = {
                let lab = UILabel()
                lab.textAlignment = .right
                lab.font = UIFont.font(15, UIFont.FontType.main)
                lab.tintColor = .label
                lab.text = bio!.CEO!
                lab.sizeToFit()
                self.view.addSubview(lab)
                lab.snp.makeConstraints { snap in
                    snap.top.equalTo(self.scrollView.snp.bottom).offset(10)
                    snap.right.equalToSuperview().offset(-30)
                    snap.width.equalToSuperview().dividedBy(2)
                }
                return lab
            }()

            self.employees = {
                let lab = UILabel()
                lab.textAlignment = .right
                lab.font = UIFont.font(15, UIFont.FontType.main)
                lab.tintColor = .label
                lab.text = "\(bio!.employees!)"
                lab.sizeToFit()
                self.view.addSubview(lab)
                lab.snp.makeConstraints { snap in
                    snap.top.equalTo(self.CEO.snp.bottom).offset(10)
                    snap.right.equalToSuperview().offset(-30)
                    snap.width.equalToSuperview().dividedBy(2)
                }
                return lab
            }()

            self.address = {
                let lab = UILabel()
                lab.textAlignment = .right
                lab.font = UIFont.font(15, UIFont.FontType.main)
                lab.tintColor = .label
                lab.numberOfLines = 5
                lab.text = bio!.country!+", "+bio!.city!+", "+bio!.address!
                lab.sizeToFit()
                self.view.addSubview(lab)
                lab.snp.makeConstraints { snap in
                    snap.top.equalTo(self.employees.snp.bottom).offset(10)
                    snap.right.equalToSuperview().offset(-30)
                    snap.width.equalToSuperview().dividedBy(2)
                }
                return lab
            }()

            
            self.nameTitle = {
                let lab = UILabel()
                lab.textAlignment = .left
                lab.font = UIFont.font(17, UIFont.FontType.main)
                lab.tintColor = .label
                lab.numberOfLines = 2
                lab.text = "Название:"
                lab.sizeToFit()
                self.view.addSubview(lab)
                lab.snp.makeConstraints { snap in
                    snap.left.equalToSuperview().offset(30)
                    snap.top.equalTo(self.name.snp.top)
                    snap.width.equalToSuperview().dividedBy(3)
                }
                return lab
            }()

            self.tagsTitle = {
                let lab = UILabel()
                lab.textAlignment = .left
                lab.font = UIFont.font(17, UIFont.FontType.main)
                lab.tintColor = .label
                lab.text = "Теги:"
                lab.sizeToFit()
                self.view.addSubview(lab)
                lab.snp.makeConstraints { snap in
                    snap.left.equalToSuperview().offset(30)
                    snap.top.equalTo(self.tags.snp.top)
                    snap.width.equalToSuperview().dividedBy(3)
                }
                return lab
            }()

            self.websiteTitle = {
                let lab = UILabel()
                lab.textAlignment = .left
                lab.font = UIFont.font(17, UIFont.FontType.main)
                lab.tintColor = .label
                lab.text = "Сайт:"
                lab.sizeToFit()
                self.view.addSubview(lab)
                lab.snp.makeConstraints { snap in
                    snap.left.equalToSuperview().offset(30)
                    snap.centerY.equalTo(self.website.snp.centerY)
                    snap.width.equalToSuperview().dividedBy(3)
                }
                return lab
            }()

            self.CEOTitle = {
                let lab = UILabel()
                lab.textAlignment = .left
                lab.font = UIFont.font(17, UIFont.FontType.main)
                lab.tintColor = .label
                lab.text = "CEO:"
                lab.sizeToFit()
                self.view.addSubview(lab)
                lab.snp.makeConstraints { snap in
                    snap.left.equalToSuperview().offset(30)
                    snap.top.equalTo(self.CEO.snp.top)
                    snap.width.equalToSuperview().dividedBy(3)
                }
                return lab
            }()

            self.employeesTitle = {
                let lab = UILabel()
                lab.textAlignment = .left
                lab.font = UIFont.font(17, UIFont.FontType.main)
                lab.tintColor = .label
                lab.text = "Кол-во сотруднкиков:"
                lab.sizeToFit()
                self.view.addSubview(lab)
                lab.snp.makeConstraints { snap in
                    snap.left.equalToSuperview().offset(30)
                    snap.top.equalTo(self.employees.snp.top)
                    snap.width.equalToSuperview().dividedBy(2)
                }
                return lab
            }()

            self.addressTitle = {
                let lab = UILabel()
                lab.textAlignment = .left
                lab.font = UIFont.font(17, UIFont.FontType.main)
                lab.tintColor = .label
                lab.text = "Адрес:"
                lab.sizeToFit()
                self.view.addSubview(lab)
                lab.snp.makeConstraints { snap in
                    snap.left.equalToSuperview().offset(30)
                    snap.top.equalTo(self.address.snp.top)
                    snap.width.equalToSuperview().dividedBy(2)
                }
                return lab
            }()

            self.image.image = bio?.image!

            self.indecator.stopAnimating()
        }
    }
    
    func setup(ticker :String){
        self.ticker = ticker
    }
    
    func alertAction(_ er: AFError){
        alert = UIAlertController(title: er.responseCode?.description, message: er.errorDescription!, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .destructive, handler: nil))
        indecator.stopAnimating()
        present(self.alert, animated: true)
    }
    
    @objc func openWebsite(){
        if !ref.contains("https://"){
            ref = "https://"+ref
        }
        if let url = URL(string: ref){
            let sfvc = SFSafariViewController(url: url)
            present(sfvc, animated: true, completion: nil)
        }
    }
    
    @objc func closeView(){
        dismiss(animated: true, completion: nil)
    }
}
