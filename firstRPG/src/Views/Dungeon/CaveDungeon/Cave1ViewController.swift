//
//  ViewController.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2019/08/15.
//  Copyright © 2019 吉澤優衣. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa
import AVFoundation

class Cave1ViewController: Dungeon {

    // MARK: - Outlets

    @IBOutlet weak var gameView: UIView!

    @IBOutlet weak var playerImage: UIImageView!

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    private var bgm: AVAudioPlayer!

    /// ボタンView
    private lazy var buttonView = R.nib.buttonView.firstView(owner: nil)!

    /// タイマー
    weak var timer: Timer!

    /// プレイヤーの位置が配列の何番目か
    var currentNum = 241

    /// 歩数のカウント
    var count = 0
    
    // プレイヤー座標
    var playerLeftLocation: CGFloat = 0
    var playerOverLocation: CGFloat = 0

    /**
     * マップの配列
     * - Note: 0: 不可, 1: 可, 2: 前のマップへ遷移, 3: 次のマップへ遷移, 4: 回復ポイント
     */
    let line = [
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 3, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0,
        0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0,
        0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0,
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
        addButtonView()
        subscribe()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let width = view.frame.size.width - gameView.frame.size.width

        let plusWidth = width / 2
        playerLeftLocation = gameView.frame.size.width / 21 * 10 + plusWidth
        playerOverLocation = gameView.frame.size.height / 12 * 11

        let playerFrame = CGRect(x: playerLeftLocation, y: playerOverLocation, width: 27.0, height: 26.5)
        playerImage.frame = playerFrame
        playerImage.image = R.image.hero_up_stop()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 曲を再生
        bgmPrepare(numberOfLoops: -1)
        bgm.play()
    }

    // MARK: - Functions

    private func subscribe() {
        // ボタン長押し
        buttonView.longTapObservable.subscribe(onNext: { [unowned self] buttonType in
            switch buttonType {
            case .up:
                timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(Cave1ViewController.timerUp), userInfo: nil, repeats: true)
            case .left:
                timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(Cave1ViewController.timerLeft), userInfo: nil, repeats: true)
            case .right:
                timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(Cave1ViewController.timerRight), userInfo: nil, repeats: true)
            case .down:
                timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(Cave1ViewController.timerDown), userInfo: nil, repeats: true)
            case .none:
                if let timer = timer {
                    timer.invalidate()
                }
            }
        }).disposed(by: disposeBag)

    }

    /// ボタンViewを追加する
    private func addButtonView() {
        buttonView.frame = view.frame
        view.addSubview(buttonView)

        buttonView.subscribe()
    }

    private func button() {
        
    }
    
    // 上ボタンを押している時
    @objc func timerUp() {
        // 次のマップに遷移するかどうか
        if self.line[currentNum] == 3 {
            timer.invalidate()
            performSegue(withIdentifier: "toCave2", sender: nil)
        }

        playerImage.image = R.image.hero_up_stop()

        if currentNum - 21 >= 0 {  // 移動先の配列番号が存在するか確認
            self.currentNum -= 21    // 配列番号を移動先の番号に変える。(self つけないとボタンが反応してくれなくなる)
            print(currentNum)

            if self.line[currentNum] >= 1 && self.line[currentNum] <= 4 {    // 1-4なら移動可能
                // 【普通に移動できるとき】
                // 1. プレイヤーを移動させる
                UIView.animate(withDuration: 0.6, animations: {
                    print("aaaa")
                    print(self.playerImage.center.y)

                    print(self.playerImage.center.y - self.gameView.frame.size.height / 12)
                    self.playerImage.center.y -= self.gameView.frame.size.height / 12

                    // ☆
                    self.playerImage.image = R.image.hero_up_left_foot()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        self.playerImage.image = R.image.hero_up_right_foot()
                    }

                })
                // 2. 歩数をカウントする
                count += 1

                // 3. エンカウント処理
//                encount()


            } else if self.line[currentNum] == 0 {
                // 【障害物にあたったとき】
                self.currentNum += 21    // 移動しないんだから配列番号も戻す
            }
        }
    }
    
    // 左ボタン
    @objc func timerLeft() {
        playerImage.image = R.image.hero_left_stop()
        if currentNum - 1 >= 0 {  // 移動先の配列番号が存在するか確認
            self.currentNum -= 1    // 配列番号を移動先の番号に変える。(self つけないとボタンが反応してくれなくなる)
            
            if self.line[currentNum] >= 1 && self.line[currentNum] <= 4 {    // 1-4なら移動可能
                UIView.animate(withDuration: 0.6, animations: {
                    self.playerImage.center.x -= self.gameView.frame.size.width / 21
                    
                    // ☆
                    self.playerImage.image = R.image.hero_left_left_foot()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        self.playerImage.image = R.image.hero_left_right_foot()
                    }
                })
                
                // 2. 歩数をカウントする
                count += 1
                
                // 3. エンカウント処理
//                encount()
                
            } else if self.line[currentNum] == 0 {
                // 【障害物にあたったとき】
                self.currentNum += 1    // 移動しないんだから配列番号も戻す
            }
        }
    }
    
    // 右ボタン
    @objc func timerRight() {
        playerImage.image = R.image.hero_right_stop()
        if currentNum + 1 <= 251 {  // 移動先の配列番号が存在するか確認
            self.currentNum += 1    // 配列番号を移動先の番号に変える。(self つけないとボタンが反応してくれなくなる)
            
            if self.line[currentNum] >= 1 && self.line[currentNum] <= 4 {    // 1-4なら移動可能
                UIView.animate(withDuration: 0.6, animations: {
                    self.playerImage.center.x += self.gameView.frame.size.width / 21
                    
                    // ☆
                    self.playerImage.image = R.image.hero_right_left_foot()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        self.playerImage.image = R.image.hero_right_right_foot()
                    }
                })
                
                // 2. 歩数をカウントする
                count += 1
                
                // 3. エンカウント処理
//                encount()
                
            } else if self.line[currentNum] == 0 {
                // 【障害物にあたったとき】
                self.currentNum -= 1    // 移動しないんだから配列番号も戻す
            }
        }
    }
    
    // 下ボタン
    @objc func timerDown() {
        playerImage.image = R.image.hero_down_stop()
        if currentNum + 21 <= 251 {  // 移動先の配列番号が存在するか確認
            self.currentNum += 21    // 配列番号を移動先の番号に変える。(self つけないとボタンが反応してくれなくなる)
            
            if self.line[currentNum] >= 1 && self.line[currentNum] <= 4 {    // 1-4なら移動可能
                // 【普通に移動できるとき】
                UIView.animate(withDuration: 0.6, animations: {
                    self.playerImage.center.y += self.gameView.frame.size.height / 12
                    
                    // ☆
                    self.playerImage.image = R.image.hero_down_left_foot()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        self.playerImage.image = R.image.hero_down_right_foot()
                    }
                })
                
                // 2. 歩数をカウントする
                count += 1
                
                // 3. エンカウント処理
//                encount()
                
                
            } else if self.line[currentNum] == 0 {
                // 【障害物にあたったとき】
                self.currentNum -= 21    // 移動しないんだから配列番号も戻す
            }
        }
    }
    
    
