//
//  cave6ViewController.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2019/08/26.
//  Copyright © 2019 吉澤優衣. All rights reserved.
//

import UIKit

class cave6ViewController: UIViewController {
    
    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var playerImage: UIImageView!    // プレイヤー
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var hermitImage: UIImageView!    // ハーミット
    
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    
    weak var timer: Timer!
    
    /// 【プレイヤーのパラメータ】
    //var player: [String: Any] = [:]
    var player:  [String: Any] =  ["name": "ほげぇ", "maxHP": 150, "maxMP": 103, "atk": 80, "def": 520, "nowHP": 150, "nowMP": 103, "exp":6800, "Lv": 20]
    //var player:  [String: Any] = ["name": "ほげぇ", "maxHP": 222, "maxMP": 180, "atk": 2080, "def": 4000, "nowHP": 222, "nowMP": 200, "exp":35000, "Lv": 30]
    var currentNum = 241    // ★プレイヤーの位置が配列の何番めか
    
    var count = 0    // 歩数のカウント
    
    var playerApperImage = ""
    
    var buttonCount = 0    // メインボタンのカウント
    
    var afterBattle: Bool = false    // ハーミットとの戦闘後かどうか
    
    
    // ★プレイヤースタート地点座標
    var playerLeftLocation: CGFloat = 270.5
    var playerOverLocation: CGFloat = 291.5
    
    
    var monster:[Int] = []
    
