//
//  ViewController.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2019/08/15.
//  Copyright © 2019 吉澤優衣. All rights reserved.
//

import UIKit
// import SpriteKit    // SpriteKit を使うためインポート

class cave1ViewController: UIViewController {


    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var playerImage: UIImageView!    // プレイヤー

    var currentNum = 241    // プレイヤーの位置が配列の何番めか

    var count = 0    // 歩数のカウント

    var monster:[Int] = []

    // 配列をくんでやるぜ！！！ (12 * 21 = 252 0スタートだから251まで)
    let line = [
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0,
        0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0,
        0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0,
        0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0
    ]



    override func viewDidLoad() {
        super.viewDidLoad()

/*        // SKViewに型を変換する
        let skView = self.view as! SKView

        // FPSを表示する。アプリの動きをわかりやすくするため。
        skView.showsFPS = true

        // ノードの数を表示する。アプリの動きをわかりやすくするため。
        skView.showsNodeCount = true

        // SKSceneはサイズを指定して作成。Viewと同じサイズでシーンを作成する。
        let scene = GameScene(size:skView.frame.size)

        // ビューにシーンを表示する。ここで SKScene を設定。
        skView.presentScene(scene)
 */
    }

    // ステータスバー邪魔だから消す
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }



    // 上ボタンを押している時 touchDown
    @IBAction func upButton(_ sender: UIButton) {
        if currentNum - 21 >= 0 {  // 移動先の配列番号が存在するか確認
            self.currentNum -= 21    // 配列番号を移動先の番号に変える。(self つけないとボタンが反応してくれなくなる)

            if self.line[currentNum] == 1 {    // 1なら移動可能
                // 【普通に移動できるとき】
                // 1. プレイヤーを移動させる
                UIView.animate(withDuration: 1, animations: {
                    self.playerImage.center.y -= self.gameView.frame.size.height / 12
                })
                // 2. 歩数をカウントする
                count += 1

                // 3. エンカウント処理
                encount()


            } else if self.line[currentNum] == 0 {
                // 【障害物にあたったとき】
                self.currentNum += 21    // 移動しないんだから配列番号も戻す
            }
        }
    }

    // 左ボタン
    @IBAction func leftButton(_ sender: UIButton) {
        if currentNum - 1 >= 0 {  // 移動先の配列番号が存在するか確認
            self.currentNum -= 1    // 配列番号を移動先の番号に変える。(self つけないとボタンが反応してくれなくなる)

            if self.line[currentNum] == 1 {    // 1なら移動可能
                UIView.animate(withDuration: 1, animations: {
                    self.playerImage.center.x -= self.gameView.frame.size.width / 21
                })

                // 2. 歩数をカウントする
                count += 1

                // 3. エンカウント処理
                encount()

            } else if self.line[currentNum] == 0 {
                // 【障害物にあたったとき】
                self.currentNum += 1    // 移動しないんだから配列番号も戻す
            }
        }
    }

    // 右ボタン
    @IBAction func rightButton(_ sender: UIButton) {
        if currentNum + 1 <= 251 {  // 移動先の配列番号が存在するか確認
            self.currentNum += 1    // 配列番号を移動先の番号に変える。(self つけないとボタンが反応してくれなくなる)

            if self.line[currentNum] == 1 {    // 1なら移動可能
                UIView.animate(withDuration: 1, animations: {
                    self.playerImage.center.x += self.gameView.frame.size.width / 21
                })

                // 2. 歩数をカウントする
                count += 1

                // 3. エンカウント処理
                encount()

            } else if self.line[currentNum] == 0 {
                // 【障害物にあたったとき】
                self.currentNum -= 1    // 移動しないんだから配列番号も戻す
            }
        }
    }

    // 下ボタン
    @IBAction func downButton(_ sender: UIButton) {
        if currentNum + 21 <= 251 {  // 移動先の配列番号が存在するか確認
            self.currentNum += 21    // 配列番号を移動先の番号に変える。(self つけないとボタンが反応してくれなくなる)

            if self.line[currentNum] == 1 {    // 1なら移動可能
                // 【普通に移動できるとき】
                UIView.animate(withDuration: 1, animations: {
                    self.playerImage.center.y += self.gameView.frame.size.height / 12
                })

                // 2. 歩数をカウントする
                count += 1

                // 3. エンカウント処理
                encount()


            } else if self.line[currentNum] == 0 {
                // 【障害物にあたったとき】
                self.currentNum -= 21    // 移動しないんだから配列番号も戻す
            }
        }
    }


    // 【敵とエンカウントする処理】を書きたい！
    func encount() {
        // 1. エンカウントが発生した時にどのモンスターを何匹出現させるか決定
        // 何匹か(2匹か4匹)
        let howMany = Int.random(in: 0...1)    // 0なら2匹、1なら4匹出現
        switch howMany {
        case 0:    // 2匹の場合
            let noMonster = 13
            let monster1 = Int.random(in: 0...1)    // このマップでは0,1のモンスターが出現。
            let monster2 = Int.random(in: 0...1)
            monster = [noMonster, monster1, monster2, noMonster]    // バトルシーン遷移時にこの値を渡してモンスターを出現させる。
        case 1:    // 4匹の場合
            let monster3 = Int.random(in: 0...1)
            let monster4 = Int.random(in: 0...1)
            let monster5 = Int.random(in: 0...1)
            let monster6 = Int.random(in: 0...1)
            monster = [monster3, monster4, monster5, monster6]
        default:
            return
        }


        // 2. どんな条件でエンカウントが発生するのか
        // まず0-9の乱数を発生させる
        let int = Int.random(in: 0..<10)
        switch count {
        case 2:    // 歩数が2歩の時
            if int < 1 {    // 乱数が0だったら遷移して戦闘
                performSegue(withIdentifier: "toBattle", sender: nil)
            }
        case 5:    // 歩数が5歩の時
            if int < 6 {     // 乱数が0~5だったら遷移して戦闘
                performSegue(withIdentifier: "toBattle", sender: nil)
            }
        case 8:    // 歩数が8歩の時
            if int < 9 {    // 乱数が0~8だったら遷移して戦闘
                performSegue(withIdentifier: "toBattle", sender: nil)
            }
        case 10:    // 歩数が10歩の時
            performSegue(withIdentifier: "toBattle", sender: nil)    // 強制で戦闘

        default:
            return
        }
    }


    // 3. 画面遷移で渡す値
    // 1. モンスター情報
    // 2. プレイヤー情報
    // それ以外なんかあるっけ

    // segue遷移前動作
    // セグエ実行前処理 / セグエの identifier 確認 / 遷移先ViewController の取得
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toBattle", let vc = segue.destination as? battleMessageViewController else {
            return
        }
        vc.monster = monster    // エンカウントしたモンスター情報を渡す
    }







}
