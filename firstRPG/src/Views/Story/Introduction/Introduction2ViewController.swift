//
//  Introduction2ViewController.swift
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
 * 導入ストーリーVC
 * - Note: 王様に助けを求められるシーン
 */
class Introduction2ViewController: UIViewController {

    // MARK: - ViewModel

    private lazy var viewModel: Introduction2ViewModel = Introduction2ViewModel()

    // MARK: - Outlets

    /// 王様ImageView
    @IBOutlet weak var kingImageView: UIImageView!

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    /// ボタンView
    private lazy var buttonView = R.nib.buttonView.firstView(owner: nil)!
    /// メッセージView
    private lazy var messageView = R.nib.messageView.firstView(owner: nil)!

    /// メインボタンをタップした回数
    private var mainButtonTappedCount = 0

    /// 選択中の項目
    private var selectedItem: MessageView.SelectionType = .first

    /// 次のメッセージへ進むことができるか
    private var canProceed: Bool = true

    /// 次の画面に遷移するか
    private var shouldPresentNextVC: Bool = false

    private var voice: AVAudioPlayer!

    private var bgm: AVAudioPlayer!

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

extension Introduction2ViewController {

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
        kingImageView.isHidden = true
        messageView.isHidden = true
        buttonView.mainButton.isEnabled = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            // 曲を再生
            self?.bgmPrepare(numberOfLoops: -1)
            self?.bgm.play()
            // メッセージを表示し、メインボタンを使用可能にする
            self?.messageView.isHidden = false
            self?.showMessage()
            self?.buttonView.mainButton.isEnabled = true
        }
    }

}

extension Introduction2ViewController {

    private func subscribe() {
        // メインボタンタップ
        buttonView.mainButtonTappedSubject.subscribe(onNext: { [unowned self] in
            mainButtonTapped()
        }).disposed(by: disposeBag)

        // 上ボタンタップ
        buttonView.upButtonTappedSubject.subscribe(onNext: { [unowned self] in
            upButtonTapped()
        }).disposed(by: disposeBag)

        // 下ボタンタップ
        buttonView.downButtonTappedSubject.subscribe(onNext: { [unowned self] in
            downButtonTapped()
        }).disposed(by: disposeBag)
    }

    /// メインボタンがタップされたときの処理
    private func mainButtonTapped() {
        // shouldPresentNextVCがtrueなら次の画面へ遷移する
        if shouldPresentNextVC {
            bgm.stop()
            presentNextVC()
        } else {
            mainButtonTappedCount += 1
            // 王様を表示
            kingImageView.isHidden = false

            // メッセージを表示する
            messageView.messageLabel.completeTypewritingAnimation()
            showMessage()
        }
    }

    /// 上ボタンがタップされたときの処理
    private func upButtonTapped() {
        selectedItem = .first
        messageView.showSelectionMark(selectedItem: selectedItem)
        canProceed = true
    }

    /// 下ボタンがタップされたときの処理
    private func downButtonTapped() {
        selectedItem = .second
        messageView.showSelectionMark(selectedItem: selectedItem)
        canProceed = false
    }

    /// メッセージの表示処理
    private func showMessage() {
        // メッセージ内容、選択項目表示するかどうか、最後のメッセージかどうかを取得する
        let msg = viewModel.message(count: mainButtonTappedCount, canProceed: canProceed)

        // メッセージを表示する
        messageView.messageLabel.text = msg.message
        messageView.messageLabel.typingTimeInterval = 0.02
        messageView.messageLabel.startTypewritingAnimation()

        // メッセージ音を再生する
        let n = Int((Double(msg.message.count) * 0.02) * 10)
        voicePrepare(isMale: msg.isMale, numberOfLoops: n)
        voice.play()

        // shouldShowSelectionがtrueなら選択項目を表示する
        if msg.shouldShowSelection {
            messageView.selectMessageView.isHidden = false
            selectedItem = .first
            messageView.showSelectionMark(selectedItem: selectedItem)
        } else {
            messageView.selectMessageView.isHidden = true
        }

        // 次のメッセージへ進めない場合はタップカウントを戻す
        if !canProceed {
            mainButtonTappedCount -= 2
            canProceed = true
        }

        // メッセージの表示が全て終わったら、画面遷移フラグをtrueに変更する
        if msg.isLastMessage {
            shouldPresentNextVC = true
        }
    }

    /// 次の画面へ遷移する
    private func presentNextVC() {
        let vc = Cave1ViewController.makeInstance()
        present(vc, animated: true)
    }

}

// MARK: - Sounds

extension Introduction2ViewController {

    private func bgmPrepare(numberOfLoops: Int) {
        let soundFilePath: String = Bundle.main.path(forResource: "quest", ofType: "mp3")!
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

    private func voicePrepare(isMale: Bool,  numberOfLoops: Int) {
        var soundFilePath: String = ""
        if isMale {
            soundFilePath = Bundle.main.path(forResource: "voice_male", ofType: "mp3")!
        } else {
            soundFilePath = Bundle.main.path(forResource: "voice_female", ofType: "mp3")!
        }
        let sound:URL = URL(fileURLWithPath: soundFilePath)
        // AVAudioPlayerのインスタンスを作成,ファイルの読み込み
        do {
            voice = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
        } catch {
            fatalError("Failed to initialize a player.")
        }
        voice.numberOfLoops = numberOfLoops
        // 再生準備
        voice.prepareToPlay()
    }

}

// MARK: - MakeInstance

extension Introduction2ViewController {

    static func makeInstance() -> UIViewController {
        guard let vc = R.storyboard.introduction2ViewController.introduction2ViewController() else {
            return UIViewController()
        }
        return vc
    }

}