    // ★配列をくんでやるぜ！！！ (12 * 21 = 252 0スタートだから251まで)
    // 0: 不可, 1: 可, 2: 前のマップへ遷移, 3: 次のマップへ遷移, 4: 回復ポイント
    var line: [Int] = []
    
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
    
    
    // 【モンスター情報】
    var monsterStatus: [[String: Int]] = [
        ["hp": 7, "atk": 5, "def": 16, "agi": 1, "exp": 7, "gold": 1],    // 0. スライム
        ["hp": 10, "atk": 6, "def": 18, "agi": 1, "exp": 8, "gold": 1],    // 1. バット
        ["hp": 15, "atk": 10, "def": 22, "agi": 1, "exp": 15, "gold": 1],    // 2. マタンゴ
        ["hp": 20, "atk": 13, "def": 26, "agi": 1, "exp": 20, "gold": 1],    // 3. ピヨネズミ
        ["hp": 28, "atk": 18, "def": 34, "agi": 1, "exp": 45, "gold": 1],    // 4. レイン
        ["hp": 40, "atk": 24, "def": 45, "agi": 1, "exp": 65, "gold": 1],    // 5. プランタ
        ["hp": 50, "atk": 40, "def": 80, "agi": 1, "exp": 95, "gold": 1],    // 6. ボーン
        ["hp": 80, "atk": 48, "def": 120, "agi": 1, "exp": 133, "gold": 1],    // 7. ラコステ
        ["hp": 100, "atk": 86, "def": 240, "agi": 1, "exp": 238, "gold": 1],    // 8. ナルシカラス
        ["hp": 160, "atk": 140, "def": 270, "agi": 1, "exp": 490, "gold": 1],    // 9. ゴーレム
        ["hp": 190, "atk": 200, "def": 400, "agi": 1, "exp": 650, "gold": 1],    // 10. トロール
        ["hp": 1000, "atk": 50, "def": 150, "agi": 1, "exp": 1000, "gold": 1],    // 11. ハーミット
        ["hp": 2500, "atk": 220, "def": 550, "agi": 1, "exp": 4000, "gold": 1],    // 12. ティグレ
        ["hp": 0, "atk": 0, "def": 0, "agi": 0, "exp": 0, "gold": 0]    // 13. なし
    ]
    
    
    
    
    
    
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
        "ゴーレム",
        "トロール",
        "ハーミット",
        "ティグレ",
        ""
    ]
    
    // ハーミット討伐済かどうか
    var defeatHermit: Bool = false
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("座標")
        print(playerLeftLocation)
        print(playerOverLocation)
        // プレイヤー画像の位置
        let playerFrame = CGRect(x: playerLeftLocation, y: playerOverLocation, width: 27.0, height: 26.5)
        print(playerFrame)
        
        playerImage.frame = playerFrame
        playerImage.image = UIImage(named: "\(playerApperImage)")
        
        if afterBattle == false {    // ハーミットとの戦闘直後でない場合
            textView.isHidden = true    // メッセージを非表示に
        } else {    // ハーミットとの戦闘直後の場合
            textView.isHidden = false    // メッセージを表示
            textView.text = ""
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.textView.text = "ハーミット「この私がやぶれるとは......。」"
            }
        }
        
        if defeatHermit == false {    // ハーミット倒してないとき
            hermitImage.isHidden = false    // ハーミットのアイコンだす
            // 配列
            // 0: 不可, 1: 可, 2: 前のマップへ遷移, 3: 次のマップへ遷移, 4: 回復ポイント, 5: ハーミットの前
            line = [
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 5, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0,
                0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            ]
            
        } else {    // ハーミット倒したあと
            hermitImage.isHidden = true    // ハーミットのアイコン消す
            // 配列
            // 0: 不可, 1: 可, 2: 前のマップへ遷移, 3: 次のマップへ遷移, 4: 回復ポイント, 5: ハーミットの前
            line = [
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0,
                0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            ]
            
        }
        
        
    }
    
    // ステータスバー邪魔だから消す
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    
    
    // メインボタンを押した時の処理
    @IBAction func mainButton(_ sender: Any) {
        if afterBattle == false {    // ハーミットとの戦闘前
            if line[currentNum] == 5 {    // ハーミットの前でメインボタンを押した時
                switch buttonCount {
                case 0:
                    buttonCount += 1    // カウントを +1
                    textView.isHidden = false    // メッセージ表示
                    textView.text = "ハーミット「ホホホ......。\n  こんなところまで 追ってくるとは......。」"
                case 1:
                    buttonCount += 1    // カウントを +1
                    textView.text = "ハーミット「己のおろかさを\n  思い知りなさい......！」"
                case 2:
                    
                    print("2")
                    encount()
                    print("3")
                    performSegue(withIdentifier: "toBattle", sender: nil)
                    print("4")
                default:
                    return
                }
            }
        } else {    // ハーミットとの戦闘後
            switch buttonCount {
            case 0:
                buttonCount += 1    // カウントを +1
                textView.text = "ハーミット「......うぐっ！！」"
            case 1:
                hermitImage.isHidden = true
                textView.isHidden = true
                defeatHermit = true
                line = [
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0,
                    0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                ]
                afterBattle = false
            default:
                return
            }
        }
    }
    
    
    // 上ボタンを押している時 touchDown
    @objc func timerUp() {
        if textView.isHidden == true {    // メッセージがない時のみ移動可能
            
            // ★次のマップに遷移するかどうか
            if self.line[currentNum] == 3 {
                timer.invalidate()
                print("おk")
                performSegue(withIdentifier: "toCave7", sender: nil)
                print("7へせんい")
            }
            
            playerApperImage = "ヒーロー上1"
            
            if currentNum - 21 >= 0 {  // 移動先の配列番号が存在するか確認
                self.currentNum -= 21    // 配列番号を移動先の番号に変える。(self つけないとボタンが反応してくれなくなる)
                print(currentNum)
                
                if self.line[currentNum] >= 1 && self.line[currentNum] <= 5 {    // 1-5なら移動可能
                    // 【普通に移動できるとき】
                    // 1. プレイヤーを移動させる
                    UIView.animate(withDuration: 0.6, animations: {
                        self.playerImage.center.y -= self.gameView.frame.size.height / 12
                        
                        // ☆
                        self.playerImage.image = UIImage(named: "ヒーロー上1")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            self.playerImage.image = UIImage(named: "ヒーロー上2")
                        }
                    })
                    // 2. 歩数をカウントする
                    count += 1
                    
                    if self.line[currentNum] == 4 {    // 回復ポイントに入ったら
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.textView.isHidden = false    // メッセージ表示
                            self.player["nowHP"] = self.player["maxHP"]    // HP回復
                            self.player["nowMP"] = self.player["maxMP"]    // MP回復
                        }
                        
                    } else {
                        // 3. エンカウント処理
                        //encount()
                    }
                    
                    
                } else if self.line[currentNum] == 0 {
                    // 【障害物にあたったとき】
                    self.currentNum += 21    // 移動しないんだから配列番号も戻す
                }
            }
        }
    }
    
    // 左ボタン
    @objc func timerLeft() {
        if textView.isHidden == true {    // メッセージがない時のみ移動可能
            
            
            playerApperImage = "ヒーロー左1"
            
            if currentNum - 1 >= 0 {  // 移動先の配列番号が存在するか確認
                self.currentNum -= 1    // 配列番号を移動先の番号に変える。(self つけないとボタンが反応してくれなくなる)
                
                if self.line[currentNum] >= 1 && self.line[currentNum] <= 5 {    // 1-5なら移動可能
                    UIView.animate(withDuration: 0.6, animations: {
                        self.playerImage.center.x -= self.gameView.frame.size.width / 21
                        
                        // ☆
                        self.playerImage.image = UIImage(named: "ヒーロー左1")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            self.playerImage.image = UIImage(named: "ヒーロー左2")
                        }
                    })
                    
                    // 2. 歩数をカウントする
                    count += 1
                    
                    if self.line[currentNum] == 4 {    // 回復ポイントに入ったら
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.textView.isHidden = false    // メッセージ表示
                            self.player["nowHP"] = self.player["maxHP"]    // HP回復
                            self.player["nowMP"] = self.player["maxMP"]    // MP回復
                        }
                        
                    } else {
                        // 3. エンカウント処理
                        //encount()
                    }
                    
                } else if self.line[currentNum] == 0 {
                    // 【障害物にあたったとき】
                    self.currentNum += 1    // 移動しないんだから配列番号も戻す
                }
            }
        }
    }
    
    // 右ボタン
    @objc func timerRight() {
        if textView.isHidden == true {    // メッセージがない時のみ移動可能
            
            playerApperImage = "ヒーロー右1"
            
            
            if currentNum + 1 <= 251 {  // 移動先の配列番号が存在するか確認
                self.currentNum += 1    // 配列番号を移動先の番号に変える。(self つけないとボタンが反応してくれなくなる)
                
                if self.line[currentNum] >= 1 && self.line[currentNum] <= 5 {    // 1-5なら移動可能
                    UIView.animate(withDuration: 0.6, animations: {
                        self.playerImage.center.x += self.gameView.frame.size.width / 21
                        
                        // ☆
                        self.playerImage.image = UIImage(named: "ヒーロー右1")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            self.playerImage.image = UIImage(named: "ヒーロー右2")
                        }
                    })
                    
                    // 2. 歩数をカウントする
                    count += 1
                    
                    if self.line[currentNum] == 4 {    // 回復ポイントに入ったら
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.textView.isHidden = false    // メッセージ表示
                            self.player["nowHP"] = self.player["maxHP"]    // HP回復
                            self.player["nowMP"] = self.player["maxMP"]    // MP回復
                        }
                        
                    } else {
                        // 3. エンカウント処理
                        //encount()
                    }
                    
                } else if self.line[currentNum] == 0 {
                    // 【障害物にあたったとき】
                    self.currentNum -= 1    // 移動しないんだから配列番号も戻す
                }
            }
        }
    }
    
    // 下ボタン
    @objc func timerDown() {
        if textView.isHidden == true {    // メッセージがない時のみ移動可能
            
            playerApperImage = "ヒーロー下1"
            
            // ★前のマップに遷移するかどうか
            if self.line[currentNum] == 2 {
                timer.invalidate()
                print("おk")
                performSegue(withIdentifier: "toCave5", sender: nil)
                print("5へせんい")
            }
            
            if currentNum + 21 <= 251 {  // 移動先の配列番号が存在するか確認
                self.currentNum += 21    // 配列番号を移動先の番号に変える。(self つけないとボタンが反応してくれなくなる)
                
                if self.line[currentNum] >= 1 && self.line[currentNum] <= 5 {    // 1-5なら移動可能
                    // 【普通に移動できるとき】
                    UIView.animate(withDuration: 0.6, animations: {
                        self.playerImage.center.y += self.gameView.frame.size.height / 12
                        
                        // ☆
                        self.playerImage.image = UIImage(named: "ヒーロー下1")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            self.playerImage.image = UIImage(named: "ヒーロー下2")
                        }
                    })
                    
                    // 2. 歩数をカウントする
                    count += 1
                    
                    if self.line[currentNum] == 4 {    // 回復ポイントに入ったら
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.textView.isHidden = false    // メッセージ表示
                            self.player["nowHP"] = self.player["maxHP"]    // HP回復
                            self.player["nowMP"] = self.player["maxMP"]    // MP回復
                        }
                        
                    } else {
                        // 3. エンカウント処理
                        //encount()
                    }
                    
                    
                } else if self.line[currentNum] == 0 {
                    // 【障害物にあたったとき】
                    self.currentNum -= 21    // 移動しないんだから配列番号も戻す
                }
            }
        }
    }
    
    
    // 【敵とエンカウントする処理】を書きたい！
    func encount() {
        
        // ハーミットとの戦闘
        let monsterA = 11    // ハーミット
        let monsterB = 7    // ラコステ
        let noMonster = 13
        monster = [noMonster, monsterA, monsterB, noMonster]
        
        monster1 = monsterStatus[monster[0]]    // モンスターのステータスを入れる
        monsterName1 = monsterName[monster[0]]    // 1匹目の名前を取得
        
        monster2 = monsterStatus[monster[1]]    // モンスターのステータスを入れる
        monsterName2 = monsterName[monster[1]]    // 2匹目の名前を取得
        
        monster3 = monsterStatus[monster[2]]    // モンスターのステータスを入れる
        monsterName3 = monsterName[monster[2]]    // 3匹目の名前を取得
        
        monster4 = monsterStatus[monster[3]]    // モンスターのステータスを入れる
        monsterName4 = monsterName[monster[3]]    // 4匹目の名前を取得
        
    }
    
    
    // 3. 画面遷移で渡す値
    // 1. モンスター情報
    // 2. プレイヤー情報
    // それ以外なんかあるっけ
    
    // segue遷移前動作
    // セグエ実行前処理 / セグエの identifier 確認 / 遷移先ViewController の取得
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // バトル画面への遷移前処理
        if (segue.identifier == "toBattle") {
            
            let vc: battleMessageViewController = (segue.destination as? battleMessageViewController)!
            
            // プレイヤーの情報
            vc.player = player
            
            // エンカウントしたモンスター情報を渡す
            vc.monsterName1 = monsterName1
            vc.monster1 = monster1
            print(monsterName1)
            print(monster1)
            
            vc.monsterName2 = monsterName2
            vc.monster2 = monster2
            print(monsterName2)
            print(monster2)
            
            vc.monsterName3 = monsterName3
            vc.monster3 = monster3
            print(monsterName3)
            print(monster3)
            
            vc.monsterName4 = monsterName4
            vc.monster4 = monster4
            print(monsterName4)
            print(monster4)
            
            // モンスター出現処理を呼ぶ
            vc.toMonsterApper = true
            
            // ★マップ情報
            vc.toCave6 = true
            
            // プレイヤー座標格納
            playerLeftLocation = playerImage.frame.origin.x
            playerOverLocation = playerImage.frame.origin.y
            vc.playerLeftLocation = playerLeftLocation
            vc.playerOverLocation = playerOverLocation
            
            vc.currentNum = currentNum
            
            print(playerLeftLocation)
            print(playerOverLocation)
            
            vc.playerApperImage = "ヒーロー上1"
            
            // ハーミット討伐済かどうか
            vc.defeatHermit = defeatHermit
            
            
            // ★cave5への遷移前処理
        } else if (segue.identifier == "toCave5") {
            let vc: cave5ViewController = (segue.destination as? cave5ViewController)!
            
            vc.player = player
            
            let width = view.frame.size.width - gameView.frame.size.width

            let plusWidth = width / 2

            
            vc.playerLeftLocation = gameView.frame.size.width / 21 * 10 + plusWidth
            vc.playerOverLocation = gameView.frame.size.height / 12 * 3
            
            vc.currentNum = 73
            
            vc.playerApperImage = "ヒーロー下1"
            
            // ハーミット討伐済かどうか
            vc.defeatHermit = defeatHermit
            
            
            
            
            // ★cave7への遷移前処理
        } else if (segue.identifier == "toCave7") {
            let vc: cave7ViewController = (segue.destination as? cave7ViewController)!
            
            vc.player = player
            
            let width = view.frame.size.width - gameView.frame.size.width

            let plusWidth = width / 2

            
            vc.playerLeftLocation = gameView.frame.size.width / 21 * 10 + plusWidth
            vc.playerOverLocation = gameView.frame.size.height / 12 * 11 
            
            vc.playerApperImage = "ヒーロー上1"
            
            // ハーミット討伐済かどうか
            vc.defeatHermit = defeatHermit
            
        }
        
    }
    
    // 上ボタン長押し
    @IBAction func upButtonLongTap(_ sender: UILongPressGestureRecognizer) {
        
        if(sender.state == UIGestureRecognizer.State.began) {
            timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(Cave1ViewController.timerUp), userInfo: nil, repeats: true)
            
        } else if (sender.state == UIGestureRecognizer.State.ended) {
            timer.invalidate()
        }
    }
    
    
    // 左ボタン長押し
    @IBAction func leftButtonLongTap(_ sender: UILongPressGestureRecognizer) {
        if(sender.state == UIGestureRecognizer.State.began) {
            timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(Cave1ViewController.timerLeft), userInfo: nil, repeats: true)
            
        } else if (sender.state == UIGestureRecognizer.State.ended) {
            timer.invalidate()
        }
    }
    
    
    @IBAction func rightButtonLongTap(_ sender: UILongPressGestureRecognizer) {
        if(sender.state == UIGestureRecognizer.State.began) {
            timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(Cave1ViewController.timerRight), userInfo: nil, repeats: true)
            
        } else if (sender.state == UIGestureRecognizer.State.ended) {
            timer.invalidate()
        }
    }
    
    
    @IBAction func downButtonLongTap(_ sender: UILongPressGestureRecognizer) {
        if(sender.state == UIGestureRecognizer.State.began) {
            timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(Cave1ViewController.timerDown), userInfo: nil, repeats: true)
            
        } else if (sender.state == UIGestureRecognizer.State.ended) {
            timer.invalidate()
        }
    }
}



