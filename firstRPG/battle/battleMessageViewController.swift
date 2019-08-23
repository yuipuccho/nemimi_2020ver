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

    var receiveHp = 0
    var receiveMp = 0
    var receiveLv = 0


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


    /// メインボタンを押した時に画面遷移するかどうか判断
    var toSelect: Bool = false



    /// 【プレイヤーのパラメータ】
    var player: [String: Any] = [
        "name": "ほげほげ",
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


    // 【モンスターデータ共通の入れ物】
    var monsterData: [String: Int] = [
        "maxHP": 0,    // 最大HP
        "atk": 0,    // 攻撃力
        "def": 0,    // 守備力
        "agi": 0,    // すばやさ
        "exp": 0,    // 経験値
        "gold": 0    // ゴールド
    ]

    // 【モンスター情報】
    var monsterStatus: [[String: Int]] = [
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1],    // 0. スライム
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1],    // 1. バット
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1],    // 2. マタンゴ
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1],    // 3. ピヨネズミ
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1],    // 4. レイン
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1],    // 5. プランタ
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1],    // 6. ボーン
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1],    // 7. ラコステ
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1],    // 8. ナルシカラス
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1],    // 9. ゴーレム
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1],    // 10. トロール
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1],    // ハーミット
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1]    // ティグレ
    ]

    //let a = monsterStatus[0]["hp"]
    //print(a!)




    // モンスターの名前
    let monsterName: [String] = [
        "スライム",
        "バット",
        "マタンゴ",
        "ピヨネズミ",
        "レイン",
        "プランタ",
        "ボーン",
        "ラコステ",
        "ナルシカラス",
        "ナルシカラス",
        "ゴーレム",
        "トロール",
        "ハーミット",
        "ティグレ"
    ]





    override func viewDidLoad() {
        super.viewDidLoad()
        // 画面にモンスター画像を表示
        appearMonster()

/*
        // プレイヤー情報を表示する（画面左上のとこ）
        hp =  player["nowHP"] as! Int
        mp =  player["nowMP"] as! Int
        lv =  player["Lv"] as! Int

        nameLabel.text = player["name"] as? String
        hpLabel.text = "HP: \(hp)"
        mpLabel.text = "MP: \(mp)"
        lvLabel.text = "Lv: \(lv)"
 */

        // 画面遷移OK
        toSelect = true

        print("a")
    }
        

    override func viewWillAppear(_ animated: Bool) {
        // プレイヤー情報
        /*
        player["nowHP"] = receiveHp
        player["nowMP"] = receiveMp
        player["Lv"] = receiveLv
 */

        hp = player["nowHP"] as! Int
        mp = player["nowMP"] as! Int
        lv = player["Lv"] as! Int

        nameLabel.text = player["name"] as? String
        hpLabel.text = "HP: \(hp)"
        mpLabel.text = "MP: \(mp)"
        lvLabel.text = "Lv: \(lv)"

    }


    // 【モンスターを出現させる処理】
    func appearMonster() {
        // モンスター何匹出現させる？
        switch monster.count {
        case 2:    // 2匹なら
            // どのモンスター？
            // 1匹目
            monsterName2 = monsterName[monster[0]]    // 1匹目の名前を取得
            monsterImage2.image = UIImage(named: "\(monsterName2)")    // 1匹目の画像を表示
            monster2 = monsterStatus[monster[0]]    // モンスターのステータスを入れる
            // 2匹目
            monsterName3 = monsterName[monster[1]]    // 2匹目の名前を取得
            monsterImage3.image = UIImage(named: "\(monsterName3)")    // 2匹目の画像を表示
            monster3 = monsterStatus[monster[1]]    // モンスターのステータスを入れる

            monster1 = ["hp": 0]    // 2匹の出現なので消す
            monster4 = ["hp": 0]    // 2匹の出現なので消す

        case 4:    // 4匹なら
            // どのモンスター？
            // 1匹目
            monsterName1 = monsterName[monster[0]]    // 1匹目の名前を取得
            monsterImage1.image = UIImage(named: "\(monsterName1)")    // 1匹目の画像を表示
            monster1 = monsterStatus[monster[0]]    // モンスターのステータスを入れる
            // 2匹目
            monsterName2 = monsterName[monster[1]]    // 2匹目の名前を取得
            monsterImage2.image = UIImage(named: "\(monsterName2)")    // 2匹目の画像を表示
            monster2 = monsterStatus[monster[1]]    // モンスターのステータスを入れる
            // 3匹目
            monsterName3 = monsterName[monster[2]]    // 3匹目の名前を取得
            monsterImage3.image = UIImage(named: "\(monsterName3)")    // 3匹目の画像を表示
            monster3 = monsterStatus[monster[2]]    // モンスターのステータスを入れる
            // 4匹目
            monsterName4 = monsterName[monster[3]]    // 4匹目の名前を取得
            monsterImage4.image = UIImage(named: "\(monsterName4)")    // 4匹目の画像を表示
            monster4 = monsterStatus[monster[3]]    // モンスターのステータスを入れる

        default:
            return
        }
    }


    // 【攻撃の処理】

    


    @IBAction func mainButton(_ sender: UIButton) {    // メインボタン
        if toSelect == true {
player["nowHP"] = 30
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

        //vc.hp = player["nowHP"] as! Int
        vc.mp = player["nowMP"] as! Int
        vc.lv = player["Lv"] as! Int


        // 2. 生き残ってるモンスター
        if monster1["hp"]! > 0 {
            vc.monsterName1 = monsterName1
            vc.monster1 = monster1
        }
        if monster2["hp"]! > 0 {
            vc.monsterName2 = monsterName2
            vc.monster2 = monster2
        }
        if monster3["hp"]! > 0 {
            vc.monsterName3 = monsterName3
            vc.monster3 = monster3
        }
        if monster4["hp"]! > 0 {
            vc.monsterName4 = monsterName4
            vc.monster4 = monster4
        }



        //vc.select = selectNum
    }



}
