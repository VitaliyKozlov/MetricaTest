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


class StartViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    var facebookData = String ()
    let webView = WKWebView()
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
    }
    
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print ("Redirect")
        // print (webView.url)
        print (appsFlyerData)
        guard let redirectUrl = webView.url else {return}
        let redirect = "\(redirectUrl)"
        switch redirect {
        case "https://www.bisefusanadom.com":
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
        if appsFlyerData["af_c_id"] != nil {
            let ad_campaign_id = "\(appsFlyerData["af_c_id"] ?? "")"
            appFlyerString = appFlyerString + "&ad_campaign_id=\(ad_campaign_id)"
        }
        if appsFlyerData["adgroup_id"] != nil {
            let creative_id = "\(appsFlyerData["adgroup_id"] ?? "")"
            appFlyerString = appFlyerString + "&creative_id=\(creative_id)"
        }
        if appsFlyerData["af_ad_id"] != nil{
            let creative_id = "\(appsFlyerData["af_ad_id"] ?? "")"
            appFlyerString = appFlyerString + "&creative_id=\(creative_id)"
        }
        if appsFlyerData["adgroup_id"] != nil {
            let sub_id_3 = "\(appsFlyerData["adgroup_id"] ?? "")"
            appFlyerString = appFlyerString + "&sub_id_3=\(sub_id_3)"
        }
        
        if appsFlyerData["pid"] != nil {
            let sub_id_6 = "\(appsFlyerData["pid"] ?? "")"
            appFlyerString = appFlyerString + "&sub_id_6=\(sub_id_6)"
        }
        if appsFlyerData["media_source"] != nil {
            let sub_id_6 = "\(appsFlyerData["media_source"] ?? "")"
            appFlyerString = appFlyerString + "&sub_id_6=\(sub_id_6)"
        }
        if appsFlyerData["organic"] != nil {
            let sub_id_6 = "\(appsFlyerData["organic"] ?? "")"
            appFlyerString = appFlyerString + "&sub_id_6=\(sub_id_6)"
        }
        // ЕСЛИ sub4 есть может не быть sub_id_1, sub_id_2, extra_param_6
        if appsFlyerData["campaign"] != nil {
            let sub_id_4 = "\(appsFlyerData["campaign"] ?? "")"
            appFlyerString = appFlyerString + "&sub_id_4=\(sub_id_4)"
            if sub_id_4 != ""{
                let arrayCampaign = sub_id_4.components(separatedBy: "_")
                let sub_id_1 = arrayCampaign[0]
                let sub_id_2 = arrayCampaign[1]
                let extra_param_6 = arrayCampaign[2]
                appFlyerString = appFlyerString + "&sub_id_1=\(sub_id_1)&sub_id_2=\(sub_id_2)&extra_param_6=\(extra_param_6)"
            }
        }
        
        let url = URL(string: "https://hovichuvni.mikemilikanich.site/Bj7QZbNj" + "?" + facebookData + appFlyerString)!
        print ("URL")
        print (url)
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            self.webView.load(URLRequest(url: url))
            self.webView.allowsBackForwardNavigationGestures = true
        }
        
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
