//
//  Introduction1ViewController.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2019/08/29.
//  Copyright © 2019 吉澤優衣. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AVFoundation
import GhostTypewriter

/**
 * 導入ストーリーVC
 * - Note: 姫がハーミットに連れ去られるシーン
 */
class Introduction1ViewController: UIViewController {

    // MARK: - ViewModel

    private lazy var viewModel: Introduction1ViewModel = Introduction1ViewModel()

    // MARK: - Outlets

    /// ハーミットImageView
    @IBOutlet private weak var hermitImageView: UIImageView!

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    private var shouldPresentNextVC: Bool = false

    /// ボタンView
    private lazy var buttonView = R.nib.buttonView.firstView(owner: nil)!
    /// メッセージView
    private lazy var messageView = R.nib.messageView.firstView(owner: nil)!

    /// メインボタンをタップした回数
    private var mainButtonTappedCount = 0

    private var audioPlayerInstance: AVAudioPlayer!

    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()

        addMessageView()
        addButtonView()
        // ボタンViewを最前面に配置する（念の為）
        view.bringSubviewToFront(buttonView)

        initialSetting()
        subscribe()

    }

}

// MARK: - Functions

extension Introduction1ViewController {

    /// ボタンViewを追加する
    private func addButtonView() {
        buttonView.frame = view.frame
        view.addSubview(buttonView)

        buttonView.subscribe()
    }

    /// メッセージViewを追加する
    private func addMessageView() {
        messageView.frame = view.frame
        view.addSubview(messageView)
    }

    /// 初期設定
    private func initialSetting() {
        hermitImageView.isHidden = true
        messageView.isHidden = true
        buttonView.mainButton.isEnabled = false

        // 1.0秒後にハーミットを出現させる
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.hermitImageView.isHidden = false
        }

        // 1.5秒後にメッセージを表示し、メインボタンをタップ可にする
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.messageView.isHidden = false    // メッセージ表示
            self?.showMessage()
            self?.buttonView.mainButton.isEnabled = true
        }
    }

}

extension Introduction1ViewController {

    private func subscribe() {
        // メインボタンタップ
        buttonView.mainButtonTappedSubject.subscribe(onNext: { [unowned self] in
            
            mainButtonTapped()
        }).disposed(by: disposeBag)
    }

    /// メインボタンがタップされたときの処理
    private func mainButtonTapped() {
        // shouldPresentNextVCがtrueなら次の画面へ遷移する
        if shouldPresentNextVC {
            presentNextVC()
        } else {
            mainButtonTappedCount += 1
            messageView.messageLabel.completeTypewritingAnimation()
            showMessage()
        }
    }

    private func showMessage() {
        // メッセージ内容、選択項目表示するかどうか、最後のメッセージかどうかを取得する
        let msg = viewModel.message(count: mainButtonTappedCount)

        // メッセージを表示する
        messageView.messageLabel.text = msg.message
        messageView.messageLabel.typingTimeInterval = 0.02
        messageView.messageLabel.startTypewritingAnimation()

        // メッセージ音を再生する
        let n = Int((Double(msg.message.count) * 0.02) * 10)
        audioPrepare(isMale: msg.isMale, numberOfLoops: n)
        audioPlayerInstance.play()

        // メッセージの表示が全て終わったら、画面遷移フラグをtrueに変更する
        if msg.isLastMessage {
            shouldPresentNextVC = true
        }
    }

    /// 次の画面へ遷移する
    private func presentNextVC() {
        let vc = Introduction2ViewController.makeInstance()
        present(vc, animated: true)
    }

    private func audioPrepare(isMale: Bool,  numberOfLoops: Int) {
        var soundFilePath: String = ""
        if isMale {
            soundFilePath = Bundle.main.path(forResource: "voice_male", ofType: "mp3")!
        } else {
            soundFilePath = Bundle.main.path(forResource: "voice_female", ofType: "mp3")!
        }
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

// MARK: - MakeInstance

extension Introduction1ViewController {

    static func makeInstance() -> UIViewController {
        guard let vc = R.storyboard.introduction1ViewController.introduction1ViewController() else {
            return UIViewController()
        }
        return vc
    }

}
