//
//  TargetAlertViewController.swift
//  Cricket League
//
//  Created by Treinetic Macbook004 on 9/5/19.
//  Copyright © 2019 Treinetic Macbook004. All rights reserved.
//

import UIKit
protocol targetAlertProtocal {
    func getTarget(target: Int)
}

class TargetAlertViewController: UIViewController {

    var time = 6
    var timer = Timer()
    var delegate : targetAlertProtocal!
    @IBOutlet weak var targetLbl: UILabel!
    @IBOutlet weak var oversLbl: UILabel!
    var target = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        callTimer()
        getRandomTarget()
    }
    
    func getRandomTarget(){
        let randomTarget = Int.random(in: 150 ... 300)
        self.target = randomTarget
        targetLbl.text = "\(randomTarget) Runs"
    }
    
    func callTimer(){
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: (#selector(TargetAlertViewController.action)), userInfo: nil, repeats: true)
    }
    
    @objc func action(){
        time -= 1
        if time == 3{
            delegate.getTarget(target: self.target)
            self.dismiss(animated: true, completion: nil)
            timer.invalidate()
        }
    }


}