//    // 【敵とエンカウントする処理】を書きたい！
//    func encount() {
////        print("えんかうんと")
//        // 1. エンカウントが発生した時にどのモンスターを何匹出現させるか決定
//        // 何匹か(2匹か4匹)
//        let howMany = Int.random(in: 0...1)    // 0なら2匹、1なら4匹出現
//        switch howMany {
//        case 0:    // 2匹の場合
//            let noMonster = 13
//            let monsterA = Int.random(in: 0...1)    // このマップでは0,1のモンスターが出現。
//            let monsterB = Int.random(in: 0...1)
//            monster = [noMonster, monsterA, monsterB, noMonster]    // バトルシーン遷移時にこの値を渡してモンスターを出現させる。
//
//
//            monster1 = monsterStatus[monster[0]]    // モンスターのステータスを入れる
//            monsterName1 = monsterName[monster[0]]    // 1匹目の名前を取得
//
//            monster2 = monsterStatus[monster[1]]    // モンスターのステータスを入れる
//            monsterName2 = monsterName[monster[1]]    // 1匹目の名前を取得
//
//            monster3 = monsterStatus[monster[2]]    // モンスターのステータスを入れる
//            monsterName3 = monsterName[monster[2]]    // 1匹目の名前を取得
//
//            monster4 = monsterStatus[monster[3]]    // モンスターのステータスを入れる
//            monsterName4 = monsterName[monster[3]]    // 1匹目の名前を取得
//
//
//
//        case 1:    // 4匹の場合
//            let monsterC = Int.random(in: 0...1)
//            let monsterD = Int.random(in: 0...1)
//            let monsterE = Int.random(in: 0...1)
//            let monsterF = Int.random(in: 0...1)
//            monster = [monsterC, monsterD, monsterE, monsterF]
//
//
//            monster1 = monsterStatus[monster[0]]    // モンスターのステータスを入れる
//            monsterName1 = monsterName[monster[0]]    // 1匹目の名前を取得
//
//            monster2 = monsterStatus[monster[1]]    // モンスターのステータスを入れる
//            monsterName2 = monsterName[monster[1]]    // 1匹目の名前を取得
//
//            monster3 = monsterStatus[monster[2]]    // モンスターのステータスを入れる
//            monsterName3 = monsterName[monster[2]]    // 1匹目の名前を取得
//
//            monster4 = monsterStatus[monster[3]]    // モンスターのステータスを入れる
//            monsterName4 = monsterName[monster[3]]    // 1匹目の名前を取得
//
//        default:
//            return
//        }
//
//
//
//
//
//        // 2. どんな条件でエンカウントが発生するのか
//        // まず0-9の乱数を発生させる
//        let int = Int.random(in: 0..<10)
//        switch count {
//        case 2:    // 歩数が2歩の時
//            if int < 1 {    // 乱数が0だったら遷移して戦闘
//                timer.invalidate()
//                performSegue(withIdentifier: "toBattle", sender: nil)
//                print("せんい")
//            }
//        case 5:    // 歩数が5歩の時
//            if int < 6 {     // 乱数が0~5だったら遷移して戦闘
//                timer.invalidate()
//                performSegue(withIdentifier: "toBattle", sender: nil)
//                print("せんい")
//            }
//        case 8:    // 歩数が8歩の時
//            if int < 9 {    // 乱数が0~8だったら遷移して戦闘
//                timer.invalidate()
//                performSegue(withIdentifier: "toBattle", sender: nil)
//                print("せんい")
//            }
//        case 10:    // 歩数が10歩の時
//            timer.invalidate()
//            performSegue(withIdentifier: "toBattle", sender: nil)    // 強制で戦闘
//            print("せんい")
//
//        default:
//            return
//        }
//    }
    
    
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
//            vc.player = player
            
