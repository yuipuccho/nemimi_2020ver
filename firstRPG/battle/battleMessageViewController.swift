//
//  battleSceneViewController.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2019/08/20.
//  Copyright © 2019 吉澤優衣. All rights reserved.
//

import UIKit


class battleMessageViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!    // プレイヤーの名前
    @IBOutlet weak var hpLabel: UILabel!    // HP
    @IBOutlet weak var mpLabel: UILabel!    // MP
    @IBOutlet weak var lvLabel: UILabel!    // Lv
    
    @IBOutlet weak var monsterImage1: UIImageView!    // モンスター画像
    @IBOutlet weak var monsterImage2: UIImageView!
    @IBOutlet weak var monsterImage3: UIImageView!
    @IBOutlet weak var monsterImage4: UIImageView!
    
    @IBOutlet weak var messageTextView: UITextView!    // バトルメッセージ

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


    // 遷移元プレイヤー座標
    var playerLeftLocation: CGFloat = 0

    var playerOverLocation: CGFloat = 0
    

    var currentNum = 0

    var playerName = ""
    var playerHP = 0
    var playerMP = 0
    var playerLv = 0
    var exp = 0
    
    
    /// どのモンスターとエンカウントしたかの情報を受け取る
    var monster:[Int] = []    // [0, 0] ならスライム2匹とエンカウント
    
    /// モンスター名前
    var monsterName1 = ""
    var monsterName2 = ""
    var monsterName3 = ""
    var monsterName4 = ""
    
    
    /// モンスターステータス
    var monster1: [String: Int] = [:]
    var monster2: [String: Int] = [:]
    var monster3: [String: Int] = [:]
    var monster4: [String: Int] = [:]
    
    /// どんな攻撃をするか管理
    var magicNum = 0
    
    /// どのモンスターに攻撃するか。配列番号。0ならモンスター1を攻撃。
    var selectMonsterNum = 0
    
    /// ターゲットにしたモンスターのステータスをいれる
    var targetMonster: [String: Int] = [:]
    
    /// ターゲットにしたモンスターの名前をいれる
    var targetMonsterName = ""
    
    /// 使用したじゅもんの名前を入れる
    var magicName = ""
    
    /// 与ダメージ
    var giveDamage = 0
    
    /// 被ダメージ
    var takeDamage = 0
    
    /// 獲得経験値
    var allExp = 0
    
    
    /// メインボタンを押した時にバトルコマンド画面に遷移するかどうか判断（バトルまだ続くよ〜）
    var toBattleCommand: Bool = false
    
    /// メインボタンを押した時にマップに画面遷移するかどうか判断（バトル終わってマップに戻るよ〜）
    var toBack: Bool = false
    
    /// メインボタンを押した時に最初に画面繊維するかどうか判断（プレイヤー死んじゃったよ〜）
    var toRestart: Bool = false
    
    /// プレイヤー死亡時のテキストになるかどうか判断
    var toPlayerDie: Bool = false
    
    /// メインボタンを押した時にモンスターの攻撃のテキストになるかどうか判断（次モンスターの攻撃のターンだよ〜）
    var toMonsterAtk: Bool = false
    
    /// メインボタンを押した時にバトル終了のテキストになるかどうか判断（バトル終了のテキストだすよ〜）
    var toFinishBattle: Bool = false
    
    /// モンスター出現処理を呼ぶ
    var toMonsterApper: Bool = false
    
    /// プレイヤー攻撃処理を呼ぶ
    var toPlayerAtk: Bool = false
    
    
    /// 生存モンスター数カウントに使う
    var monsterCount = 0
    
    /// メインボタン押した数のカウントに使う
    var count = 0
    
    /// モンスターから攻撃を受けた時のバトルメッセージをとりま格納する配列
    var monsterAtkMessage: [String] = []
    
    /// モンスターから攻撃を受けた時のhpをとりま格納する配列
    var monsterAtkHP: [String] = []
    
    
    /// 【プレイヤーのパラメータ】
    var player: [String: Any] = [:]

    /// プレイヤーレベルごとステータス
    let lv2: [String: Any] = ["name": "ほげぇ", "maxHP": 30, "maxMP": 12, "atk": 14, "def": 17, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 2]
    let lv3: [String: Any] = ["name": "ほげぇ", "maxHP": 36, "maxMP": 14, "atk": 16, "def": 20, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 3]
    let lv4: [String: Any] = ["name": "ほげぇ", "maxHP": 42, "maxMP": 16, "atk": 18, "def": 24, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 4]
    let lv5: [String: Any] = ["name": "ほげぇ", "maxHP": 48, "maxMP": 18, "atk": 20, "def": 28, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 5]
    let lv6: [String: Any] = ["name": "ほげぇ", "maxHP": 54, "maxMP": 20, "atk": 22, "def": 34, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 6]
    let lv7: [String: Any] = ["name": "ほげぇ", "maxHP": 60, "maxMP": 23, "atk": 25, "def": 40, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 7]
    let lv8: [String: Any] = ["name": "ほげぇ", "maxHP": 66, "maxMP": 25, "atk": 26, "def": 50, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 8]
    let lv9: [String: Any] = ["name": "ほげぇ", "maxHP": 72, "maxMP": 27, "atk": 28, "def": 60, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 9]
    let lv10: [String: Any] = ["name": "ほげぇ", "maxHP": 79, "maxMP": 30, "atk": 31, "def": 80, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 10]
    let lv11: [String: Any] = ["name": "ほげぇ", "maxHP": 86, "maxMP": 34, "atk": 34, "def": 100, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 11]
    let lv12: [String: Any] = ["name": "ほげぇ", "maxHP": 93, "maxMP": 38, "atk": 38, "def": 120, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 12]
    let lv13: [String: Any] = ["name": "ほげぇ", "maxHP": 100, "maxMP": 42, "atk": 43, "def": 150, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 13]
    let lv14: [String: Any] = ["name": "ほげぇ", "maxHP": 107, "maxMP": 46, "atk": 48, "def": 170, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 14]
    let lv15: [String: Any] = ["name": "ほげぇ", "maxHP": 114, "maxMP": 50, "atk": 53, "def": 200, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 15]
    let lv16: [String: Any] = ["name": "ほげぇ", "maxHP": 121, "maxMP": 55, "atk": 58, "def": 250, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 16]
    let lv17: [String: Any] = ["name": "ほげぇ", "maxHP": 128, "maxMP": 60, "atk": 60, "def": 300, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 17]
    let lv18: [String: Any] = ["name": "ほげぇ", "maxHP": 135, "maxMP": 65, "atk": 66, "def": 350, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 18]
    let lv19: [String: Any] = ["name": "ほげぇ", "maxHP": 142, "maxMP": 70, "atk": 72, "def": 420, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 19]
    let lv20: [String: Any] = ["name": "ほげぇ", "maxHP": 150, "maxMP": 80, "atk": 80, "def": 520, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 20]
    let lv21: [String: Any] = ["name": "ほげぇ", "maxHP": 157, "maxMP": 85, "atk": 88, "def": 620, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 21]
    let lv22: [String: Any] = ["name": "ほげぇ", "maxHP": 163, "maxMP": 90, "atk": 96, "def": 700, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 22]
    let lv23: [String: Any] = ["name": "ほげぇ", "maxHP": 170, "maxMP": 95, "atk": 104, "def": 800, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 23]
    let lv24: [String: Any] = ["name": "ほげぇ", "maxHP": 177, "maxMP": 100, "atk": 112, "def": 950, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 24]
    let lv25: [String: Any] = ["name": "ほげぇ", "maxHP": 285, "maxMP": 105, "atk": 122, "def": 1200, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 25]
    let lv26: [String: Any] = ["name": "ほげぇ", "maxHP": 192, "maxMP": 110, "atk": 136, "def": 1500, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 26]
    let lv27: [String: Any] = ["name": "ほげぇ", "maxHP": 200, "maxMP": 115, "atk": 150, "def": 1800, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 27]
    let lv28: [String: Any] = ["name": "ほげぇ", "maxHP": 207, "maxMP": 120, "atk": 168, "def": 2200, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 28]
    let lv29: [String: Any] = ["name": "ほげぇ", "maxHP": 215, "maxMP": 125, "atk": 188, "def": 3000, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 29]
    let lv30: [String: Any] = ["name": "ほげぇ", "maxHP": 222, "maxMP": 130, "atk": 208, "def": 4000, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 30]
    let lv31: [String: Any] = ["name": "ほげぇ", "maxHP": 230, "maxMP": 135, "atk": 215, "def": 5000, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 31]
    let lv32: [String: Any] = ["name": "ほげぇ", "maxHP": 237, "maxMP": 140, "atk": 220, "def": 5500, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 32]
    let lv33: [String: Any] = ["name": "ほげぇ", "maxHP": 245, "maxMP": 145, "atk": 225, "def": 6000, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 33]
    let lv34: [String: Any] = ["name": "ほげぇ", "maxHP": 252, "maxMP": 150, "atk": 230, "def": 6500, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 34]
    let lv35: [String: Any] = ["name": "ほげぇ", "maxHP": 260, "maxMP": 155, "atk": 235, "def": 7000, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 35]
    let lv36: [String: Any] = ["name": "ほげぇ", "maxHP": 268, "maxMP": 160, "atk": 240, "def": 7500, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 36]
    let lv37: [String: Any] = ["name": "ほげぇ", "maxHP": 276, "maxMP": 165, "atk": 245, "def": 8000, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 37]
    let lv38: [String: Any] = ["name": "ほげぇ", "maxHP": 284, "maxMP": 170, "atk": 250, "def": 8500, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 38]
    let lv39: [String: Any] = ["name": "ほげぇ", "maxHP": 292, "maxMP": 175, "atk": 255, "def": 9000, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 39]
    let lv40: [String: Any] = ["name": "ほげぇ", "maxHP": 300, "maxMP": 180, "atk": 260, "def": 9500, "nowHP": 0, "nowMP": 0, "exp":0, "Lv": 40]


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // プレイヤー情報表示
        playerHP = player["nowHP"] as! Int
        playerMP = player["nowMP"] as! Int
        playerLv = player["Lv"] as! Int
        
        nameLabel.text = player["name"] as? String
        hpLabel.text = "HP: \(playerHP)"
        mpLabel.text = "MP: \(playerMP)"
        lvLabel.text = "Lv: \(playerLv)"
        
        // 画面にモンスター画像を表示
        appearMonster()
        
        print(monsterName1)
        print(monster1)
        print(monsterName2)
        print(monster2)
        print(monsterName3)
        print(monster3)
        print(monsterName4)
        print(monster4)
        
        if toMonsterApper == true {
            messageTextView.text = "まもののむれが あらわれた！"
            toMonsterApper = false
            toBattleCommand = true
            
        } else if toPlayerAtk == true {
            print("kokomadehaok")
            print(selectMonsterNum)
            atkType()    // 攻撃タイプごとの処理
            print("atkType")
            targetMonsterHP()    // 攻撃したモンスターのHP判定処理
            print("targetMonsterHP")
            monsterAtk()
            toPlayerAtk = false
        }
        
    }
    
    
    // 【モンスターを出現させる処理】
    func appearMonster() {
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
    }
    
    
    
    // 【攻撃の処理】をここから書いてくよ〜
    // 攻撃力の2乗 / 防御力
    // 100 * 100 / 100 = 100
    // 20 * 20 / 10 = 40
    
    
    // 1. 攻撃タイプごとの処理
    func atkType() {    // giveDamage に計算したダメージをいれる
        let playerAtkStatus = player["atk"] as! Int    // プレイヤーの攻撃力
        playerHP = player["nowHP"] as! Int    // プレイヤーの今のHP
        playerMP = player["nowMP"] as! Int    // プレイヤーの今のMP
        playerName = player["name"] as! String    // プレイヤー名
        
        switch magicNum {
        case 0:    // 通常攻撃
            switch selectMonsterNum {
            case 1:    // モンスター1を選択した時
                giveDamage = playerAtkStatus * playerAtkStatus / monster1["def"]!    // 与ダメージの計算
                monster1["hp"] = monster1["hp"]! - giveDamage    // 与ダメージ反映
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)の こうげき！\n\(monsterName1)に \(giveDamage)のダメージ！"
            case 2:
                giveDamage = playerAtkStatus * playerAtkStatus / monster2["def"]!    // 与ダメージの計算
                monster2["hp"] = monster2["hp"]! - giveDamage    // 与ダメージ反映
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)の こうげき！\n\(monsterName2)に \(giveDamage)のダメージ！"
                
            case 3:
                giveDamage = playerAtkStatus * playerAtkStatus / monster3["def"]!    // 与ダメージの計算
                monster3["hp"] = monster3["hp"]! - giveDamage    // 与ダメージ反映
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)の こうげき！\n\(monsterName3)に \(giveDamage)のダメージ！"
                
            case 4:
                giveDamage = playerAtkStatus * playerAtkStatus / monster4["def"]!    // 与ダメージの計算
                monster4["hp"] = monster4["hp"]! - giveDamage    // 与ダメージ反映
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)の こうげき！\n\(monsterName4)に \(giveDamage)のダメージ！"
                
            default:
                return
            }
            
            
        case 1:    // ヒール
            giveDamage = Int.random(in: 30...60)    // 30~60のランダム
            
            // HPの処理
            if playerHP + giveDamage > player["maxHP"] as! Int {    // 回復後のHPが上限HPをこえた場合
                giveDamage = player["maxHP"] as! Int - playerHP    // 回復量を 上限HP - 現在のHP で計算
                playerHP = player["maxHP"] as! Int    // プレイヤーのHPを上限に
            } else {
                playerHP = playerHP + giveDamage
            }

            playerMP = playerMP - 3    // MPを減らす ここも後で調整
            // バトルメッセージ表示
            messageTextView.text = "\(playerName)は ヒールを となえた！" + "\n\(playerName)のHPが \(giveDamage)かいふくした！"
            
            
        case 2:    // ひのたま
            switch selectMonsterNum {
            case 1:    // モンスター1を選択した時
                giveDamage = Int.random(in: 10...25)    // この辺後で調整する
                monster1["hp"] = monster1["hp"]! - giveDamage
                playerMP = playerMP - 2    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は ひのたまを はなった！" + "\n\(monsterName1)に \(giveDamage)のダメージ！"
            case 2:
                giveDamage = Int.random(in: 10...25)    // この辺後で調整する
                monster2["hp"] = monster2["hp"]! - giveDamage
                playerMP = playerMP - 2    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は ひのたまを はなった！" + "\n\(monsterName2)に \(giveDamage)のダメージ！"
            case 3:
                giveDamage = Int.random(in: 10...25)    // この辺後で調整する
                monster3["hp"] = monster3["hp"]! - giveDamage
                playerMP = playerMP - 2    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は ひのたまを はなった！" + "\n\(monsterName3)に \(giveDamage)のダメージ！"
            case 4:
                giveDamage = Int.random(in: 10...25)    // この辺後で調整する
                monster4["hp"] = monster4["hp"]! - giveDamage
                playerMP = playerMP - 2    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は ひのたまを はなった！" + "\n\(monsterName4)に \(giveDamage)のダメージ！"
            default:
                return
            }
            
            
            
            
        case 3:    // つららおとし
            switch selectMonsterNum {
            case 1:    // モンスター1を選択した時
                giveDamage = Int.random(in: 35...50)    // この辺後で調整する
                monster1["hp"] = monster1["hp"]! - giveDamage
                playerMP = playerMP - 4    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は つららをおとした！" + "\n\(monsterName1)に \(giveDamage)のダメージ！"
            case 2:
                giveDamage = Int.random(in: 35...50)    // この辺後で調整する
                monster2["hp"] = monster2["hp"]! - giveDamage
                playerMP = playerMP - 4    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は つららをおとした！" + "\n\(monsterName2)に \(giveDamage)のダメージ！"
            case 3:
                giveDamage = Int.random(in: 35...50)    // この辺後で調整する
                monster3["hp"] = monster3["hp"]! - giveDamage
                playerMP = playerMP - 4    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は つららをおとした！" + "\n\(monsterName3)に \(giveDamage)のダメージ！"
            case 4:
                giveDamage = Int.random(in: 35...50)    // この辺後で調整する
                monster4["hp"] = monster4["hp"]! - giveDamage
                playerMP = playerMP - 4    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は つららをおとした！" + "\n\(monsterName4)に \(giveDamage)のダメージ！"
            default:
                return
            }
            
        case 4:    // しょうげきは
            switch selectMonsterNum {
            case 1:    // モンスター1を選択した時
                giveDamage = Int.random(in: 50...65)    // この辺後で調整する
                monster1["hp"] = monster1["hp"]! - giveDamage
                playerMP = playerMP - 5    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は しょうげきはを まきおこした！" + "\n\(monsterName1)に \(giveDamage)のダメージ！"
            case 2:
                giveDamage = Int.random(in: 50...65)    // この辺後で調整する
                monster2["hp"] = monster2["hp"]! - giveDamage
                playerMP = playerMP - 5    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は しょうげきはを まきおこした！" + "\n\(monsterName2)に \(giveDamage)のダメージ！"
            case 3:
                giveDamage = Int.random(in: 50...65)    // この辺後で調整する
                monster3["hp"] = monster3["hp"]! - giveDamage
                playerMP = playerMP - 5    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は しょうげきはを まきおこした！" + "\n\(monsterName3)に \(giveDamage)のダメージ！"
            case 4:
                giveDamage = Int.random(in: 50...65)    // この辺後で調整する
                monster4["hp"] = monster4["hp"]! - giveDamage
                playerMP = playerMP - 5    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は しょうげきはを まきおこした！" + "\n\(monsterName4)に \(giveDamage)のダメージ！"
            default:
                return
            }
            
        case 5:    // ライトビーム
            switch selectMonsterNum {
            case 1:    // モンスター1を選択した時
                giveDamage = Int.random(in: 70...90)    // この辺後で調整する
                monster1["hp"] = monster1["hp"]! - giveDamage
                playerMP = playerMP - 8    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は ライトビームを はなった！" + "\n\(monsterName1)に \(giveDamage)のダメージ！"
            case 2:
                giveDamage = Int.random(in: 70...90)    // この辺後で調整する
                monster2["hp"] = monster2["hp"]! - giveDamage
                playerMP = playerMP - 8    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は ライトビームを はなった！" + "\n\(monsterName2)に \(giveDamage)のダメージ！"
            case 3:
                giveDamage = Int.random(in: 70...90)    // この辺後で調整する
                monster3["hp"] = monster3["hp"]! - giveDamage
                playerMP = playerMP - 8    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は ライトビームを はなった！" + "\n\(monsterName3)に \(giveDamage)のダメージ！"
            case 4:
                giveDamage = Int.random(in: 70...90)    // この辺後で調整する
                monster4["hp"] = monster4["hp"]! - giveDamage
                playerMP = playerMP - 8    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は ライトビームを はなった！" + "\n\(monsterName4)に \(giveDamage)のダメージ！"
            default:
                return
            }
            
        case 6:    // メガヒール
            giveDamage = Int.random(in: 90...150)    // 90~150のランダム
            
            // HPの処理
            if playerHP + giveDamage > player["maxHP"] as! Int {    // 回復後のHPが上限HPをこえた場合
                giveDamage = player["maxHP"] as! Int - playerHP    // 回復量を 上限HP - 現在のHP で計算
                playerHP = player["maxHP"] as! Int    // プレイヤーのHPを上限に
            } else {
                playerHP = playerHP + giveDamage
            }
            
            playerMP = playerMP - 6    // MPを減らす ここも後で調整
            // バトルメッセージ表示
            messageTextView.text = "\(playerName)は メガヒールを となえた！" + "\n\(playerName)のHPが \(giveDamage)かいふくした！"
            
            
        case 7:    // スターダスト
            switch selectMonsterNum {
            case 1:    // モンスター1を選択した時
                giveDamage = Int.random(in: 120...160)    // この辺後で調整する
                monster1["hp"] = monster1["hp"]! - giveDamage
                playerMP = playerMP - 13    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は スターダストを となえた！" + "\n\(monsterName1)に \(giveDamage)のダメージ！"
            case 2:
                giveDamage = Int.random(in: 120...160)    // この辺後で調整する
                monster2["hp"] = monster2["hp"]! - giveDamage
                playerMP = playerMP - 13    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は スターダストを となえた！" + "\n\(monsterName2)に \(giveDamage)のダメージ！"
            case 3:
                giveDamage = Int.random(in: 120...160)    // この辺後で調整する
                monster3["hp"] = monster3["hp"]! - giveDamage
                playerMP = playerMP - 13    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は スターダストを となえた！" + "\n\(monsterName3)に \(giveDamage)のダメージ！"
            case 4:
                giveDamage = Int.random(in: 120...160)    // この辺後で調整する
                monster4["hp"] = monster4["hp"]! - giveDamage
                playerMP = playerMP - 13    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は スターダストを となえた！" + "\n\(monsterName4)に \(giveDamage)のダメージ！"
            default:
                return
            }
            
        default:
            return
        }
        
        player["nowHP"] = playerHP    // 計算結果を代入
        hpLabel.text = "HP: \(playerHP)"    // ラベルに反映
        player["nowMP"] = playerMP    // 計算結果を代入
        mpLabel.text = "MP: \(playerMP)"    // ラベルに反映
    }
    
    
    // 2. ターゲットモンスターのHP判定処理
    func targetMonsterHP() {
        print("targetMonsterHPのなか")
        switch selectMonsterNum {
        case 1:    // モンスター1を選択した時
            if monster1["hp"]! <= 0 {    // モンスター1死んじゃった
                messageTextView.text = messageTextView.text + "\n\(monsterName1)を たおした！"    // バトルメッセージ表示
                monsterImage1.alpha = 0    // 画像を消す
                
                allExp += monster1["exp"]!
                
            }
            
        case 2:    // モンスター2を選択した時
            if monster2["hp"]! <= 0 {
                messageTextView.text = messageTextView.text + "\n\(monsterName2)を たおした！"    // バトルメッセージ表示
                monsterImage2.alpha = 0    // 画像を消す
                
                allExp += monster2["exp"]!
                
            }
            
        case 3:
            if monster3["hp"]! <= 0 {
                messageTextView.text = messageTextView.text + "\n\(monsterName3)を たおした！"    // バトルメッセージ表示
                monsterImage3.alpha = 0    // 画像を消す
                
                allExp += monster3["exp"]!
                
            }
            
        case 4:
            if monster4["hp"]! <= 0 {
                messageTextView.text = messageTextView.text + "\n\(monsterName4)を たおした！"    // バトルメッセージ表示
                monsterImage4.alpha = 0    // 画像を消す
                
                allExp += monster4["exp"]!
                
            }
        default:
            break    // ここreturnだと、ヒール等回復系のとき処理を抜けちゃうから困る。
        }
        if monster1["hp"]! <= 0 && monster2["hp"]! <= 0 && monster3["hp"]! <= 0 && monster4["hp"]! <= 0 {    // 敵全滅！
            // メインボタン押した時の処理
            toBattleCommand = false
            toBack = false
            toMonsterAtk = false
            toFinishBattle = true
            toPlayerDie = false
            
        } else {    // 敵まだのこってる！
            // メインボタン押した時の処理
            toBattleCommand = false
            toBack = false
            toMonsterAtk = true
            toFinishBattle = false
            toPlayerDie = false
            print("toMonsterAtkture")
        }
    }
    
    
    // 3. モンスターからの攻撃の処理
    func monsterAtk() {
        let playerDefStatus = player["def"] as! Int
        playerHP = player["nowHP"] as! Int
        playerName = player["name"] as! String
        
        if monster1["hp"]! >= 1 {    // モンスター1が生きてるとき
            monsterCount += 1    // 生存モンスターカウントを +1
            takeDamage = monster1["atk"]! * monster1["atk"]! / playerDefStatus    // ダメージ計算
            
            playerHP = playerHP - takeDamage    // ダメージ反映
            player["nowHP"] = playerHP
            
            // バトルメッセージ格納
            monsterAtkMessage.append("\(monsterName1)の こうげき！\n\(playerName)は \(takeDamage)のダメージを うけた!")
            
            if playerHP > 0 {    // プレイヤー生きてるとき
                // HP格納
                monsterAtkHP.append("\(playerHP)")
                
            } else {    // プレイヤー死んだとき
                playerHP = 0    // HP0にする
                player["nowHP"] = playerHP
                // HP格納
                monsterAtkHP.append("\(playerHP)")
                
                // バトルメッセージ格納
                monsterAtkMessage.append("\(playerName)は しんでしまった！")
                // 配列数合わせるためもう一度HP格納
                monsterAtkHP.append("\(playerHP)")
                
                // メインボタン押した時の処理
                toBattleCommand = false
                toBack = false
                toMonsterAtk = false
                toFinishBattle = false
                toPlayerDie = true
                
                return
                
            }
        }
        if monster2["hp"]! >= 1 {    // モンスター2が生きてるとき
            monsterCount += 1
            takeDamage = monster2["atk"]! * monster2["atk"]! / playerDefStatus    // ダメージ計算
            playerHP = playerHP - takeDamage    // ダメージ反映
            player["nowHP"] = playerHP
            
            // バトルメッセージ格納
            monsterAtkMessage.append("\(monsterName2)の こうげき！\n\(playerName)は \(takeDamage)のダメージを うけた!")
            
            if playerHP > 0 {    // プレイヤー生きてるとき
                // HP格納
                monsterAtkHP.append("\(playerHP)")
                
            } else {    // プレイヤー死んだとき
                playerHP = 0    // HP0にする
                player["nowHP"] = playerHP
                // HP格納
                monsterAtkHP.append("\(playerHP)")
                
                // バトルメッセージ格納
                monsterAtkMessage.append("\(playerName)は しんでしまった！")
                // 配列数合わせるためもう一度HP格納
                monsterAtkHP.append("\(playerHP)")
                
                // メインボタン押した時の処理
                toBattleCommand = false
                toBack = false
                toMonsterAtk = false
                toFinishBattle = false
                toPlayerDie = true
                
                return
            }
        }
        
        if monster3["hp"]! >= 1 {    // モンスター3が生きてるとき
            monsterCount += 1
            takeDamage = monster3["atk"]! * monster3["atk"]! / playerDefStatus    // ダメージ計算
            playerHP = playerHP - takeDamage    // ダメージ反映
            player["nowHP"] = playerHP
            
            // バトルメッセージ格納
            monsterAtkMessage.append("\(monsterName3)の こうげき！\n\(playerName)は \(takeDamage)のダメージを うけた!")
            
            if playerHP > 0 {    // プレイヤー生きてるとき
                // HP格納
                monsterAtkHP.append("\(playerHP)")
                
            } else {    // プレイヤー死んだとき
                playerHP = 0    // HP0にする
                player["nowHP"] = playerHP
                // HP格納
                monsterAtkHP.append("\(playerHP)")
                
                // バトルメッセージ格納
                monsterAtkMessage.append("\(playerName)は しんでしまった！")
                // 配列数合わせるためもう一度HP格納
                monsterAtkHP.append("\(playerHP)")
                
                // メインボタン押した時の処理
                toBattleCommand = false
                toBack = false
                toMonsterAtk = false
                toFinishBattle = false
                toPlayerDie = true
                
                return
            }
        }
        if monster4["hp"]! >= 1 {    // モンスター4が生きてるとき
            monsterCount += 1
            takeDamage = monster4["atk"]! * monster4["atk"]! / playerDefStatus    // ダメージ計算
            playerHP = playerHP - takeDamage    // ダメージ反映
            player["nowHP"] = playerHP
            
            // バトルメッセージ格納
            monsterAtkMessage.append("\(monsterName4)の こうげき！\n\(playerName)は \(takeDamage)のダメージを うけた!")
            
            if playerHP > 0 {    // プレイヤー生きてるとき
                // HP格納
                monsterAtkHP.append("\(playerHP)")
                
            } else {    // プレイヤー死んだとき
                playerHP = 0    // HP0にする
                player["nowHP"] = playerHP
                // HP格納
                monsterAtkHP.append("\(playerHP)")
                
                // バトルメッセージ格納
                monsterAtkMessage.append("\(playerName)は しんでしまった！")
                // 配列数合わせるためもう一度HP格納
                monsterAtkHP.append("\(playerHP)")
                
                // メインボタン押した時の処理
                toBattleCommand = false
                toBack = false
                toMonsterAtk = false
                toFinishBattle = false
                toPlayerDie = true
                
                return
                
            }
        }
    }
    
    
    
    
    
    @IBAction func mainButton(_ sender: UIButton) {    // メインボタン
        playerName = player["name"] as! String
        playerHP = player["nowHP"] as! Int
        playerMP = player["nowMP"] as! Int
        playerLv = player["Lv"] as! Int

        // バトルコマンド選択画面に遷移する
        if toBattleCommand == true {
            self.performSegue(withIdentifier: "toBattleCommand", sender: nil)    // 画面遷移
            
            // バトル終了してマップに戻る
        } else if toBack == true {
            if toCave1 == true {
                self.performSegue(withIdentifier: "toCave1", sender: nil)
            } else if toCave2 == true {
                self.performSegue(withIdentifier: "toCave2", sender: nil)
            } else if toCave3 == true {
                self.performSegue(withIdentifier: "toCave3", sender: nil)
            } else if toCave4 == true {
                self.performSegue(withIdentifier: "toCave4", sender: nil)
            } else if toCave5 == true {
                self.performSegue(withIdentifier: "toCave5", sender: nil)
            } else if toCave6 == true {
                self.performSegue(withIdentifier: "toCave6", sender: nil)
            } else if toCave7 == true {
                self.performSegue(withIdentifier: "toCave7", sender: nil)
            } else if toCave8 == true {
                self.performSegue(withIdentifier: "toCave8", sender: nil)
            } else if toCave9 == true {
                self.performSegue(withIdentifier: "toCave9", sender: nil)
            }
            
            
            // モンスターからの攻撃メッセージを表示
        } else if toMonsterAtk == true {
            
            if count == 0 {    // メインボタンカウントが0のとき
                messageTextView.text = monsterAtkMessage[0]    // メッセージ表示
                hpLabel.text = "HP: \(monsterAtkHP[0])"
                if count + 1 == monsterAtkMessage.count {    // モンスターのターンが終わりの時
                    
                    toMonsterAtk = false    // モンスターからの攻撃のフェーズ終わり
                    toBattleCommand = true    // コマンド選択画面遷移のフェーズへ
                } else {    // モンスターのターンが続くとき
                    count += 1    // メインボタンカウントを +1
                }
                
                print("count0")
                print(count)
                
            } else if count == 1 {    // メインボタンカウントが1のとき
                messageTextView.text = monsterAtkMessage[1]    // メッセージ表示
                hpLabel.text = "HP: \(monsterAtkHP[1])"
                if count + 1 == monsterAtkMessage.count {    // モンスターのターンが終わりの時
                    
                    toMonsterAtk = false    // モンスターからの攻撃のフェーズ終わり
                    toBattleCommand = true    // コマンド選択画面遷移のフェーズへ
                } else {    // モンスターのターンが続くとき
                    count += 1    // メインボタンカウントを +1
                }
                
                print("count1")
                
            } else if count == 2 {    // メインボタンカウントが2のとき
                messageTextView.text = monsterAtkMessage[2]    // メッセージ表示
                hpLabel.text = "HP: \(monsterAtkHP[2])"
                if count + 1 == monsterAtkMessage.count {    // モンスターのターンが終わりの時
                    toMonsterAtk = false    // モンスターからの攻撃のフェーズ終わり
                    toBattleCommand = true    // コマンド選択画面遷移のフェーズへ
                } else {    // モンスターのターンが続くとき
                    count += 1    // メインボタンカウントを +1
                }
                
                print("count2")
                
            } else if count == 3 {    // メインボタンカウントが3のとき
                messageTextView.text = monsterAtkMessage[3]    // メッセージ表示
                hpLabel.text = "HP: \(monsterAtkHP[3])"
                if count + 1 == monsterAtkMessage.count {    // モンスターのターンが終わりの時
                    toMonsterAtk = false    // モンスターからの攻撃のフェーズ終わり
                    toBattleCommand = true    // コマンド選択画面遷移のフェーズへ
                }
                print("count3")
            }
            
            
            // 敵を全滅させた時の処理
        } else if toFinishBattle == true {
            // メッセージ表示
            messageTextView.text = "\(allExp)のけいけんちを かくとく！"
            // 獲得経験値を加算
            player["exp"] = player["exp"] as! Int + allExp


            // レベルアップした時の処理を追加
            // とりま格納
            exp = player["exp"] as! Int

            if exp >= 45 && exp < 100 && exp - allExp < 45 {    // Lv2: 必要経験値45
                player = lv2
                print(exp)
                print(player)
                lvUp()
            } else if exp >= 100 && exp < 200 && exp - allExp < 100 {    // Lv3: 必要経験値100
                print(lv3)
                player = lv3
                print(player)
                lvUp()
            } else if exp >= 200 && exp < 300 && exp - allExp < 200 {    // Lv4: 必要経験値200
                player = lv4
                lvUp()
            } else if exp >= 300 && exp < 400 && exp - allExp < 300 {    // Lv5: 必要経験値300
                player = lv5
                lvUp()
                messageTextView.text = messageTextView.text + "\n\(playerName)は ひのたまを おぼえた！"
            } else if exp >= 400 && exp < 500 && exp - allExp < 400 {    // Lv6: 必要経験値400
                player = lv6
                lvUp()
            } else if exp >= 500 && exp < 800 && exp - allExp < 500 {    // Lv7: 必要経験値500
                player = lv7
                lvUp()
            } else if exp >= 800 && exp < 1100 && exp - allExp < 800 {    // Lv8: 必要経験値800
                player = lv8
                lvUp()
            } else if exp >= 1100 && exp < 1400 && exp - allExp < 1100 {    // Lv9: 必要経験値1100
                player = lv9
                lvUp()
            } else if exp >= 1400 && exp < 1800 && exp - allExp < 1400 {    // Lv10: 必要経験値1400
                player = lv10
                lvUp()
                messageTextView.text = messageTextView.text + "\n\(playerName)は つららおとしを おぼえた！"
            } else if exp >= 1800 && exp < 2300 && exp - allExp < 1800 {    // Lv11: 必要経験値1800
                player = lv11
                lvUp()
            } else if exp >= 2300 && exp < 2800 && exp - allExp < 2300 {    // Lv12: 必要経験値2300
                player = lv12
                lvUp()
            } else if exp >= 2800 && exp < 3300 && exp - allExp < 2800 {    // Lv13: 必要経験値2800
                player = lv13
                lvUp()
            } else if exp >= 3300 && exp < 3800 && exp - allExp < 3300 {    // Lv14: 必要経験値3300
                player = lv14
                lvUp()
            } else if exp >= 3800 && exp < 4300 && exp - allExp < 3800 {    // Lv15: 必要経験値3800
                player = lv15
                lvUp()
            } else if exp >= 4300 && exp < 4900 && exp - allExp < 4300 {    // Lv16: 必要経験値4300
                player = lv16
                lvUp()
                messageTextView.text = messageTextView.text + "\n\(playerName)は しょうげきはを おぼえた！"
            } else if exp >= 4900 && exp < 5500 && exp - allExp < 4900 {    // Lv17: 必要経験値4900
                player = lv17
                lvUp()
            } else if exp >= 5500 && exp < 6100 && exp - allExp < 5500 {    // Lv18: 必要経験値5500
                player = lv18
                lvUp()
            } else if exp >= 6100 && exp < 6800 && exp - allExp < 6100 {    // Lv19: 必要経験値6100
                player = lv19
                lvUp()
            } else if exp >= 6800 && exp < 8500 && exp - allExp < 6800 {    // Lv20: 必要経験値6800
                player = lv20
                lvUp()
                messageTextView.text = messageTextView.text + "\n\(playerName)は ライトビームを おぼえた！"
            } else if exp >= 8500 && exp < 10200 && exp - allExp < 8500 {    // Lv21: 必要経験値8500
                player = lv21
                lvUp()
            } else if exp >= 10200 && exp < 11900 && exp - allExp < 10200 {    // Lv22: 必要経験値10200
                player = lv22
                lvUp()
            } else if exp >= 11900 && exp < 13600 && exp - allExp < 11900 {    // Lv23: 必要経験値11900
                player = lv23
                lvUp()
            } else if exp >= 13600 && exp < 15300 && exp - allExp < 13600 {    // Lv24: 必要経験値13600
                player = lv24
                lvUp()
            } else if exp >= 15300 && exp < 17000 && exp - allExp < 15300 {    // Lv25: 必要経験値15300
                player = lv25
                lvUp()
            } else if exp >= 17000 && exp < 21500 && exp - allExp < 17000 {    // Lv26: 必要経験値17000
                player = lv26
                lvUp()
            } else if exp >= 21500 && exp < 26000 && exp - allExp < 21500 {    // Lv27: 必要経験値21500
                player = lv27
                lvUp()
            } else if exp >= 26000 && exp < 30500 && exp - allExp < 26000 {    // Lv28: 必要経験値26000
                player = lv28
                lvUp()
                messageTextView.text = messageTextView.text + "\n\(playerName)は スターダストを おぼえた！"
            } else if exp >= 30500 && exp < 35000 && exp - allExp < 30500 {    // Lv29: 必要経験値30500
                player = lv29
                lvUp()
            } else if exp >= 35000 && exp < 40000 && exp - allExp < 35000 {    // Lv30: 必要経験値35000
                player = lv30
                lvUp()
            } else if exp >= 40000 && exp < 45000 && exp - allExp < 40000 {    // Lv31: 必要経験値40000
                player = lv31
                lvUp()
            } else if exp >= 45000 && exp < 50000 && exp - allExp < 45000 {    // Lv32: 必要経験値45000
                player = lv32
                lvUp()
            } else if exp >= 50000 && exp < 55000 && exp - allExp < 50000 {    // Lv33: 必要経験値50000
                player = lv33
                lvUp()
            } else if exp >= 55000 && exp < 60000 && exp - allExp < 55000 {    // Lv34: 必要経験値55000
                player = lv34
                lvUp()
            } else if exp >= 60000 && exp < 65000 && exp - allExp < 60000 {    // Lv35: 必要経験値60000
                player = lv35
                lvUp()
            } else if exp >= 65000 && exp < 70000 && exp - allExp < 65000 {    // Lv36: 必要経験値65000
                player = lv36
                lvUp()
            } else if exp >= 70000 && exp < 75000 && exp - allExp < 70000 {    // Lv37: 必要経験値70000
                player = lv37
                lvUp()
            } else if exp >= 75000 && exp < 80000 && exp - allExp < 75000 {    // Lv38: 必要経験値75000
                player = lv38
                lvUp()
            } else if exp >= 80000 && exp < 85000 && exp - allExp < 80000 {    // Lv39: 必要経験値80000
                player = lv39
                lvUp()
            } else if exp >= 85000 && exp - allExp < 85000 {    // Lv40: 必要経験値85000
                player = lv40
                lvUp()
            }




            
            toFinishBattle = false
            toBack = true
            
            
            // プレイヤー死んだときの処理
        } else if toPlayerDie == true {
            if count == 0 {    // メインボタンカウントが0のとき
                messageTextView.text = monsterAtkMessage[0]    // メッセージ表示
                hpLabel.text = "HP: \(monsterAtkHP[0])"
                if count + 1 == monsterAtkMessage.count {    // モンスターのターンが終わりの時
                    
                    toPlayerDie = false    // 終わり
                    toRestart = true
                } else {    // モンスターのターンが続くとき
                    count += 1    // メインボタンカウントを +1
                }
                
                print("diecount0")
                print(count)
                
            } else if count == 1 {    // メインボタンカウントが1のとき
                messageTextView.text = monsterAtkMessage[1]    // メッセージ表示
                hpLabel.text = "HP: \(monsterAtkHP[1])"
                if count + 1 == monsterAtkMessage.count {    // モンスターのターンが終わりの時
                    
                    toPlayerDie = false    // 終わり
                    toRestart = true
                } else {    // モンスターのターンが続くとき
                    count += 1    // メインボタンカウントを +1
                }
                
                print("diecount1")
                
            } else if count == 2 {    // メインボタンカウントが2のとき
                messageTextView.text = monsterAtkMessage[2]    // メッセージ表示
                hpLabel.text = "HP: \(monsterAtkHP[2])"
                if count + 1 == monsterAtkMessage.count {    // モンスターのターンが終わりの時
                    toPlayerDie = false    // 終わり
                    toRestart = true
                } else {    // モンスターのターンが続くとき
                    count += 1    // メインボタンカウントを +1
                }
                
                print("diecount2")
                
            } else if count == 3 {    // メインボタンカウントが3のとき
                messageTextView.text = monsterAtkMessage[3]    // メッセージ表示
                hpLabel.text = "HP: \(monsterAtkHP[3])"
                if count + 1 == monsterAtkMessage.count {    // モンスターのターンが終わりの時
                    toPlayerDie = false    // 終わり
                    toRestart = true
                } else {    // モンスターのターンが続くとき
                    count += 1    // メインボタンカウントを +1
                }
                print("diecount3")
                
            } else if count == 4 {    // メインボタンカウントが4のとき
                messageTextView.text = monsterAtkMessage[4]    // メッセージ表示
                hpLabel.text = "HP: \(monsterAtkHP[4])"
                if count + 1 == monsterAtkMessage.count {    // モンスターのターンが終わりの時
                    toPlayerDie = false    // 終わり
                    toRestart = true
                }
                print("diecount4")
                
            }
        } else if toRestart == true {
            self.performSegue(withIdentifier: "toRestart", sender: nil)    // 最初のマップに遷移
            
        }
    }

    // レベルアップの時に使う
    func lvUp() {
        player["nowHP"] = player["maxHP"]    // HP全快
        player["nowMP"] = player["maxMP"]    // MP全快
        player["exp"] = exp    // 経験値を代入
        playerHP = player["nowHP"] as! Int
        playerMP = player["nowMP"] as! Int
        playerLv = player["Lv"] as! Int
        messageTextView.text = messageTextView.text + "\n\(playerName)は レベル\(playerLv)に あがった！"
        hpLabel.text = "HP: \(playerHP)"    // ラベル反映
        mpLabel.text = "MP: \(playerMP)"    // ラベル反映
        lvLabel.text = "Lv: \(playerLv)"    // ラベル反映
    }

    
    

    // segue遷移前動作
    // セグエ実行前処理 / セグエの identifier 確認 / 遷移先ViewController の取得
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // バトルコマンド画面への遷移前処理
        if (segue.identifier == "toBattleCommand") {

            let vc: battleCommandViewController = (segue.destination as? battleCommandViewController)!

            // 向こうで必要な情報は
            // 1. プレイヤーの名前、HP、MP,Lv
            vc.player = player
            //player["Lv"] = 30    // テストプレイでつけてるだけ。あとで消す。


            // 2. モンスター情報
            vc.monsterName1 = monsterName1
            vc.monster1 = monster1

            vc.monsterName2 = monsterName2
            vc.monster2 = monster2

            vc.monsterName3 = monsterName3
            vc.monster3 = monster3

            vc.monsterName4 = monsterName4
            vc.monster4 = monster4

            toBattleCommand = false

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


            vc.currentNum = currentNum


            // 死んだ時の遷移前処理
        } else if (segue.identifier == "toRestart") {

            let vc: cave1ViewController = (segue.destination as? cave1ViewController)!

            // プレイヤーのHP,MPを全快にする
            player["nowHP"] = player["maxHP"]
            player["nowMP"] = player["maxMP"]

            // プレイヤーの情報
            vc.player = player


            vc.playerLeftLocation = 266.5

            vc.playerOverLocation = 291.5





        } else if (segue.identifier == "toCave1") {    // cave1への遷移前処理

            let vc: cave1ViewController = (segue.destination as? cave1ViewController)!
            // プレイヤーの情報
            vc.player = player
            vc.playerLeftLocation = playerLeftLocation
            vc.playerOverLocation = playerOverLocation
            vc.currentNum = currentNum

        } else if (segue.identifier == "toCave2") {    // cave2への遷移処理
            let vc: cave2ViewController = (segue.destination as? cave2ViewController)!
            // プレイヤーの情報
            vc.player = player
            vc.playerLeftLocation = playerLeftLocation
            vc.playerOverLocation = playerOverLocation
            vc.currentNum = currentNum

        } else if (segue.identifier == "toCave3") {    // cave3への遷移処理
            let vc: cave3ViewController = (segue.destination as? cave3ViewController)!
            // プレイヤーの情報
            vc.player = player
            vc.playerLeftLocation = playerLeftLocation
            vc.playerOverLocation = playerOverLocation
            vc.currentNum = currentNum

        } else if (segue.identifier == "toCave4") {    // cave4への遷移処理
            let vc: cave4ViewController = (segue.destination as? cave4ViewController)!
            // プレイヤーの情報
            vc.player = player
            vc.playerLeftLocation = playerLeftLocation
            vc.playerOverLocation = playerOverLocation
            vc.currentNum = currentNum


        } else if (segue.identifier == "toCave5") {    // cave5への遷移処理
            let vc: cave5ViewController = (segue.destination as? cave5ViewController)!
            // プレイヤーの情報
            vc.player = player
            vc.playerLeftLocation = playerLeftLocation
            vc.playerOverLocation = playerOverLocation
            vc.currentNum = currentNum
        }
