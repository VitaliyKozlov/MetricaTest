//
//  ViewController.swift
//  MetricaTest
//
//  Created by Vitaliy Kozlov on 31/03/2019.
//  Copyright © 2019 Vitaliy Kozlov. All rights reserved.
//

import UIKit
import YandexMobileMetrica
import FacebookCore
import AppsFlyerLib
import WebKit
var dataUrl = googleUrl
class ViewController: UIViewController {

    @IBOutlet weak var startWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(webViewUpdate), name: deepLinkNotification, object: nil)
        // Yandex Metrica
        YMMYandexMetrica.reportEvent("I am working", onFailure: { (error) in
            print("Error YandexMetrica")
            
        })
        // Facebook Analytics
        AppEventsLogger.log("I am working")
        // AppFlyers
        AppsFlyerTracker.shared()?.trackEvent("I am working", withValues: ["Message" : "I am working"])
    }
    // webView
    override func viewDidAppear(_ animated: Bool) {
        let request = URLRequest (url: dataUrl!)
        startWebView.load(request)
    }
    
    @objc func webViewUpdate () {
        let request = URLRequest (url: dataUrl!)
        startWebView.load(request)
    }

}