//            // エンカウントしたモンスター情報を渡す
//            vc.monsterName1 = monsterName1
//            vc.monster1 = monster1
//
//            vc.monsterName2 = monsterName2
//            vc.monster2 = monster2
//
//            vc.monsterName3 = monsterName3
//            vc.monster3 = monster3
//
//            vc.monsterName4 = monsterName4
//            vc.monster4 = monster4
            
            // モンスター出現処理を呼ぶ
            vc.toMonsterApper = true
            
            // マップ情報
            vc.toCave1 = true
            
            // プレイヤー座標格納
            playerLeftLocation = playerImage.frame.origin.x
            playerOverLocation = playerImage.frame.origin.y
            vc.playerLeftLocation = playerLeftLocation
            vc.playerOverLocation = playerOverLocation
            
            vc.currentNum = currentNum
            
//            vc.playerApperImage = playerApperImage
            
//            print(playerLeftLocation)
//            print(playerOverLocation)
            
            // ハーミット討伐済かどうか
//            vc.defeatHermit = defeatHermit
            
            
            // cave2への遷移前処理
        } else if (segue.identifier == "toCave2") {
            let vc: cave2ViewController = (segue.destination as? cave2ViewController)!
            
//            vc.player = player
            
            let width = view.frame.size.width - gameView.frame.size.width
            
            let plusWidth = width / 2

            
            vc.playerLeftLocation = gameView.frame.size.width / 21 * 17 + plusWidth
            vc.playerOverLocation = gameView.frame.size.height / 12 * 11
            
            vc.currentNum = 248
            
            vc.playerApperImage = "ヒーロー上1"
            
            // ハーミット討伐済かどうか
//            vc.defeatHermit = defeatHermit
            
            
        }
    }

}

// MARK: - Sounds

extension Cave1ViewController {

    private func bgmPrepare(numberOfLoops: Int) {
        let soundFilePath: String = Bundle.main.path(forResource: "cave_dungeon", ofType: "mp3")!
        let sound: URL = URL(fileURLWithPath: soundFilePath)
        // AVAudioPlayerのインスタンスを作成,ファイルの読み込み
        do {
            bgm = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
        } catch {
            fatalError("Failed to initialize a player.")
        }
        bgm.numberOfLoops = numberOfLoops
        // 再生準備
        bgm.prepareToPlay()
    }

}

// MARK: - MakeInstance

extension Cave1ViewController {

    static func makeInstance() -> UIViewController {
        guard let vc = R.storyboard.cave1ViewController.cave1ViewController() else {
            return UIViewController()
        }
        return vc
    }

}
