//
//  battleCommandViewController.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2019/08/20.
//  Copyright © 2019 吉澤優衣. All rights reserved.
//

import UIKit

class battleCommandViewController: UIViewController {

    var name = ""
    var hp = 0
    var mp = 0
    var lv = 0

    /// モンスター名前
    var monsterName1 = ""
    var monsterName2 = ""
    var monsterName3 = ""
    var monsterName4 = ""


    // メインボタンを何回押したかカウント
    var count = 0


    @IBOutlet weak var nameLabel: UILabel!    // プレイヤーの名前
    @IBOutlet weak var hpLabel: UILabel!    // hp
    @IBOutlet weak var mpLabel: UILabel!    //mp
    @IBOutlet weak var lvLabel: UILabel!    // Lv

    @IBOutlet weak var selectAtkLabel: UILabel!    // たたかう を選択したときの▶︎
    @IBOutlet weak var selectMatkLabel: UILabel!    // じゅもん を選択したときの▶︎

    @IBOutlet weak var magicSelectView: UIView!    // 呪文一覧のView

    @IBOutlet weak var selectMagic1Label: UILabel!    // じゅもん1 を選択したときの▶︎
    @IBOutlet weak var selectMagic2Label: UILabel!    // じゅもん2 を選択したときの▶︎
    @IBOutlet weak var selectMagic3Label: UILabel!    // じゅもん3 を選択したときの▶︎
    @IBOutlet weak var selectMagic4Label: UILabel!    // じゅもん4 を選択したときの▶︎
    @IBOutlet weak var selectMagic5Label: UILabel!    // じゅもん5 を選択したときの▶︎
    @IBOutlet weak var selectMagic6Label: UILabel!    // じゅもん6 を選択したときの▶︎
    @IBOutlet weak var selectMagic7Label: UILabel!    // じゅもん7 を選択したときの▶︎
    @IBOutlet weak var selectMagic8Label: UILabel!    // じゅもん8 を選択したときの▶︎


    @IBOutlet weak var magic1Label: UILabel!    // じゅもん1
    @IBOutlet weak var magic2Label: UILabel!    // じゅもん2
    @IBOutlet weak var magic3Label: UILabel!    // じゅもん3
    @IBOutlet weak var magic4Label: UILabel!    // じゅもん4
    @IBOutlet weak var magic5Label: UILabel!    // じゅもん5
    @IBOutlet weak var magic6Label: UILabel!    // じゅもん6
    @IBOutlet weak var magic7Label: UILabel!    // じゅもん7
    @IBOutlet weak var magic8Label: UILabel!    // じゅもん8


    @IBOutlet weak var monsterImage1: UIImageView!    // モンスター画像1
    @IBOutlet weak var monsterImage2: UIImageView!    // モンスター画像2
    @IBOutlet weak var monsterImage3: UIImageView!    // モンスター画像3
    @IBOutlet weak var monsterImage4: UIImageView!    // モンスター画像4


    @IBOutlet weak var selectMonsterImage1Label: UILabel!    // モンスター画像1 を選択したときの▶︎
    @IBOutlet weak var selectMonsterImage2Label: UILabel!    // モンスター画像2 を選択したときの▶︎
    @IBOutlet weak var selectMonsterImage3Label: UILabel!    // モンスター画像3 を選択したときの▶︎
    @IBOutlet weak var selectMonsterImage4Label: UILabel!    // モンスター画像4 を選択したときの▶︎


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        // 最初の画面なのでじゅもん一覧とかいらんやつを消す
        // じゅもん系
        magicSelectView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)    // 背景を透明に
        selectMagic1Label.text = ""
        selectMagic2Label.text = ""
        selectMagic3Label.text = ""
        selectMagic4Label.text = ""
        selectMagic5Label.text = ""
        selectMagic6Label.text = ""
        selectMagic7Label.text = ""
        selectMagic8Label.text = ""
        magic1Label.text = ""
        magic2Label.text = ""
        magic3Label.text = ""
        magic4Label.text = ""
        magic5Label.text = ""
        magic6Label.text = ""
        magic7Label.text = ""
        magic8Label.text = ""

        selectMatkLabel.text = ""

        // モンスター選択の▼
        selectMonsterImage1Label.text = ""
        selectMonsterImage2Label.text = ""
        selectMonsterImage3Label.text = ""
        selectMonsterImage4Label.text = ""


        // モンスター画像表示
        if monsterName1 == "" {    // モンスター1がいなかったら
            // 画像を消す
            monsterImage1.image = UIImage(named: "透明")
            monsterImage1.alpha = 0
        } else {    // モンスター1がいたら
            // 画像を表示
            monsterImage1.image = UIImage(named: "\(monsterName1)")
        }

        if monsterName2 == "" {
            monsterImage2.image = UIImage(named: "透明")
            monsterImage2.alpha = 0
        } else {
            monsterImage2.image = UIImage(named: "\(monsterName2)")
        }

        if monsterName3 == "" {
            monsterImage3.image = UIImage(named: "透明")
            monsterImage3.alpha = 0
        } else {
            monsterImage3.image = UIImage(named: "\(monsterName3)")
        }

        if monsterName4 == "" {
            monsterImage4.image = UIImage(named: "透明")
            monsterImage4.alpha = 0
        } else {
            monsterImage4.image = UIImage(named: "\(monsterName4)")
        }
    }


    @IBAction func mainButton(_ sender: Any) {
        count += 1

        switch selectAtkLabel.text {
        case "▶︎":
            count += 1    // どのモンスターを攻撃するか選択するフェーズへ
            selectMonsterImage1Label.text = "▼"
        default:
            return
        }
    }


    @IBAction func upButton(_ sender: Any) {
        switch count {
        case 0:    // 「たたかう」か「じゅもん」を選択するフェーズ
            selectAtkLabel.text = "▶︎"
            selectMatkLabel.text = ""
        default:
            return
        }
    }


    @IBAction func leftButton(_ sender: Any) {
        
    }


    @IBAction func rightButton(_ sender: Any) {
    }


    @IBAction func downButton(_ sender: Any) {
        switch count {
        case 0:    // 「たたかう」か「じゅもん」を選択するフェーズ
            selectAtkLabel.text = ""
            selectMatkLabel.text = "▶︎"
        default:
            return
        }
    }



    // segue遷移前動作
    // セグエ実行前処理 / セグエの identifier 確認 / 遷移先ViewController の取得
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toBattleMessage", let vc = segue.destination as? battleMessageViewController else {
            return
        }

        // 向こうに返す情報は
        // どの攻撃タイプを選択したか

    }
}
