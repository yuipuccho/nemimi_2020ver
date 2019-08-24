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


    /// メインボタンを押した時に画面遷移するかどうか判断
    var toSelect: Bool = false



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

    // 1 ヒール
    // 5 ひのたま
    // 10 つららおとし
    // 16 しょうげきは
    // 20 ライトビーム
    // 23 メガヒール
    // 28 スターダスト


    override func viewDidLoad() {
        super.viewDidLoad()
        // 画面遷移OK
        toSelect = true
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

    }


    // 【モンスターを出現させる処理】
    func appearMonster() {
        if monster1["hp"] == 0 {    // モンスター1がいなかったら
            // 画像を消す
            monsterImage1.image = UIImage(named: "透明")    // 適当に画像いれてるだけ
            monsterImage1.alpha = 0    // ここで透明にしてる
        } else {    // モンスター1がいたら
            // 画像を表示
            monsterImage1.image = UIImage(named: "\(monsterName1)")
        }

        if monster2["hp"] == 0 {
            monsterImage2.image = UIImage(named: "透明")
            monsterImage2.alpha = 0
        } else {
            monsterImage2.image = UIImage(named: "\(monsterName2)")
        }

        if monster3["hp"] == 0 {
            monsterImage3.image = UIImage(named: "透明")
            monsterImage3.alpha = 0
        } else {
            monsterImage3.image = UIImage(named: "\(monsterName3)")
        }

        if monster4["hp"] == 0 {
            monsterImage4.image = UIImage(named: "透明")
            monsterImage4.alpha = 0
        } else {
            monsterImage4.image = UIImage(named: "\(monsterName4)")
        }
    }



    // 【攻撃の処理】
/*
    // 攻撃タイプごとの処理
    func atkType() {
        switch magicNum {
        case: 0    // 通常攻撃

            case: 1    // ヒール
            case: 2    // ひのたま
            case: 3    // つららおとし
            case: 4    // しょうげきは
            case: 5    // ライトビーム
            case: 6    // メガヒール
            case: 7    // スターダスト

        default:
            return
        }
    }

*/



    @IBAction func mainButton(_ sender: UIButton) {    // メインボタン
        if toSelect == true {
            self.performSegue(withIdentifier: "toBattleCommand", sender: nil)    // 画面遷移

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


    }



}
