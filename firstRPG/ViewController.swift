//
//  ViewController.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2019/08/15.
//  Copyright © 2019 吉澤優衣. All rights reserved.
//

import UIKit
// import SpriteKit    // SpriteKit を使うためインポート

class ViewController: UIViewController {


    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var playerImage: UIImageView!    // プレイヤー

    var currentNum = 241    // プレイヤーの位置が配列の何番めか

    // 配列をくんでやるぜ！！！ (12 * 21 = 252 0スタートだから251まで)
    let line = [
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0,
        0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0,
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
                UIView.animate(withDuration: 1, animations: {
                    self.playerImage.center.y -= self.gameView.frame.size.height / 12
                })


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

            } else if self.line[currentNum] == 0 {
                // 【障害物にあたったとき】
                self.currentNum += 1    // 移動しないんだから配列番号も戻す
            }
        }
    }

    @IBAction func rightButton(_ sender: UIButton) {
        if currentNum + 1 <= 251 {  // 移動先の配列番号が存在するか確認
            self.currentNum += 1    // 配列番号を移動先の番号に変える。(self つけないとボタンが反応してくれなくなる)

            if self.line[currentNum] == 1 {    // 1なら移動可能
                UIView.animate(withDuration: 1, animations: {
                    self.playerImage.center.x += self.gameView.frame.size.width / 21
                })

            } else if self.line[currentNum] == 0 {
                // 【障害物にあたったとき】
                self.currentNum -= 1    // 移動しないんだから配列番号も戻す
            }
        }
    }

    
    @IBAction func downButton(_ sender: UIButton) {
        if currentNum + 21 <= 251 {  // 移動先の配列番号が存在するか確認
            self.currentNum += 21    // 配列番号を移動先の番号に変える。(self つけないとボタンが反応してくれなくなる)

            if self.line[currentNum] == 1 {    // 1なら移動可能
                // 【普通に移動できるとき】
                UIView.animate(withDuration: 1, animations: {
                    self.playerImage.center.y += self.gameView.frame.size.height / 12
                })


            } else if self.line[currentNum] == 0 {
                // 【障害物にあたったとき】
                self.currentNum -= 21    // 移動しないんだから配列番号も戻す
            }
        }
    }
}
