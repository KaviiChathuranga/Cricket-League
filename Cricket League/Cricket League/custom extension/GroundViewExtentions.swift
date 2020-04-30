import Foundation
import UIKit
class GroundViewExtentions{}

extension UIImageView {
    func intersects(_ otherView: UIImageView) -> Bool {
        if self === otherView { return false }
        return self.frame.intersects(otherView.frame)
    }
}
extension GroundViewController: winProtocal,gameOverProtocal{
    func dismiss(){}
}
extension GroundViewController{
    func changeBehaviors(){
        targetLbl.text = "Target is : \(String(describing: myTarget))"
        ball.layer.cornerRadius = ball.frame.height/2
        self.sixOrFourImg.isHidden = true
    }
    func callTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(OutAlertViewController.action)), userInfo: nil, repeats: true)
    }
    @objc func action(){
        time -= 1
        if time == 1{
            batBtn.isEnabled = true
            startBall()
            time = 5
        }
        if time == 0 {
            batBtn.isEnabled = true
        }
    }
    func startBall(){
        ballingSound.startOneTimeMusic()
        ballingSound.adjustMusic(Volume: 0.3)
        overBalls += 0.1
        self.otherRunsLbl.text = "$"+"\(self.myBalance)"
        self.sixOrFourImg.isHidden = true
        let duration = Double.random(in: 1.0 ... 2.7)
        UIView.animate(withDuration: duration,
                       animations: {
                        self.baller.image = UIImage(named: "ballThrowedIcon")
                        self.ball.transform = CGAffineTransform( translationX:
                            self.sideView.frame.origin.x - self.view.frame.origin.x , y: CGFloat(self.getRandomPosition()))
        },
                       completion: { _ in
                        self.checkOut()
                        self.baller.image = UIImage(named: "ballerIcon")
                        self.ball.transform = CGAffineTransform( translationX: 0 , y: CGFloat(0))
        })
        if overBalls > 0.5{
            overBalls = 0.0
            overs =  overs + 1
        }
        overBalls = (overBalls * 1000).rounded() / 1000
        oversLbl.text = "\(overs + overBalls)"
    }
    func resetAll(){
        self.runs = 0
        self.runsLbl.text = "\(runs)"
        self.defenceCount = 0
        self.overBalls = 0.0
        self.overs = 0
        self.wickets = 0
        self.wicketsLbl.text = "\(wickets)"
        self.targetLbl.text = ""
        self.sixOrFourImg.isHidden = true
        self.oversLbl.text = "0.0"
        self.bet = "$0.00"
        self.team = "None"
        defenceBtn.setImage(UIImage(named: "playBtn"), for: .normal)
        self.bettingPriceLbl.text = bet+" For "+team
        self.timer.invalidate()
    }
    func getRandomPosition() -> Int{
        if UIDevice.current.model == "iPhone" {
            let value = Int.random(in: -35 ... 50)
            return value
        }else{
            let value = Int.random(in: -40 ... 70)
            return value
        }
    }
    func getRandomInt() -> Int{
        let value = Int.random(in: -10 ... 10)
        if value == 0 {
            return value + 1
        }
        return value
    }
}
