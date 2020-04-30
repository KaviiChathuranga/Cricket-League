//
//  OutAlertViewController.swift
//  Cricket League
//
//  Created by Treinetic Macbook004 on 9/3/19.
//  Copyright © 2019 Treinetic Macbook004. All rights reserved.
//

import UIKit

class OutAlertViewController: UIViewController {

    var time = 6
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callTimer()
        // Do any additional setup after loading the view.
    }
    
    func callTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(OutAlertViewController.action)), userInfo: nil, repeats: true)
    }
    
    @objc func action(){
        time -= 1
        if time == 3{
            self.dismiss(animated: true, completion: nil)
            timer.invalidate()
        }
    }

}
