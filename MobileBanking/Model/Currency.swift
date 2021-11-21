//
//  Currency.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 20.11.2021.
//

import Foundation
import UIKit

enum Currency: String, CaseIterable {
//    case rub = "₽"
    case dol = "$"
    case eu = "€"
}

enum Target: String, CaseIterable {
    case food = "Фастфуд"
    case sport = "Спортзал"
    case market = "Продуктовый"
    case enter = "Развлечения"
    case tech = "Техника"
    case subs = "Подписки"
    case clothes = "Одежда"
    case bar = "Бар"
    case rest = "Ресторан"
    case fuel = "Бензин"
    case animal = "Зоомагазин"
}
