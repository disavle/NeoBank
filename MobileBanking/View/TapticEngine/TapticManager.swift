//
//  TapticManager.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 13.08.2021.
//

import UIKit

final class TapticManager{
    static let shared = TapticManager()
    
    private init(){}

    public func vibrateFeedback(for type: UINotificationFeedbackGenerator.FeedbackType){
        DispatchQueue.main.async {
            let notify = UINotificationFeedbackGenerator()
            notify.prepare()
            notify.notificationOccurred(type)
        }
    }
    
    public func vibrateSoft(){
        DispatchQueue.main.async {
            let notify = UIImpactFeedbackGenerator(style: .soft)
            notify.prepare()
            notify.impactOccurred()
        }
    }
}

