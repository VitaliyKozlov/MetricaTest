//
//  YesterdayViewController.swift
//  MetricaTest
//
//  Created by Vitaliy Kozlov on 08/04/2019.
//  Copyright © 2019 Vitaliy Kozlov. All rights reserved.
//

import UIKit
import Alamofire
import RxCocoa
import RxSwift

class YesterdayViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gradePickerValues.count
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
    
    let dataRx = Variable<[Event]>([])
    var dataItems = [Event]()
    let disposeBag = DisposeBag()
    var gradePicker: UIPickerView!
    let gradePickerValues = ["Soccer", "Basketball", "Ice Hockey"]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sportField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData ()
        gradePicker = UIPickerView()
        
        gradePicker.dataSource = self
        gradePicker.delegate = self
        
        sportField.inputView = gradePicker
        sportField.text = gradePickerValues[0]
        
        dataRequest()
    }
    
    func dataRequest() {
        let now = Date() // сегодня
        let date0 = Calendar.current.startOfDay(for: now) // 00:00:00 сегодня
        let dateFormatter = DateFormatter()
        let date = date0 - (60*60*24)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        print("ДАТА ВЧЕРАШНЯЯ\(dateString)")
        
        let timeFullFormater = DateFormatter()
        timeFullFormater.dateFormat = "yyyy-MM-ddTHH:mm:ss"
        
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        let escapedAddress = "https://www.thesportsdb.com/api/v1/json/1/eventsday.php?d=\(dateString)&s=\(sportField.text!)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
       // let escapedAddress = "https://www.thesportsdb.com/api/v1/json/1/eventsday.php?d=2019-01-04&s=\(sportField.text!)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let url = URL (string: escapedAddress!)
        print ("URL \(url)")
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
                            let time = String((item.strTime?.prefix(5)) ?? "No Time")
                            dataItem.strTime = time
                            //self.dataRx.value.append(dataItem)
                            self.dataItems.append(dataItem)
                            self.dataItems = self.dataItems.sorted{$0.strTime! < $1.strTime!}
                            
                        }
                        self.dataRx.value.removeAll()
                        self.dataRx.value = self.dataItems
                        
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
            .drive (tableView.rx.items(cellIdentifier: "cell1", cellType: TodayTableViewCell.self)) { (row, element, cell) in
                //cell.configure(element: element)
                cell.configure(element: element)
            }.disposed (by: disposeBag)
    }


}
