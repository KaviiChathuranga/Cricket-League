//
//  ViewController.swift
//  Cricket League
//
//  Created by Treinetic Macbook004 on 9/2/19.
//  Copyright © 2019 Treinetic Macbook004. All rights reserved.
//

import UIKit

class MainController: UIViewController {

    @IBOutlet weak var t1Btn: UIButton!
    @IBOutlet weak var t2Btn: UIButton!
    @IBOutlet weak var plusBtn: UIImageView!
    @IBOutlet weak var nxtBtn: UIButton!
    @IBOutlet weak var negativeBtn: UIImageView!
    @IBOutlet weak var betPrice: UILabel!
    var team = ""
    var betValue = 05.00
    var time = 5
    var timer = Timer()
    var myTarget = 0
    var click = false
    var myCoin = ""
    var userDefaults =  UserDefaults.standard
     override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.callTargetTime()
        }
        if userDefaults.double(forKey: "amount") <= 10.0 {
            userDefaults.set(500.0, forKey: "amount")
            userDefaults.synchronize()
        }
    }
    
    @IBAction func t1Action(_ sender: Any) {
 
    }
    
    @IBAction func t2Action(_ sender: Any) {
        
        if !click {
           click = true
            self.t2Btn.setImage(UIImage(named: "t1"), for: .normal)
            team = "Batting Team"
        }else{
            click = false
            self.t2Btn.setImage(UIImage(named: "battingTeam"), for: .normal)
            team = ""
        }
    }
    
    @IBAction func nxtAction(_ sender: Any) {
   
        let amout = userDefaults.double(forKey: "amount")
        var value = self.betPrice.text!.split{$0 == "$"}.map(String.init)
        let number: String = value[0]
        if (Double(number)!) >= amout && self.team != "" {
            return
        }
            performSegue(withIdentifier: "betToMatchIdentifier", sender: nil)
    }
    
    @IBAction func plusAction(_ sender: Any) {
        betValue += 5
        betPrice.text = "$\(betValue)"
    }
    
    @IBAction func negativeAction(_ sender: Any) {
        if betValue <= 5.0 {
            return
        }
        betValue -= 5
        betPrice.text = "$\(betValue)"
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "betToMatchIdentifier"{
            let details = segue.destination as! GroundViewController
            if self.team != ""{
                details.bet = betPrice.text as! String
            }else{
                details.bet = "$0.00"
            }
            details.team = team
            details.myTarget = myTarget
         }
        if segue.identifier == "targetIdentifier"{
            let details = segue.destination as! TargetAlertViewController
            details.delegate = self
        }
    }
    func callTargetTime(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(MainController.targetAlert)), userInfo: nil, repeats: true)
    }
    
    @objc func targetAlert(){
        time -= 1
        if time == 4{
            performSegue(withIdentifier: "targetIdentifier", sender: nil)
            timer.invalidate()
            time = 5
        }
    }
}
extension MainController: targetAlertProtocal{
    func dismiss() {
    }
    func getTarget(target: Int) {
        myTarget = target
        print(myTarget)
    }
}
