//
//  ViewController.swift
//  MetricaTest
//
//  Created by Vitaliy Kozlov on 31/03/2019.
//  Copyright © 2019 Vitaliy Kozlov. All rights reserved.
//

import UIKit
import FacebookCore
import AppsFlyerLib
import WebKit
import Alamofire
import RxCocoa
import RxSwift
import FBSDKCoreKit.FBSDKAppLinkUtility

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var webView: WKWebView!
    
    
 let dataRx = Variable<[Event]>([])
    var dataItems = [Event]()
    let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sportField: UITextField!
    var gradePicker: UIPickerView!
    let gradePickerValues = ["Soccer", "Basketball", "Ice Hockey"]
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gradePickerValues.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gradePickerValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        sportField.text = gradePickerValues[row]
        self.dataRx.value.removeAll()
        dataRequest()
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradePicker = UIPickerView()
        
        gradePicker.dataSource = self
        gradePicker.delegate = self
        
        sportField.inputView = gradePicker
        sportField.text = gradePickerValues[0]
        
        // AppFlyers
        AppsFlyerTracker.shared()?.trackEvent("I am working", withValues: ["Message" : "I am working"])
        
        bindData()
        dataRequest()
        
    }
    
    func dataRequest() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-dd-MM"
        let dateString = dateFormatter.string(from: date)
        print("ДАТА ТЕКУЩАЯ\(dateString)")
        
        let timeFullFormater = DateFormatter()
        timeFullFormater.dateFormat = "yyyy-MM-ddTHH:mm:ss"
        
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        let escapedAddress = "https://www.thesportsdb.com/api/v1/json/1/eventsday.php?d=\(dateString)&s=\(sportField.text!)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let url = URL (string: escapedAddress!)
        request(url!, method: .get, parameters: nil, headers: nil).validate().responseData {[unowned self] response in
            switch response.result {
            case .success(let value):
                do {
                    let list = try JSONDecoder().decode(Events.self, from: value)
                    let dataTemp = list.events
                    self.dataItems.removeAll()
                    if (dataTemp != nil){
                        
                    for item in dataTemp! {
                        var dataItem = Event()
                        dataItem = item
                        // let time = timeFullFormater.date(from: item.event_date!)
                        // let timeString = timeFormatter.string(from: time!)
                        let time = String((item.strTime?.prefix(5))!)
                        dataItem.strTime = time
                        //self.dataRx.value.append(dataItem)
                        self.dataItems.append(dataItem)
                        self.dataItems = self.dataItems.sorted{$0.strTime! < $1.strTime!}
                        
                    }
                        self.dataRx.value.removeAll()
                        self.dataRx.value = self.dataItems
                        print ("Elements")
                        print (self.dataItems.count)
                    } else {
                        self.dataRx.value.removeAll()
                       self.showAlertNoEvent()
                    }
                    
                }catch {
                    print (error)
                }
                
            case .failure (let error):
                print (error)
            }
        }
    }
    func bindData () {
        dataRx
            .asDriver()
            .drive (tableView.rx.items(cellIdentifier: "cell", cellType: YestedayTableViewCell.self)) { (row, element, cell) in
                //cell.configure(element: element)
                cell.configure(element: element)
            }.disposed (by: disposeBag)
    }
    
    

}

