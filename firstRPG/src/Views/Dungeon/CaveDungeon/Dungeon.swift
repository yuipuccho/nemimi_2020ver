//
//  Dungeon.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2020/12/13.
//  Copyright © 2020 吉澤優衣. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa
import AVFoundation

class Dungeon: UIViewController {

    // MARK: Properties

    private let disposeBag = DisposeBag()

    var bgm: AVAudioPlayer!

    /// ボタンView
    lazy var buttonView = R.nib.buttonView.firstView(owner: nil)!

    /// タイマー
    weak var timer: Timer!

    /// プレイヤーの位置が配列の何番目か
    var currentNum: Int = 0

    /// 歩数のカウント
    var count: Int = 0

    // プレイヤー座標
    var playerLeftLocation: CGFloat = 0
    var playerOverLocation: CGFloat = 0

    /**
     * マップの配列
     * - Note: 0: 不可, 1: 可, 2: 前のマップへ遷移, 3: 次のマップへ遷移, 4: 回復ポイント
     */
    var mapInformationArray: [Int] = []

    override func viewDidLoad() {
        print("よばれるよ")
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 曲を再生
        bgmPrepare(numberOfLoops: -1)
        bgm.play()
    }

    // MARK: - Functions
    
    func subscribe() {
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
    func addButtonView() {
        buttonView.frame = view.frame
        view.addSubview(buttonView)

        buttonView.subscribe()
    }
    
    

}

// MARK: - Sounds

extension Dungeon {

    func bgmPrepare(numberOfLoops: Int) {
        let soundFilePath: String = Bundle.main.path(forResource: "cave_dungeon", ofType: "mp3")!
        let sound: URL = URL(fileURLWithPath: soundFilePath)
        // AVAudioPlayerのインスタンスを作成,ファイルの読み込み
        do {
            bgm = try AVAudioPlayer(contentsOf: sound, fileTypeHint: nil)
        } catch {
            fatalError("Failed to initialize a player.")
        }
        bgm.numberOfLoops = numberOfLoops
        // 再生準備
        bgm.prepareToPlay()
    }

}
