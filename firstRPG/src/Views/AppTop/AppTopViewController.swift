//
//  AppTopViewController.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2019/08/29.
//  Copyright © 2019 吉澤優衣. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AVFoundation

/**
 * タイトル画面VC
 */
class AppTopViewController: UIViewController {

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    /// ボタンView
    private lazy var buttonView = R.nib.buttonView.firstView(owner: nil)!

    private var audioPlayerInstance: AVAudioPlayer!

    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addButtonView()
        subscribe()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 曲を再生
        audioPrepare(numberOfLoops: -1)
        audioPlayerInstance.play()
    }

    // MARK: - Functions

    /// ボタンViewを追加する
    private func addButtonView() {
        buttonView.frame = view.frame
        view.addSubview(buttonView)

        buttonView.subscribe()
    }

    private func subscribe() {
        // メインボタンタップ
        buttonView.mainButtonTappedSubject.subscribe(onNext: { [unowned self] in
            audioPlayerInstance.stop()
            // 導入ストーリーへ遷移する
            let vc = Introduction1ViewController.makeInstance()
            self.present(vc, animated: true)
        }).disposed(by: disposeBag)
    }

    private func audioPrepare(numberOfLoops: Int) {
        let soundFilePath: String = Bundle.main.path(forResource: "opening", ofType: "mp3")!
        let sound:URL = URL(fileURLWithPath: soundFilePath)
        // AVAudioPlayerのインスタンスを作成,ファイルの読み込み
        do {
            audioPlayerInstance = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
        } catch {
            fatalError("Failed to initialize a player.")
        }
        audioPlayerInstance.numberOfLoops = numberOfLoops
        // 再生準備
        audioPlayerInstance.prepareToPlay()
    }

}
