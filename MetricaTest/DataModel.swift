//
//  DataModel.swift
//  MetricaTest
//
//  Created by Vitaliy Kozlov on 05/04/2019.
//  Copyright © 2019 Vitaliy Kozlov. All rights reserved.
//

import Foundation
struct Event : Codable{
    var idEvent : String?
    var dateEvent : String?
    var strTime : String?
    var strLeague : String?
    var intHomeScore : String?
    var intAwayScore : String?
    var strHomeTeam : String?
    var strAwayTeam : String?
    //var final_score : String?
    
}
struct Fixtures : Codable{
    var fixtures : [String : Event]?
    var result : Int?
}
struct Events : Codable {
   var events : [Event]?
}
struct Counts : Codable {
    var api : Result?
}
struct Result : Codable{
   var results : Int?
}
var appsFlyerData = [AnyHashable: Any] ()
let appFlayerDataLoaded = NSNotification.Name(rawValue: "appFlayerDataLoaded")
var link = String()
