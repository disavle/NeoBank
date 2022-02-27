//
//  CurrencyRate.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 26.02.2022.
//

import UIKit
import Alamofire
import SwiftyJSON

struct CurrencyRateModel{
    var title: String!
    var price: Double!
}

private let token = "2194a4a0-973a-11ec-a9b5-35ed6c525522"
private let query = ["apikey":token,"base_currency":"RUB"]

class CurrencyRate{
    
    static func getCurrencyList( _ completion: @escaping ([CurrencyRateModel]?, AFError?)->()){
        var result = [CurrencyRateModel]()
        let url = "https://freecurrencyapi.net/api/v2/latest"
        AF.request(url, method: .get, parameters: query).validate().responseData { response in
            if let error = response.error {
                debugPrint(error)
                completion(nil, error)
            }
            guard let res = response.value else {return}
            let rates = JSON(res)
            for rate in rates["data"].dictionaryObject!{
                result.append(CurrencyRateModel(title: rate.key, price: (Double(round(100 * (1/((rate.value as? Double)!)))/100) )))
            }
            completion(result, nil)
        }
    }
}
