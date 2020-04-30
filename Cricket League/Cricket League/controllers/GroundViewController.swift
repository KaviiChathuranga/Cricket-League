import UIKit
class GroundViewController: UIViewController, UICollisionBehaviorDelegate {
    @IBOutlet weak var sixOrFourImg: UIImageView!
    @IBOutlet weak var bettingPriceLbl: UILabel!
    @IBOutlet weak var pitch: UIImageView!
    @IBOutlet weak var targetLbl: UILabel!
    @IBOutlet weak var ballWicket: UIButton!
    @IBOutlet weak var batWicket: UIButton!
    @IBOutlet weak var oversLbl: UILabel!
    @IBOutlet weak var runsLbl: UILabel!
    @IBOutlet weak var wicketsLbl: UILabel!
    @IBOutlet weak var baller: UIImageView!
    @IBOutlet weak var batsmen: UIImageView!
    @IBOutlet weak var ball: UIButton!
    @IBOutlet weak var otherRunsLbl: UILabel!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var batBtn: UIButton!
    var ballFrm = CGRect()
    var wicketFrm = CGRect()
    var wickets = 0
    var runs = 0
    var bet = String()
    var team = String()
    var overBalls = 0.0
    var overs = 0.0
    var time = 5
    var timer = Timer()
    var hit = false
    var side = ""
    var batsmenX = CGFloat()
    var batsmenY = CGFloat()
    var driveCount = 0
    var backCount = 0
    var myTarget = 0
    var defenceCount = 0
    var selfSize = 0
    var marks = 0
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var x = 0
    var y = 0
    var foot = false
    var userDefaults = UserDefaults.standard
    var myBalance = 0.0
    var batSound = MusicPlay.init(MusicName: "shot",MusicType: ".wav")
    var fourSound = MusicPlay.init(MusicName: "4_sound",MusicType: ".wav")
    var sixSound = MusicPlay.init(MusicName: "6_sound",MusicType: ".wav")
    var outSound = MusicPlay.init(MusicName: "out_sound",MusicType: ".wav")
    var winSound = MusicPlay.init(MusicName: "little_robot_sound_factory_Jingle_Win_Synth_06",MusicType: ".mp3")
    var ballingSound = MusicPlay.init(MusicName: "ballind_sound",MusicType: ".wav")
    var backgroundSound = MusicPlay.init(MusicName: "Sports Stadium Crowd Cheering Sound Effect",MusicType: ".mp3")
    @IBOutlet weak var defenceBtn: UIButton!
    @IBOutlet weak var hideBall: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        changeBehaviors()
        ballFrm = ball.frame
        wicketFrm = batWicket.frame
        bettingPriceLbl.text = bet+" For "+team
        animator = UIDynamicAnimator(referenceView: ball)
        hideBall.alpha = 0
        myBalance = userDefaults.double(forKey: "amount")
        otherRunsLbl.text = "$"+"\(myBalance)"
        if myBalance <= 10 {
            userDefaults.set(500.0, forKey: "amount")
            userDefaults.synchronize()
            myBalance = userDefaults.double(forKey: "amount")
            otherRunsLbl.text = "$"+"\(myBalance)"
        }
    }
    @IBAction func backAction(_ sender: Any) {
        timer.invalidate()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func batAction(_ sender: Any) {
        batBtn.isEnabled = false
        let balla = UIImageView()
        let bata = UIImageView()
        selfSize = Int(self.view.frame.height/CGFloat(getRandomInt()))
        let ballXY = ball.layer.presentation()?.frame
        let batXY = batsmen.layer.presentation()?.frame
        balla.frame = ballXY!
        bata.frame = batXY!
        hit = bata.intersects(balla)
        if hit{
            ball.alpha = 0
            hideBall.alpha = 1
            UIView.animate(withDuration: 2,
                           animations: {
                            self.batSound.startOneTimeMusic()
                            self.hideBall.transform = CGAffineTransform( translationX:
                                CGFloat(self.getRandomPosition()*self.selfSize), y: CGFloat(self.getRandomPosition()*self.selfSize))
                            self.batsmen.image = UIImage(named: "batedIcon")
            },
                           completion: { _ in
                            if self.hideBall.frame.origin.x < 0 {
                                self.x = Int(self.hideBall.frame.origin.x*(-1))
                            }else{
                                self.x = Int(self.hideBall.frame.origin.x)
                            }
                            if self.hideBall.frame.origin.y < 0 {
                                self.y = Int(self.hideBall.frame.origin.y*(-1))
                            }else{
                                self.y = Int(self.hideBall.frame.origin.y)
                            }
                            self.marks = 0
                            self.marks = self.x + self.y
                            self.otherRunsLbl.text = ""
                            if UIDevice.current.model == "iPhone"{
                                if self.marks > 11000 {
                                    self.runs += 6
                                    self.sixSound.startOneTimeMusic()
                                    self.sixOrFourImg.image = UIImage(named: "6")
                                    self.sixOrFourImg.isHidden = false
                                    print("6 I")
                                }
                            } else {
                                if self.marks > 22000 {
                                  self.sixSound.startOneTimeMusic()
                                    self.sixOrFourImg.image = UIImage(named: "6")
                                    self.sixOrFourImg.isHidden = false
                                    self.runs += 6
                                 }
                            }
                            if UIDevice.current.model == "iPhone"{
                                if self.marks < 11000 && self.marks >= 7000{
                                    self.runs += 4
                                    self.fourSound.startOneTimeMusic()
                                    self.sixOrFourImg.image = UIImage(named: "4")
                                    self.sixOrFourImg.isHidden = false
                                    print("4")
                                }
                            }else{
                                if self.marks < 22000 && self.marks >= 15000{
                                    self.runs += 4
                                    self.fourSound.startOneTimeMusic()
                                    self.sixOrFourImg.image = UIImage(named: "4")
                                    self.sixOrFourImg.isHidden = false
                                    print("4")
                                }
                            }
                            if UIDevice.current.model == "iPhone"{
                                if self.marks < 7000 && self.marks >= 4000{
                                    self.runs += 3
                                    self.otherRunsLbl.text = "3"
                                }
                            }else{
                                if self.marks < 15000 && self.marks >= 10000{
                                    self.runs += 3
                                    self.otherRunsLbl.text = "3"
                                }
                            }
                            if UIDevice.current.model == "iPhone"{
                                if self.marks < 4000  && self.marks >= 2000{
                                    self.runs += 2
                                    self.otherRunsLbl.text = "2"
                                }
                            }else{
                                if self.marks < 10000  && self.marks >= 6000{
                                    self.runs += 2
                                    self.otherRunsLbl.text = "2"
                                }
                            }
                           if UIDevice.current.model == "iPhone"{
                            if self.marks < 2000  && self.marks >= 500{
                                self.runs += 1
                                self.otherRunsLbl.text = "1"
                            }
                           }else{
                            if self.marks < 6000  && self.marks >= 4000{
                                self.runs += 1
                                self.otherRunsLbl.text = "1"
                            }
                           }
                            if UIDevice.current.model == "iPhone"{
                                if self.marks < 500{
                                    self.runs += 0
                                    self.otherRunsLbl.text = "0"
                                }
                            }else{
                                if self.marks < 3000{
                                    self.runs += 0
                                    self.otherRunsLbl.text = "0"
                                }
                            }
                            self.runsLbl.text = "\(self.runs)"
                            if self.runs > self.myTarget{
                                self.winSound.startOneTimeMusic()
                                var value = self.bet.split{$0 == "$"}.map(String.init)
                                let number: String = value[0]
                                self.myBalance =  self.myBalance + (Double(number)!)
                                self.otherRunsLbl.text = "$"+"\(self.myBalance)"
                                self.userDefaults.set(self.myBalance, forKey: "amount")
                                self.userDefaults.synchronize()
                                self.performSegue(withIdentifier: "winnerIdentifier", sender: nil)
                                self.resetAll()
                                return
                            }
                            if self.runs > self.myTarget && self.team == "Balling Team"{
                                self.outSound.startOneTimeMusic()
                                var value = self.bet.split{$0 == "$"}.map(String.init)
                                let number: String = value[0]
                                self.myBalance =  self.myBalance - (Double(number)!)
                                self.otherRunsLbl.text = "$"+"\(self.myBalance)"
                                self.userDefaults.set(self.myBalance, forKey: "amount")
                                self.userDefaults.synchronize()
                                self.performSegue(withIdentifier: "gameOverIdentifier", sender: nil)
                                self.resetAll()
                                return
                            }
                            if self.oversLbl.text == "20.0" && (self.runs < self.myTarget){
                                self.outSound.startOneTimeMusic()
                                var value = self.bet.split{$0 == "$"}.map(String.init)
                                let number: String = value[0]
                                self.myBalance =  self.myBalance - (Double(number)!)
                                self.otherRunsLbl.text = "$"+"\(self.myBalance)"
                                self.userDefaults.set(self.myBalance, forKey: "amount")
                                self.userDefaults.synchronize()
                                self.performSegue(withIdentifier: "gameOverIdentifier", sender: nil)
                                self.resetAll()
                                return
                            }
                            self.hideBall.transform = CGAffineTransform( translationX:
                                0, y: CGFloat(0))
                            self.hideBall.alpha = 0
                            self.batsmen.image = UIImage(named: "battingIcon")
            })
        }
    }
    func checkOut(){
         if UIDevice.current.model == "iPhone" {
            if ((self.sideView.frame.height/2 - 15) < self.ball.frame.origin.y && (self.sideView.frame.height/2 + 35) > self.ball.frame.origin.y) && hit == false{
                print("OUT..........!")
                outSound.startOneTimeMusic()
                defenceCount = 0
                wickets += 1
                wicketsLbl.text = "\(wickets)"
                if wickets == 10 {
                    var value = self.bet.split{$0 == "$"}.map(String.init)
                    let number: String = value[0]
                    self.myBalance =  self.myBalance - (Double(number)!)
                    self.otherRunsLbl.text = "$"+"\(self.myBalance)"
                    userDefaults.set(self.myBalance, forKey: "amount")
                    userDefaults.synchronize()
                     resetAll()
                    performSegue(withIdentifier: "gameOverIdentifier", sender: nil)
                }
                timer.invalidate()
                defenceBtn.setImage(UIImage(named: "playBtn"), for: .normal)
                performSegue(withIdentifier: "outIdentifier", sender: nil)
            }
         }else{
            if ((self.sideView.frame.height/2 - 25) < self.ball.frame.origin.y && (self.sideView.frame.height/2 + 50) > self.ball.frame.origin.y) && hit == false{
                print("OUT..........!")
                outSound.startOneTimeMusic()
                wickets += 1
                wicketsLbl.text = "\(wickets)"
                defenceCount = 0
                if wickets == 10 {
                    var value = self.bet.split{$0 == "$"}.map(String.init)
                    let number: String = value[0]
                    self.myBalance = self.myBalance - (Double(number)!)
                    self.otherRunsLbl.text = "$"+"\(self.myBalance)"
                    userDefaults.set(self.myBalance, forKey: "amount")
                    userDefaults.synchronize()
                     resetAll()
                    defenceBtn.setImage(UIImage(named: "playBtn"), for: .normal)
                    performSegue(withIdentifier: "gameOverIdentifier", sender: nil)
                }
                timer.invalidate()
                defenceBtn.setImage(UIImage(named: "playBtn"), for: .normal)
                performSegue(withIdentifier: "outIdentifier", sender: nil)
            }
        }
        if self.hit{
            self.hit = false
            ball.alpha = 1
        }
        if userDefaults.double(forKey: "amount") <= 10.0 {
            userDefaults.set(500.0, forKey: "amount")
            userDefaults.synchronize()
        }
    }
    @IBAction func driveAction(_ sender: Any) {
        batBtn.isEnabled = true
        if !foot {
            self.batsmen.frame.origin.x =  self.batsmen.frame.origin.x-30
            foot = true
        }
    }
    @IBAction func cutAction(_ sender: Any) {
        batBtn.isEnabled = true
        self.batsmen.frame.origin.y =  self.batsmen.frame.origin.y-30
        side = "cut"
    }
    @IBAction func pullAction(_ sender: Any) {
        batBtn.isEnabled = true
        self.batsmen.frame.origin.y =  self.batsmen.frame.origin.y+30
        side = "pull"
    }
    @IBAction func backFootAction(_ sender: Any) {
        batBtn.isEnabled = true
        if foot {
            self.batsmen.frame.origin.x =  self.batsmen.frame.origin.x+30
            foot = false
        }
    }
    @IBAction func defenceAction(_ sender: Any) {
        batBtn.isEnabled = true
        defenceCount += 1
        backgroundSound.stopMusic()
        if defenceCount == 1 {
            backgroundSound.startMusic()
            backgroundSound.adjustMusic(Volume: 0.1)
            defenceBtn.setImage(UIImage(named: "stopIcon"), for: .normal)
            timer.invalidate()
            callTimer()
        }else{
           defenceBtn.setImage(UIImage(named: "playBtn"), for: .normal)
           timer.invalidate()
           defenceCount = 0
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "6and4Identifier"{
            let details = segue.destination as! SixFourViewController
            details.value = sender as! String
        }
        if segue.identifier == "winnerIdentifier"{
            let details = segue.destination as! WinnerAlertViewController
            details.delegate = self
            if self.team != ""{
                details.value = bet
            }else{
                details.value = "$0.00"
            }
        }
        if segue.identifier == "gameOverIdentifier"{
            let details = segue.destination as! GameOverViewController
            details.delegate = self
            if userDefaults.double(forKey: "amount") <= 10.0 {
                userDefaults.set(500.0, forKey: "amount")
                userDefaults.synchronize()
            }
        }
    }
}
