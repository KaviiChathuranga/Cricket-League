//
//  WinnerAlertViewController.swift
//  Cricket League
//
//  Created by Treinetic Macbook004 on 9/5/19.
//  Copyright © 2019 Treinetic Macbook004. All rights reserved.
//

import UIKit
protocol winProtocal {
    func dismiss()
}

class WinnerAlertViewController: UIViewController {
    var time = 6
    var timer = Timer()
    var value = ""
    var runs = ""
    @IBOutlet weak var betLbl: UILabel!
    @IBOutlet weak var runsLbl: UILabel!
    var delegate : winProtocal!
    override func viewDidLoad() {
        super.viewDidLoad()
        callTimer()
        changeTxt()
    }
    
    func changeTxt(){
        betLbl.text = value
        runsLbl.text = runs
    }
    func callTimer(){
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: (#selector(WinnerAlertViewController.action)), userInfo: nil, repeats: true)
    }
    
    @objc func action(){
        time -= 1
        if time == 3{
            delegate.dismiss()
            self.dismiss(animated: true, completion: nil)
            timer.invalidate()
        }
    }



}
