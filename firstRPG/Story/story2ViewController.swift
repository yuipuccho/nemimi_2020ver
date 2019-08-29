//
//  story2ViewController.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2019/08/29.
//  Copyright © 2019 吉澤優衣. All rights reserved.
//

import UIKit

class story2ViewController: UIViewController {
    
    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var kingImage: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var selectView: UIView!
    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var selectYes: UILabel!
    @IBOutlet weak var selectNo: UILabel!


    var count = 0
    var button = false
    var select = false
    
    var player:[String: Any] = [
        "name": "ほげぇ",
        "Lv": 1,    // レベル
        "maxHP": 24,    // 最大HP
        "maxMP": 10,    // 最大MP
        "nowHP": 24,
        "nowMP": 10,
        "atk": 12,    // 攻撃力
        "def": 15,    // 守備力
        "exp": 0,    // 経験値
    ]
    
    //var player: [String: Any] = ["name": "ほげぇ", "maxHP": 222, "maxMP": 130, "atk": 208, "def": 4000, "nowHP": 222, "nowMP": 130, "exp":35000, "Lv": 30]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kingImage.isHidden = true
        textView.isHidden = true
        selectView.isHidden = true
        yesLabel.isHidden = true
        noLabel.isHidden = true
        selectYes.isHidden = true
        selectNo.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.textView.isHidden = false    // メッセージ表示
            self.textView.text = "ほげぇよ......。"
            self.button = true
            
        }
    }
    
    
    @IBAction func mainButton(_ sender: Any) {
        if button == true {
            switch count {
            case 0:
                count += 1
                kingImage.isHidden = false    // 王様登場
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.textView.text = "王「ほげぇよ。」"
                }
            case 1:
                count += 1
                textView.text = "王「ねていたところ すまんの。」"
            case 2:
                count += 1
                textView.text = "王「じつは わしの姫が\n さらわれてしまったんじゃ。」"
            case 3:
                count += 1
                textView.text = "王「たすけにいってくれるな？」"

            case 4:
                count += 1
                self.selectView.isHidden = false    // 選択背景だす
                self.yesLabel.isHidden = false    // はい
                self.noLabel.isHidden = false    // いいえ
                self.selectYes.isHidden = false
                self.selectYes.text = "▶︎"
                self.selectNo.isHidden = false
                self.selectNo.text = ""

                self.select = true

            case 5:    // どっちか選択してる状態
                selectView.isHidden = true
                yesLabel.isHidden = true
                noLabel.isHidden = true
                selectYes.isHidden = true
                selectNo.isHidden = true
                select = false

                if selectYes.text == "▶︎" {    // はい
                    count += 1    // 先に進む
                    textView.text = "王「そうか。いってくれると もうすか。」"

                } else {
                    count -= 2
                    textView.text = "王「なんと。\n まあ そんなことはいわずに。」"
                }


            case 6:
                count += 1
                textView.text = "王「姫がさらわれた洞窟までは\n わしが 送りとどけよう。」"
            case 7:
                count += 1
                textView.text = "王「あとは たのんだぞ！」"
            case 8:
                performSegue(withIdentifier: "toCave1", sender: nil)
            default:
                return
            }
        }
    }

    @IBAction func upButton(_ sender: Any) {
        if select == true {
            selectYes.text = "▶︎"
            selectNo.text = ""
        }

    }

    @IBAction func downButton(_ sender: Any) {
        if select == true {
            selectYes.text = ""
            selectNo.text = "▶︎"
        }
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "toCave1") {
            let vc: cave1ViewController = (segue.destination as? cave1ViewController)!
            
            vc.player = player
            let width = view.frame.size.width - gameView.frame.size.width
            let height = view.frame.size.height - gameView.frame.size.height
            let plusWidth = width / 2
            let plusHeight = height / 2
            
            vc.playerLeftLocation = gameView.frame.size.width / 21 * 10 + plusWidth
            vc.playerOverLocation = gameView.frame.size.height / 12 * 11 + plusHeight
            
            vc.playerApperImage = "ヒーロー上1"
        }
    }
    
}
