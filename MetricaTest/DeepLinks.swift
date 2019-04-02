//
//  DeepLinks.swift
//  MetricaTest
//
//  Created by Vitaliy Kozlov on 02/04/2019.
//  Copyright © 2019 Vitaliy Kozlov. All rights reserved.
//

import Foundation
enum DeeplinkType {
    case yandex
    case google
}

let Deeplinker = DeepLinkManager()
class DeepLinkManager {
    fileprivate init() {}
    private var deeplinkType: DeeplinkType?
    func checkDeepLink(){
        guard let deeplinkType = deeplinkType else {return}
        DeeplinkNavigator().proceedToDeeplink(deeplinkType)
        self.deeplinkType = nil
    }
    @discardableResult
    func handleDeeplink(url: URL) -> Bool {
        deeplinkType = DeeplinkParser.shared.parseDeepLink(url)
        print (deeplinkType)
        return deeplinkType != nil
    }
}
    
    class DeeplinkNavigator {
        static let shared = DeeplinkNavigator()
         init() { }
        func proceedToDeeplink(_ type: DeeplinkType) {
            switch type {
            case .yandex:
                print ("Yandex")
            case .google:
                print ("Google")
            }
        }
    }
class DeeplinkParser {
    static let shared = DeeplinkParser()
    private init() { }

    func parseDeepLink(_ url: URL) -> DeeplinkType? {
        print (url)
        
        let str = url.absoluteString
        switch str {
        case "deeplinkTutorial://yandex":
            dataUrl = yandexUrl
            NotificationCenter.default.post(name: deepLinkNotification, object: nil)
        case "deeplinkTutorial://google":
            dataUrl = googleUrl
            NotificationCenter.default.post(name: deepLinkNotification, object: nil)
            
        default:
            break
        }
        return nil
    }
}
