//
//  SixFourViewController.swift
//  Cricket League
//
//  Created by Treinetic Macbook004 on 9/4/19.
//  Copyright © 2019 Treinetic Macbook004. All rights reserved.
//

import UIKit

class SixFourViewController: UIViewController {

    var time = 5
    var timer = Timer()
    var value = ""
    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if value == "6"{
            img.image = UIImage(named: "6")
        }else{
            img.image = UIImage(named: "4")
        }
        callTimer()
        // Do any additional setup after loading the view.
    }

    
    func callTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(SixFourViewController.action)), userInfo: nil, repeats: true)
    }
    
    @objc func action(){
        time -= 1
        if time == 3{
            self.dismiss(animated: true, completion: nil)
            timer.invalidate()
        }
    }
}
