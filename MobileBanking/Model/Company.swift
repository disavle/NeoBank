//
//  Company.swift
//  iOS_Sirius_22
//
//  Created by Dima Savelyev on 12.02.2022.
//

import Foundation
import Alamofire
import SwiftyJSON
import Firebase

struct Company {
    var img: UIImage?
    var title: String?
    var ticker: String?
    var price: Float?
    var priceChange: Float?
}

struct CompanyBio {
    var image: UIImage?
    var name: String?
    var tags: [String]?
    var website: String?
    var describ: String?
    var CEO: String?
    var employees: Int?
    var country: String?
    var city: String?
    var address: String?
}

private let tokenCompany = "pk_99ae19bce0234d0b9c11e9c3208e2270"
private let queryCompany = ["token":tokenCompany]

class CompanyInfo{
    
    static func getInfo(ticker: String, _ completion: @escaping (String?,String?,Float?,Float?, AFError?)->()){
        let url = "https://cloud.iexapis.com/stable/stock/\(ticker)/quote"
        AF.request(url, method: .get, parameters: queryCompany).validate().responseData { response in
            if let error = response.error {
                debugPrint(error)
                completion(nil,nil,nil,nil, error)
            }
            guard let res = response.value else {return}
            let company = JSON(res)
            completion(company["companyName"].string,company["symbol"].string,company["latestPrice"].float,company["change"].float, nil)
        }
    }
    
    static func getImg(ticker:  String, _ completion: @escaping (UIImage?,AFError?)->()){
        let url = "https://storage.googleapis.com/iex/api/logos/\(ticker).png"
        AF.request(url, method: .get, parameters: queryCompany).validate().responseData { response in
            if let error = response.error {
                debugPrint(error)
                completion(UIImage(), error)
            }
            guard let res = response.value else {return }
            completion(UIImage(data:  res) ?? UIImage(),nil)
        }
    }
    
    static func getMarkets(tickers: [String], _ completion: @escaping ([Company]?, AFError?)->()){
        var coms = [Company]()
        for i in tickers{
            getInfo(ticker: i) { title, ticker, price, priceChange, er in
                guard er == nil else {
                    completion(nil, er)
                    return
                }
                getImg(ticker: i) { img, errr in
                    guard errr == nil else {
                        completion(nil, errr)
                        return
                    }
                    coms.append(Company(img: img, title: title, ticker: ticker, price: price, priceChange: priceChange))
                    completion(coms, nil)
                }
            }
        }
        
    }
    
    static func getCompanies( _ completion: @escaping ([String]) ->()){
        let db = Firestore.firestore()
        db.collection("companies").document("ebutyWDPRJl5CIzPgR8N").getDocument { result, err in
            guard let ar = result?.data() else{return completion([""])}
            completion(Array(ar.values) as! [String])
        }
    }
    
    static func getCompanyBio(ticker: String, _ completion: @escaping (CompanyBio?,AFError?) ->()){
        let url = "https://cloud.iexapis.com/stable/stock/\(ticker)/company"
        AF.request(url, method: .get, parameters: queryCompany).validate().responseData { response in
            if let error = response.error {
                debugPrint(error)
                completion(nil, error)
            }
            guard let res = response.value else {return}
            let company = JSON(res)
            getImg(ticker: ticker) { img, errr in
                guard errr == nil  else {
                    completion(nil, errr)
                    return
                }
                completion(CompanyBio(image: img, name: company["companyName"].string, tags: (company["tags"].arrayObject as! [String]), website: company["website"].string, describ: company["description"].string, CEO: company["CEO"].string, employees: company["employees"].int, country: company["country"].string, city: company["city"].string, address: company["address"].string),nil)
            }
            
        }
    }
    
    //    static func getMarket(listType: String, _ completion: @escaping ([String:String]?, AFError?)->()){
    //        var result = [String:String]()
    //        let url = "https://cloud.iexapis.com/stable/stock/market/list/\(listType)"
    //        AF.request(url, method: .get, parameters: queryCompany).validate().responseData { response in
    //            if let error = response.error {
    //                debugPrint(error)
    //                completion(nil, error)
    //            }
    //            guard let res = response.value else {return}
    //            let markets = JSON(res)
    //            for market in markets.arrayValue{
    //                result.updateValue(market["symbol"].string!, forKey: market["companyName"].string!)
    //            }
    //            completion(result, nil)
    //        }
    //    }
}
