//
//  YestedayTableViewCell.swift
//  MetricaTest
//
//  Created by Vitaliy Kozlov on 05/04/2019.
//  Copyright © 2019 Vitaliy Kozlov. All rights reserved.
//

import UIKit

class YestedayTableViewCell: UITableViewCell {

    @IBOutlet weak var homeTeam: UILabel!
    @IBOutlet weak var guestTeam: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var ligue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure (element : Event){
       time.text = element.strTime
        ligue.text = "League: \(element.strLeague ?? "")"
        homeTeam.text = element.strHomeTeam ?? ""
        guestTeam.text = element.strAwayTeam ?? ""
        let homeScore = element.intHomeScore ?? ""
        let awayScore = element.intAwayScore ?? ""
        if homeScore != "" && awayScore != ""{
            score.text = "\(element.intHomeScore ?? "") - \(element.intAwayScore ?? "")"
            //time.text = dateFormatterGet.string(from: timeFormat!)
            // print ("_______________")
            let goalsHomeTeam = Int(element.intHomeScore ?? "0")!
            // print (goalsHomeTeam)
            let goalsAwayTeam = Int(element.intAwayScore ?? "0")!
            //print (goalsAwayTeam)
            if goalsHomeTeam > goalsAwayTeam {
                homeTeam.textColor = UIColor.green
                guestTeam.textColor = UIColor.red
            } else {
                if goalsHomeTeam < goalsAwayTeam {
                    homeTeam.textColor = UIColor.red
                    guestTeam.textColor = UIColor.green
                }
            }
        } else {
            score.text = ""
            homeTeam.textColor = UIColor.black
            guestTeam.textColor = UIColor.black
        }
        
    }
}
extension UITableViewCell {
}
