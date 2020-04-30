//
//  GameOverViewController.swift
//  Cricket League
//
//  Created by Treinetic Macbook004 on 9/4/19.
//  Copyright © 2019 Treinetic Macbook004. All rights reserved.
//

import UIKit
protocol gameOverProtocal {
    func dismiss()
}
class GameOverViewController: UIViewController {
    var time = 6
    var timer = Timer()
    var delegate : gameOverProtocal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callTimer()
        // Do any additional setup after loading the view.
    }
    
    func callTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(GameOverViewController.action)), userInfo: nil, repeats: true)
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
