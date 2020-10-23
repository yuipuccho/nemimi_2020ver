//
//  battleCommandViewController.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2019/08/20.
//  Copyright © 2019 吉澤優衣. All rights reserved.
//

import UIKit

class battleCommandViewController: UIViewController {

    // 遷移元マップ情報
    var toCave1: Bool = false
    var toCave2: Bool = false
    var toCave3: Bool = false
    var toCave4: Bool = false
    var toCave5: Bool = false
    var toCave6: Bool = false
    var toCave7: Bool = false
    var toCave8: Bool = false
    var toCave9: Bool = false

    // プレイヤー座標
    var playerLeftLocation: CGFloat = 0

    var playerOverLocation: CGFloat = 0

    var playerApperImage = ""


    var currentNum = 0

    var playerName = ""
    var playerHP = 0
    var playerMP = 0
    var playerLv = 0

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

    // ハーミット討伐済かどうか
    var defeatHermit: Bool = false


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

    /// MP不足で使えないじゅもんを格納
    var notAvailableMagicNum: [Int] = []

    /// 攻撃するモンスターを選択中だよ
    var selectingMonster = false

    /// 選択可能なモンスター番号
    var selectableMonster:[Int] = []

    /// モンスター番号
    var selectMonsterNum = 0

    /// 獲得経験値
    var allExp = 0




    /// 【プレイヤーのパラメータ】
    var player: [String: Any] = [:]


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
        playerHP = player["nowHP"] as! Int
        playerMP = player["nowMP"] as! Int
        playerLv = player["Lv"] as! Int

        nameLabel.text = player["name"] as? String
        hpLabel.text = "HP: \(playerHP)"
        mpLabel.text = "MP: \(playerMP)"
        lvLabel.text = "Lv: \(playerLv)"

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
        if monster1["hp"]! <= 0 {    // モンスター1がいなかったら
            // 画像を消す
            monsterImage1.image = UIImage(named: "透明")    // 適当に画像いれてるだけ
            monsterImage1.alpha = 0    // ここで透明にしてる
        } else {    // モンスター1がいたら
            // 画像を表示
            monsterImage1.image = UIImage(named: "\(monsterName1)")
        }

        if monster2["hp"]! <= 0 {
            monsterImage2.image = UIImage(named: "透明")
            monsterImage2.alpha = 0
        } else {
            monsterImage2.image = UIImage(named: "\(monsterName2)")
        }

        if monster3["hp"]! <= 0 {
            monsterImage3.image = UIImage(named: "透明")
            monsterImage3.alpha = 0
        } else {
            monsterImage3.image = UIImage(named: "\(monsterName3)")
        }

