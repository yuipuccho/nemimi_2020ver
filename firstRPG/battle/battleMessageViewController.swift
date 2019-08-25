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

    var name = ""
    var hp = 0
    var mp = 0
    var lv = 0


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
    var player: [String: Any] = [
        "name": "ほげぇ",
        "Lv": 1,    // レベル
        "maxHP": 24,    // 最大HP
        "maxMP": 10,    // 最大MP
        "nowHP": 24,
        "nowMP": 10,
        "atk": 12,    // 攻撃力
        "def": 15,    // 守備力
        "agi": 8,    // すばやさ
        "itemAtk": 0,    // 装備の攻撃力
        "itemDef": 0,    // 装備の守備力
        "exp": 0,    // 経験値
        "gold": 0    // 所持金
    ]

    // 1 ヒール
    // 5 ひのたま
    // 10 つららおとし
    // 16 しょうげきは
    // 20 ライトビーム
    // 23 メガヒール
    // 28 スターダスト


    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func viewWillAppear(_ animated: Bool) {
        // プレイヤー情報表示
        hp = player["nowHP"] as! Int
        mp = player["nowMP"] as! Int
        lv = player["Lv"] as! Int

        nameLabel.text = player["name"] as? String
        hpLabel.text = "HP: \(hp)"
        mpLabel.text = "MP: \(mp)"
        lvLabel.text = "Lv: \(lv)"

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
        var playerHP = player["nowHP"] as! Int    // プレイヤーの今のHP
        var playerMP = player["nowMP"] as! Int    // プレイヤーの今のMP
        let playerName = player["name"] as! String    // プレイヤー名

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
            giveDamage = Int.random(in: 30...50)    // 30~50のランダム

            // HPの処理
            if playerHP + giveDamage > player["maxHP"] as! Int {    // 回復後のHPが上限HPをこえた場合
                giveDamage = player["maxHP"] as! Int - playerHP    // 回復量を 上限HP - 現在のHP で計算
                playerHP = player["maxHP"] as! Int    // プレイヤーのHPを上限に
            } else {
                playerHP = playerHP + giveDamage
            }


            playerMP = playerMP - 5    // MPを減らす ここも後で調整
            // バトルメッセージ表示
            messageTextView.text = "\(playerName)は ヒールを となえた！" + "\n\(playerName)のHPが \(giveDamage)かいふくした！"


        case 2:    // ひのたま
            switch selectMonsterNum {
            case 1:    // モンスター1を選択した時
                giveDamage = Int.random(in: 10...20)    // この辺後で調整する
                monster1["hp"] = monster1["hp"]! - giveDamage
                playerMP = playerMP - 5    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は ひのたまを はなった！" + "\n\(monsterName1)に \(giveDamage)のダメージ！"
            case 2:
                giveDamage = Int.random(in: 10...20)    // この辺後で調整する
                monster2["hp"] = monster2["hp"]! - giveDamage
                playerMP = playerMP - 5    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は ひのたまを はなった！" + "\n\(monsterName2)に \(giveDamage)のダメージ！"
            case 3:
                giveDamage = Int.random(in: 10...20)    // この辺後で調整する
                monster3["hp"] = monster3["hp"]! - giveDamage
                playerMP = playerMP - 5    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は ひのたまを はなった！" + "\n\(monsterName3)に \(giveDamage)のダメージ！"
            case 4:
                giveDamage = Int.random(in: 10...20)    // この辺後で調整する
                monster4["hp"] = monster4["hp"]! - giveDamage
                playerMP = playerMP - 5    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\\(playerName)は ひのたまを はなった！" + "\n\(monsterName4)に \(giveDamage)のダメージ！"
            default:
                return
            }




        case 3:    // つららおとし
            switch selectMonsterNum {
            case 1:    // モンスター1を選択した時
                giveDamage = Int.random(in: 10...20)    // この辺後で調整する
                monster1["hp"] = monster1["hp"]! - giveDamage
                playerMP = playerMP - 5    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は つららをおとした！" + "\n\(monsterName1)に \(giveDamage)のダメージ！"
            case 2:
                giveDamage = Int.random(in: 10...20)    // この辺後で調整する
                monster2["hp"] = monster2["hp"]! - giveDamage
                playerMP = playerMP - 5    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は つららをおとした！" + "\n\(monsterName2)に \(giveDamage)のダメージ！"
            case 3:
                giveDamage = Int.random(in: 10...20)    // この辺後で調整する
                monster3["hp"] = monster3["hp"]! - giveDamage
                playerMP = playerMP - 5    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は つららをおとした！" + "\n\(monsterName3)に \(giveDamage)のダメージ！"
            case 4:
                giveDamage = Int.random(in: 10...20)    // この辺後で調整する
                monster4["hp"] = monster4["hp"]! - giveDamage
                playerMP = playerMP - 5    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は つららをおとした！" + "\n\(monsterName4)に \(giveDamage)のダメージ！"
            default:
                return
            }

        case 4:    // しょうげきは
            switch selectMonsterNum {
            case 1:    // モンスター1を選択した時
                giveDamage = Int.random(in: 10...20)    // この辺後で調整する
                monster1["hp"] = monster1["hp"]! - giveDamage
                playerMP = playerMP - 5    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は しょうげきはを まきおこした！" + "\n\(monsterName1)に \(giveDamage)のダメージ！"
            case 2:
                giveDamage = Int.random(in: 10...20)    // この辺後で調整する
                monster2["hp"] = monster2["hp"]! - giveDamage
                playerMP = playerMP - 5    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は しょうげきはを まきおこした！" + "\n\(monsterName2)に \(giveDamage)のダメージ！"
            case 3:
                giveDamage = Int.random(in: 10...20)    // この辺後で調整する
                monster3["hp"] = monster3["hp"]! - giveDamage
                playerMP = playerMP - 5    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は しょうげきはを まきおこした！" + "\n\(monsterName3)に \(giveDamage)のダメージ！"
            case 4:
                giveDamage = Int.random(in: 10...20)    // この辺後で調整する
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
                giveDamage = Int.random(in: 10...20)    // この辺後で調整する
                monster1["hp"] = monster1["hp"]! - giveDamage
                playerMP = playerMP - 5    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は ライトビームを はなった！" + "\n\(monsterName1)に \(giveDamage)のダメージ！"
            case 2:
                giveDamage = Int.random(in: 10...20)    // この辺後で調整する
                monster2["hp"] = monster2["hp"]! - giveDamage
                playerMP = playerMP - 5    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は ライトビームを はなった！" + "\n\(monsterName2)に \(giveDamage)のダメージ！"
            case 3:
                giveDamage = Int.random(in: 10...20)    // この辺後で調整する
                monster3["hp"] = monster3["hp"]! - giveDamage
                playerMP = playerMP - 5    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は ライトビームを はなった！" + "\n\(monsterName3)に \(giveDamage)のダメージ！"
            case 4:
                giveDamage = Int.random(in: 10...20)    // この辺後で調整する
                monster4["hp"] = monster4["hp"]! - giveDamage
                playerMP = playerMP - 5    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は ライトビームを はなった！" + "\n\(monsterName4)に \(giveDamage)のダメージ！"
            default:
                return
            }

        case 6:    // メガヒール
            giveDamage = Int.random(in: 70...100)    // 70~100のランダム

            // HPの処理
            if playerHP + giveDamage > player["maxHP"] as! Int {    // 回復後のHPが上限HPをこえた場合
                giveDamage = player["maxHP"] as! Int - playerHP    // 回復量を 上限HP - 現在のHP で計算
                playerHP = player["maxHP"] as! Int    // プレイヤーのHPを上限に
            } else {
                playerHP = playerHP + giveDamage
            }

            playerMP = playerMP - 5    // MPを減らす ここも後で調整
            // バトルメッセージ表示
            messageTextView.text = "\(playerName)は メガヒールを となえた！" + "\n\(playerName)のHPが \(giveDamage)かいふくした！"


        case 7:    // スターダスト
            switch selectMonsterNum {
            case 1:    // モンスター1を選択した時
                giveDamage = Int.random(in: 10...20)    // この辺後で調整する
                monster1["hp"] = monster1["hp"]! - giveDamage
                playerMP = playerMP - 5    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は スターダストを となえた！" + "\n\(monsterName1)に \(giveDamage)のダメージ！"
            case 2:
                giveDamage = Int.random(in: 10...20)    // この辺後で調整する
                monster2["hp"] = monster2["hp"]! - giveDamage
                playerMP = playerMP - 5    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は スターダストを となえた！" + "\n\(monsterName2)に \(giveDamage)のダメージ！"
            case 3:
                giveDamage = Int.random(in: 10...20)    // この辺後で調整する
                monster3["hp"] = monster3["hp"]! - giveDamage
                playerMP = playerMP - 5    // MPを減らす
                // バトルメッセージ表示
                messageTextView.text = "\(playerName)は スターダストを となえた！" + "\n\(monsterName3)に \(giveDamage)のダメージ！"
            case 4:
                giveDamage = Int.random(in: 10...20)    // この辺後で調整する
                monster4["hp"] = monster4["hp"]! - giveDamage
                playerMP = playerMP - 5    // MPを減らす
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
        var playerHP = player["nowHP"] as! Int
        let playerName = player["name"] as! String

        if monster1["hp"]! >= 1 {    // モンスター1が生きてるとき
            monsterCount += 1    // 生存モンスターカウントを +1
            takeDamage = monster1["atk"]! * monster1["atk"]! / playerDefStatus    // ダメージ計算

            playerHP = playerHP - takeDamage    // ダメージ反映
            player["nowHP"] = playerHP

            // バトルメッセージ格納
            monsterAtkMessage.append("\(monsterName1)のこうげき！\n\(playerName)は \(takeDamage)のダメージをうけた!")

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
            monsterAtkMessage.append("\(monsterName2)のこうげき！\n\(playerName)は \(takeDamage)のダメージをうけた!")

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
            monsterAtkMessage.append("\(monsterName3)のこうげき！\n\(playerName)は \(takeDamage)のダメージをうけた!")

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
            monsterAtkMessage.append("\(monsterName1)のこうげき！\n\(playerName)は \(takeDamage)のダメージをうけた!")

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
        // バトルコマンド選択画面に遷移する
        if toBattleCommand == true {
            self.performSegue(withIdentifier: "toBattleCommand", sender: nil)    // 画面遷移

        // バトル終了してマップに戻る
        } else if toBack == true {
            self.performSegue(withIdentifier: "toCave1", sender: nil)


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


        // 敵を全滅させた時のメッセージ表示
        } else if toFinishBattle == true {
            messageTextView.text = "\(allExp)のけいけんちを かくとく！"
            // レベルアップした時の処理を追加

            
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






    // segue遷移前動作
    // セグエ実行前処理 / セグエの identifier 確認 / 遷移先ViewController の取得
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toBattleCommand", let vc = segue.destination as? battleCommandViewController else {
            return
        }
        // 向こうで必要な情報は
        // 1. プレイヤーの名前、HP、MP,Lv
        vc.name = player["name"] as! String
        vc.player["nowHP"] = player["nowHP"]
        vc.player["nowMP"] = player["nowMP"]
        player["Lv"] = 30
        vc.player["Lv"] = player["Lv"]



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

    }
}
