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
    var lv = 30

    /// モンスター名前
    var monsterName1 = ""
    var monsterName2 = ""
    var monsterName3 = ""
    var monsterName4 = ""


    /// メインボタンを何回押したかカウント
    var count = 0

    /// たたかうかじゅもんかを選択中だよ
    var selectingAtkType = false

    /// じゅもん選択中だよ
    var selectingMagic = false

    /// 攻撃するモンスターを選択中だよ
    var selectingMonster = false


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
        selectMagic1Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        selectMagic2Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        selectMagic3Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        selectMagic4Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        selectMagic5Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        selectMagic6Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        selectMagic7Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        selectMagic8Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        magic1Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        magic2Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        magic3Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        magic4Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        magic5Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        magic6Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        magic7Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        magic8Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)

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

        selectingAtkType = true    // たたかうかじゅもんか選ぶよ〜
    }




    // 【メインボタン】
    @IBAction func mainButton(_ sender: Any) {

        // 「たたかう」が選択されている時
        if selectAtkLabel.text == "▶︎" {
            selectAtkLabel.text = ""    // 1. たたかう の ▶︎ を消す
            selectMonsterImage()    // 2. モンスター選択の▼を表示する処理
            selectingMonster = true    // 3. どのモンスターを攻撃するか選択するフェーズへ
            selectingAtkType = false

        // 「じゅもん」が選択されている時
        } else if selectMatkLabel.text == "▶︎" {
            selectMatkLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)    // じゅもんの ▶︎ を消す
            magicSelectView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6510595034)    // じゅもん選択画面の背景を表示する
            selectMagic1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)    // じゅもん1 の ▶︎を表示
            availableMagic()    // 使用可能なじゅもんを表示
            selectingMagic = true    // じゅもん選択のフェーズだよ
            selectingAtkType = false

        // ヒールなど、じゅもん一覧のどれかが選択されている時
        } else if selectMagic1Label.textColor == #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) {    // ヒールが選択されてる
            // ヒールを選択したよって処理を入れる
            selectMagic1Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)    // ▶︎を消す
            selectMonsterImage()    // モンスター選択の▼を表示する処理
            selectingMonster = true    // こうげきするモンスター選択のフェーズだよ
            selectingMagic = false


        } else if selectMagic2Label.textColor == #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) {

        } else if selectMagic3Label.textColor == #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) {

        } else if selectMagic4Label.textColor == #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) {

        } else if selectMagic5Label.textColor == #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) {

        } else if selectMagic6Label.textColor == #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) {

        } else if selectMagic7Label.textColor == #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) {

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


    // 3. モンスター選択の▼を表示する処理
    func selectMonsterImage() {
        if monsterName1 != "" {    // モンスター1がいるなら
            selectMonsterImage1Label.text = "▼"    // モンスター1選択の▼を出す
        } else if monsterName1 == "" && monsterName2 != "" {    // モンスター1がいなくてモンスター2がいるなら
            selectMonsterImage2Label.text = "▼"    // モンスター2選択の▼を出す
        } else if monsterName1 == "" && monsterName2 == "" && monsterName3 != "" {    // モンスター1,2がいなくてモンスター3がいるなら
            selectMonsterImage3Label.text = "▼"    // モンスター3選択の▼を出す
        } else if monsterName1 == "" && monsterName2 == "" && monsterName3 == "" && monsterName4 != "" {
            selectMonsterImage4Label.text = "▼"    // モンスター3選択の▼を出す
        } else {
            return
        }
    }

    // 1 ヒール
    // 5 ひのたま
    // 10 つららおとし
    // 16 しょうげきは
    // 20 ライトビーム
    // 23 メガヒール
    // 28 スターダスト

    // じゅもん表示処理 残りMPによって色を変える処理も追加したい
    func availableMagic() {
        lv = 30
        switch lv {
        case 1..<5:
            magic1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case 5..<10:
            magic1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic2Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case 10..<16:
            magic1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic2Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic3Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case 16..<20:
            magic1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic2Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic3Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic4Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case 20..<23:
            magic1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic2Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic3Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic4Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic5Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case 23..<28:
            magic1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic2Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic3Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic4Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic5Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic6Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case 28..<100:
            magic1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic2Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic3Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic4Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic5Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic6Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic7Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
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
