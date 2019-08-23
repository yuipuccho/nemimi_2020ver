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

    /// モンスターステータスとりま預かる
    var monster1: [String: Int] = [:]
    var monster2: [String: Int] = [:]
    var monster3: [String: Int] = [:]
    var monster4: [String: Int] = [:]


    /// メインボタンを何回押したかカウント
    var count = 0

    /// たたかうかじゅもんかを選択中だよ
    var selectingAtkType = false

    /// じゅもん選択中だよ
    var selectingMagic = false

    /// じゅもんの番号(0: 通常攻撃, 1: ヒール, 2: ひのたま, 3: つららおとし, 4: しょうげきは, 5: ライトビーム, 6: メガヒール, 7: スターダスト)
    var magicNum = 0

    /// じゅもん使える数
    var magicMaxNum = 0

    /// 攻撃するモンスターを選択中だよ
    var selectingMonster = false

    /// 選択可能なモンスター番号
    var selectableMonster:[Int] = []

    /// モンスター配列番号
    var selectableMonsterNum = 0




    /// 【プレイヤーのパラメータ】
    var player: [String: Any] = [
        "name": "ほげぇ",
        "Lv": 1,    // レベル
        "maxHP": 50,    // 最大HP
        "maxMP": 10,    // 最大MP
        "nowHP": 50,
        "nowMP": 10,
        "atk": 20,    // 攻撃力
        "def": 10,    // 守備力
        "agi": 8,    // すばやさ
        "itemAtk": 0,    // 装備の攻撃力
        "itemDef": 0,    // 装備の守備力
        "exp": 0,    // 経験値
        "gold": 0    // 所持金
    ]


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
        print(monsterName1)
        print(monster1)
        print(monsterName2)
        print(monster2)
        print(monsterName3)
        print(monster3)
        print(monsterName4)
        print(monster4)

        // プレイヤーステータス表示
        hp = player["nowHP"] as! Int
        mp = player["nowMP"] as! Int
        lv = player["Lv"] as! Int

        nameLabel.text = player["name"] as? String
        hpLabel.text = "HP: \(hp)"
        mpLabel.text = "MP: \(mp)"
        lvLabel.text = "Lv: \(lv)"

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

        magicNum = 1    // じゅもん番号を1に
    }




    // 【メインボタン】
    @IBAction func mainButton(_ sender: Any) {

        // 「たたかう」が選択されている時
        if selectAtkLabel.text == "▶︎" {
            selectAtkLabel.text = ""    // 1. たたかう の ▶︎ を消す

            selectMonster()
            selectMonsterImage()    // 2. モンスター選択の▼を表示する処理

            magicNum = 0    // 通常攻撃するよー
            selectingMonster = true    // 3. どのモンスターを攻撃するか選択するフェーズへ
            selectingAtkType = false

        // 「じゅもん」が選択されている時
        } else if selectMatkLabel.text == "▶︎" {
            selectMatkLabel.text = ""    // じゅもんの ▶︎ を消す
            magicSelectView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6510595034)    // じゅもん選択画面の背景を表示する
            selectMagic1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)    // じゅもん1 の ▶︎を表示
            availableMagic()    // 使用可能なじゅもんを表示
            selectingMagic = true    // じゅもん選択のフェーズだよ
            selectingAtkType = false

        // ヒールなど、じゅもん一覧のどれかが選択されている時
        } else if selectingMagic {
            // ここにmagicNum を取得する処理を追加する
            // ヒール、メガヒールを選択していたら遷移
            // performSegue(withIdentifier: "toBattleMessage", sender: nil)    // 画面遷移

            // じゅもん一覧についている ▶︎ を消す
            selectMagic1Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic2Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic3Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic4Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic5Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic6Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic7Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic8Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)

            selectMonster()    // 生存モンスターを配列にぶちこむ
            selectMonsterImage()    // モンスター選択の▼を表示する処理

            selectingMonster = true    // どのモンスターを攻撃するか選択するフェーズへ
            selectingMagic = false

        // 攻撃するモンスターが選択されている時
        } else if selectingMonster {
            performSegue(withIdentifier: "toBattleMessage", sender: nil)    // 画面遷移

        }
    }


    // 上ボタン
    @IBAction func upButton(_ sender: Any) {
        // 【「たたかう」か「じゅもん」を選択するフェーズ】
        if selectingAtkType {
            selectAtkLabel.text = "▶︎"
            selectMatkLabel.text = ""

        // 【じゅもんを選択するフェーズ】
        } else if selectingMagic {
            // じゅもん選択の▶︎を動かすよ〜
            if magicNum - 1 < 1 || magicNum - 1 == 4 {    // これ以上上にいけないとき
                // 何もしない
            } else {    // 上にいけるとき
                magicNum -= 1    // じゅもん番号を -1
                moveSelectMagicIcon()    // じゅもん番号に応じて▶︎を動かす
            }
        }
    }

    // 左ボタン
    @IBAction func leftButton(_ sender: Any) {
        // 【じゅもんを選択するフェーズ】
        if selectingMagic {
            if magicNum - 4 < 1 {    // これ以上左にいけないとき
                // 何もしない
            } else {    // 左にいけるとき
                magicNum -= 4    // じゅもん番号を -4
                moveSelectMagicIcon()    // じゅもん番号に応じて▶︎を動かす
            }
        // 【モンスター選択するフェーズ】
        } else if selectingMonster {
            if selectableMonsterNum - 1 < 0 {    // これ以上左にモンスターいないとき
                // 何もしない
            } else {
                selectableMonsterNum -= 1
                selectMonsterImage()    // 選択モンスターに応じて▼を動かす
            }
        }        
    }

    // 右ボタン
    @IBAction func rightButton(_ sender: Any) {
        // 【じゅもんを選択するフェーズ】
        if selectingMagic {
            if magicNum + 4 > magicMaxNum {    // これ以上右にいけないとき
                // 何もしない
            } else {    // 右にいけるとき
                magicNum += 4    // じゅもん番号を +4
                moveSelectMagicIcon()    // じゅもん番号に応じて▶︎を動かす
            }

        // 【モンスター選択するフェーズ】
        } else if selectingMonster {
            if selectableMonsterNum + 1 >= selectableMonster.count {    // これ以上右にモンスターいないとき
                // 何もしない
            } else {
                selectableMonsterNum += 1
                selectMonsterImage()    // 選択モンスターに応じて▼を動かす
                print(selectableMonster)
            }
        }
    }

    // 下ボタン
    @IBAction func downButton(_ sender: Any) {
        // 【「たたかう」か「じゅもん」を選択するフェーズ】
        if selectingAtkType {
            selectAtkLabel.text = ""
            selectMatkLabel.text = "▶︎"

        // 【じゅもんを選択するフェーズ】
        } else if selectingMagic {
            if magicNum + 1 > magicMaxNum || magicNum + 1 == 5 {    // これ以上下にいけないとき
                // 何もしない
            } else {
                magicNum += 1
                moveSelectMagicIcon()    // じゅもん番号に応じて▶︎を動かす
            }
        }
    }



    // 生存モンスターを配列にぶちこむ処理
    func selectMonster() {
        if monsterName1 != "" {

        //if monster1["hp"]! > 0 {
            selectableMonster.append(1)
        }
        if monsterName2 != "" {
        //if monster2["hp"]! > 0 {
            selectableMonster.append(2)
        }
        if monsterName3 != "" {
        //if monster3["hp"]! > 0 {
            selectableMonster.append(3)
        }
        if monsterName4 != "" {
        //if monster4["hp"]! > 0 {
            selectableMonster.append(4)
        }
    }

    func selectMonsterImage() {
        switch selectableMonster[selectableMonsterNum] {
        case 1:
            selectMonsterImage1Label.text = "▼"    // モンスター1選択の▼を出す
            selectMonsterImage2Label.text = ""    // モンスター2選択の▼を消す
            selectMonsterImage3Label.text = ""    // モンスター3選択の▼を消す
            selectMonsterImage4Label.text = ""    // モンスター4選択の▼を消す
        case 2:
            selectMonsterImage2Label.text = "▼"    // モンスター2選択の▼を出す
            selectMonsterImage1Label.text = ""    // モンスター1選択の▼を消す
            selectMonsterImage3Label.text = ""    // モンスター3選択の▼を消す
            selectMonsterImage4Label.text = ""    // モンスター4選択の▼を消す

        case 3:
            selectMonsterImage3Label.text = "▼"    // モンスター3選択の▼を出す
            selectMonsterImage1Label.text = ""    // モンスター1選択の▼を消す
            selectMonsterImage2Label.text = ""    // モンスター2選択の▼を消す
            selectMonsterImage4Label.text = ""    // モンスター4選択の▼を消す
        case 4:
            selectMonsterImage4Label.text = "▼"    // モンスター4選択の▼を出す
            selectMonsterImage1Label.text = ""    // モンスター1選択の▼を消す
            selectMonsterImage2Label.text = ""    // モンスター2選択の▼を消す
            selectMonsterImage3Label.text = ""    // モンスター3選択の▼を消す

        default:
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
        switch lv {
        case 1..<5:
            magic1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magicMaxNum = 1
        case 5..<10:
            magic1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic2Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magicMaxNum = 2
        case 10..<16:
            magic1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic2Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic3Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magicMaxNum = 3
        case 16..<20:
            magic1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic2Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic3Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic4Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magicMaxNum = 4
        case 20..<23:
            magic1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic2Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic3Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic4Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic5Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magicMaxNum = 5
        case 23..<28:
            magic1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic2Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic3Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic4Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic5Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic6Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magicMaxNum = 6
        case 28..<100:
            magic1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic2Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic3Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic4Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic5Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic6Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magic7Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            magicMaxNum = 7
        default:
            return
        }
    }

    // じゅもん選択処理
    func moveSelectMagicIcon() {
        switch magicNum {
        case 1:
            selectMagic1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            selectMagic2Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic3Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic4Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic5Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic6Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic7Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)

        case 2:
            selectMagic1Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic2Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            selectMagic3Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic4Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic5Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic6Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic7Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)

        case 3:
            selectMagic1Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic2Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic3Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            selectMagic4Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic5Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic6Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic7Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)

        case 4:
            selectMagic1Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic2Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic3Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic4Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            selectMagic5Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic6Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic7Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)

        case 5:
            selectMagic1Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic2Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic3Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic4Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic5Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            selectMagic6Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic7Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)

        case 6:
            selectMagic1Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic2Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic3Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic4Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic5Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic6Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            selectMagic7Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)

        case 7:
            selectMagic1Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic2Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic3Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic4Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic5Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic6Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            selectMagic7Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        default: return
        }
    }






    // segue遷移前動作
    // セグエ実行前処理 / セグエの identifier 確認 / 遷移先ViewController の取得
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toBattleMessage", let vc = segue.destination as? battleMessageViewController else {
            return
        }


        // 向こうに返す情報は
        // プレイヤー情報
        vc.name = player["name"] as! String
        vc.player["nowHP"] = player["nowHP"]
        vc.player["nowMP"] = player["nowMP"]
        vc.player["Lv"] = player["Lv"]


        // モンスター情報
        //if monsterName1 != "" {
            vc.monsterName1 = monsterName1
            vc.monster1 = monster1
            print(monsterName1)
            print(monster1)

        //} else if monsterName2 != "" {
            print(monsterName2)
            vc.monsterName2 = monsterName2
            vc.monster2 = monster2
            print(monster2)

        //} else if monsterName3 != "" {
            vc.monsterName3 = monsterName3
            vc.monster3 = monster3
            print(monsterName3)
            print(monster3)

        //} else if monsterName4 != "" {
            vc.monsterName4 = monsterName4
            vc.monster4 = monster4
            print(monsterName4)
            print(monster4)
        //}
        // どのモンスターに対して攻撃タイプを選択したか
        vc.magicNum = magicNum
        print(magicNum)

    }
}
