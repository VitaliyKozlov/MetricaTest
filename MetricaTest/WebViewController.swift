//
//  WebViewController.swift
//  MetricaTest
//
//  Created by Vitaliy Kozlov on 15/04/2019.
//  Copyright © 2019 Vitaliy Kozlov. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate  {
let webView = WKWebView()
    override func loadView() {
        self.view = webView
        webView.navigationDelegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let realLink = UserDefaults.standard.string(forKey: "link")
        print ("REALLINK")
        print (realLink)
        guard let url = URL(string: realLink!) else {return}
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view.
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