/*
        } else if (segue.identifier == "toCave6") {    // cave6への遷移処理
            let vc: cave6ViewController = (segue.destination as? cave6ViewController)!
            // プレイヤーの情報
            vc.player = player
            vc.playerLeftLocation = playerLeftLocation
            vc.playerOverLocation = playerOverLocation
            vc.currentNum = currentNum

        } else if (segue.identifier == "toCave7") {    // cave7への遷移処理
            let vc: cave7ViewController = (segue.destination as? cave7ViewController)!
            // プレイヤーの情報
            vc.player = player
            vc.playerLeftLocation = playerLeftLocation
            vc.playerOverLocation = playerOverLocation
            vc.currentNum = currentNum

        } else if (segue.identifier == "toCave8") {    // cave8への遷移処理
            let vc: cave8ViewController = (segue.destination as? cave8ViewController)!
            // プレイヤーの情報
            vc.player = player
            vc.playerLeftLocation = playerLeftLocation
            vc.playerOverLocation = playerOverLocation
            vc.currentNum = currentNum

        } else if (segue.identifier == "toCave9") {    // cave9への遷移処理
            let vc: cave9ViewController = (segue.destination as? cave9ViewController)!
            // プレイヤーの情報
            vc.player = player
            vc.playerLeftLocation = playerLeftLocation
            vc.playerOverLocation = playerOverLocation
            vc.currentNum = currentNum
        }
 */
    }
}
