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

    /// コメント
    private var canProceed: Bool = true

    /// 次の画面に遷移するか
    private var shouldPresentNextVC: Bool = false

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
            presentNextVC()
        }

        mainButtonTappedCount += 1

        // 王様を表示
        kingImageView.isHidden = false

        // メッセージを表示する
        showMessage()
    }

    /// 上ボタンがタップされたときの処理
    private func upButtonTapped() {
        //このへんmessageViewでできそう
        messageView.firstSelectionMarkLabel.text = "▶"
        messageView.secondselectionMarkLabel.text = nil
        canProceed = true
    }

    /// 下ボタンがタップされたときの処理
    private func downButtonTapped() {
        messageView.firstSelectionMarkLabel.text = nil
        messageView.secondselectionMarkLabel.text = "▶"
        canProceed = false
    }

    /// メッセージの表示処理
    private func showMessage() {
        // メッセージ内容、選択項目表示するかどうか、最後のメッセージかどうかを取得する
        guard let msg = viewModel.message(count: mainButtonTappedCount, canProceed: canProceed),
              let message: String = msg["message"] as? String,
              let shouldShowSelection: Bool = msg["shouldShowSelection"] as? Bool,
              let isLastMessage: Bool = msg["isLastMessage"] as? Bool else { return }

        // メッセージを表示する
        messageView.messageTextView.text = message

        // shouldShowSelectionがtrueなら選択項目を表示する
        if shouldShowSelection {
            messageView.selectMessageView.isHidden = false
            messageView.setupSelectMessageView()
        } else {
            messageView.selectMessageView.isHidden = true
        }

        // 次のメッセージへ進めない場合はタップカウントを戻す
        if !canProceed {
            mainButtonTappedCount -= 2
            canProceed = true
        }

        // メッセージの表示が全て終わったら、画面遷移フラグをtrueに変更する
        if isLastMessage {
            shouldPresentNextVC = true
        }
    }

    /// 次の画面へ遷移する
    private func presentNextVC() {
        // TODO: 遷移処理を追加する
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