        if monster4["hp"]! <= 0 {
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
            print("ここはおけ")

            // ヒールなど、じゅもん一覧のどれかが選択されている時
        } else if selectingMagic {
            // ここにmagicNum を取得する処理を追加する
            print("magicNum")
            print(magicNum)
            // MPたりなかったら処理を抜ける
            if notAvailableMagicNum.contains(magicNum){
                return
            }
            // ヒール、メガヒールを選択していたら遷移
            if magicNum == 1 || magicNum == 6 {
                print("kokodayone")
                performSegue(withIdentifier: "toBattleMessage", sender: nil)    // 画面遷移

            } else {

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
            }

            // 攻撃するモンスターが選択されている時
        } else if selectingMonster {
            performSegue(withIdentifier: "toBattleMessage", sender: nil)    // 画面遷移
            print("バトルメッセージに遷移")

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
            if selectMonsterNum - 1 < 0 {    // これ以上左にモンスターいないとき
                // 何もしない
            } else {
                selectMonsterNum -= 1
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
            if selectMonsterNum + 1 >= selectableMonster.count {    // これ以上右にモンスターいないとき
                // 何もしない
            } else {
                selectMonsterNum += 1
                selectMonsterImage()    // 選択モンスターに応じて▼を動かす

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


    // 戻るボタン
    @IBAction func backButton(_ sender: Any) {
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

        count = 0
        selectingAtkType = true
        selectingMagic = false
        magicNum = 1
        magicMaxNum = 0
        notAvailableMagicNum = []
        selectingMonster = false
        selectAtkLabel.text = "▶︎"
        selectableMonster = []
        selectMonsterNum = 0

    }
    

    // 生存モンスターを配列にぶちこむ処理
    func selectMonster() {

        if monster1["hp"]! > 0 {
            selectableMonster.append(1)
        }
        if monster2["hp"]! > 0 {
            selectableMonster.append(2)
        }
        if monster3["hp"]! > 0 {
            selectableMonster.append(3)
        }
        if monster4["hp"]! > 0 {
            selectableMonster.append(4)
        }
    }

    // モンスター選択の時の▼の表示処理
    func selectMonsterImage() {
        switch selectableMonster[selectMonsterNum] {
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
        switch playerLv {
        case 1..<5:    // ヒール lv: 1, MP: -3
            checkMagic1()    // 残りMPによって処理を変える
            magicMaxNum = 1
        case 5..<10:    // ひのたま lv: 5, MP: -2
            checkMagic1()
            checkMagic2()
            magicMaxNum = 2
        case 10..<16:    // つららおとし lv: 10, MP: -4
            checkMagic1()
            checkMagic2()
            checkMagic3()
            magicMaxNum = 3
        case 16..<20:    // しょうげきは lv: 16, MP: -5
            checkMagic1()
            checkMagic2()
            checkMagic3()
            checkMagic4()
            magicMaxNum = 4
        case 20..<23:    // ライトビーム lv: 20, MP: -8
            checkMagic1()
            checkMagic2()
            checkMagic3()
            checkMagic4()
            checkMagic5()
            magicMaxNum = 5
        case 23..<28:    // メガヒール lv: 23, MP: -6
            checkMagic1()
            checkMagic2()
            checkMagic3()
            checkMagic4()
            checkMagic5()
            checkMagic6()
            magicMaxNum = 6
        case 28..<100:    // スターダスト lv: 28, MP: -13
            checkMagic1()
            checkMagic2()
            checkMagic3()
            checkMagic4()
            checkMagic5()
            checkMagic6()
            checkMagic7()
            magicMaxNum = 7
        default:
            return
        }
    }

    // 残りMPごとのじゅもん選択処理
    func checkMagic1() {
        if playerMP < 3 {
            magic1Label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            notAvailableMagicNum.append(1)
        } else {
            magic1Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    func checkMagic2() {
        if playerMP < 2 {
            magic2Label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            notAvailableMagicNum.append(2)
        } else {
            magic2Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    func checkMagic3() {
        if playerMP < 4 {
            magic3Label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            notAvailableMagicNum.append(3)
        } else {
            magic3Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    func checkMagic4() {
        if playerMP < 5 {
            magic4Label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            notAvailableMagicNum.append(4)
        } else {
            magic4Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    func checkMagic5() {
        if playerMP < 8 {
            magic5Label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            notAvailableMagicNum.append(5)
        } else {
            magic5Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    func checkMagic6() {
        if playerMP < 6 {
            magic6Label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            notAvailableMagicNum.append(6)
        } else {
            magic6Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    func checkMagic7() {
        if playerMP < 13 {
            magic7Label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            notAvailableMagicNum.append(7)
        } else {
            magic7Label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
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
        vc.player = player


        // モンスター情報
        // モンスター1
        vc.monsterName1 = monsterName1
        vc.monster1 = monster1
        print(monsterName1)
        print(monster1)
        // モンスター2
        print(monsterName2)
        vc.monsterName2 = monsterName2
        vc.monster2 = monster2
        print(monster2)
        // モンスター3
        vc.monsterName3 = monsterName3
        vc.monster3 = monster3
        print(monsterName3)
        print(monster3)
        // モンスター4
        vc.monsterName4 = monsterName4
        vc.monster4 = monster4
        print(monsterName4)
        print(monster4)

        // どのモンスターに対して攻撃タイプを選択したか
        vc.magicNum = magicNum    // 攻撃タイプ

        if magicNum != 1 && magicNum != 6 {
            vc.selectMonsterNum = selectableMonster[selectMonsterNum]   // どのモンスターか
        }

        // プレイヤー攻撃の処理を呼ぶ
        vc.toPlayerAtk = true

        // 経験値
        vc.allExp = allExp

        // 遷移元マップ情報
        vc.toCave1 = toCave1
        vc.toCave2 = toCave2
        vc.toCave3 = toCave3
        vc.toCave4 = toCave4
        vc.toCave5 = toCave5
        vc.toCave6 = toCave6
        vc.toCave7 = toCave7
        vc.toCave8 = toCave8
        vc.toCave9 = toCave9

        vc.playerLeftLocation = playerLeftLocation
        vc.playerOverLocation = playerOverLocation

        vc.playerApperImage = playerApperImage
        
        vc.currentNum = currentNum
        // ハーミット討伐済かどうか
        vc.defeatHermit = defeatHermit

    }
}
