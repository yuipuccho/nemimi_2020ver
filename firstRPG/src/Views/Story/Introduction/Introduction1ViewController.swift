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

/**
 * 導入ストーリーVC
 * - Note: 姫がハーミットに連れ去られるシーン
 */
class Introduction1ViewController: UIViewController {

    // MARK: - Outlets

    /// ハーミットImageView
    @IBOutlet private weak var hermitImageView: UIImageView!

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    /// ボタンView
    private lazy var buttonView = R.nib.buttonView.firstView(owner: nil)!
    /// メッセージView
    private lazy var messageView = R.nib.messageView.firstView(owner: nil)!

    /// メインボタンをタップした回数
    private var mainButtonTappedCount = 0

    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()

        // ボタンViewを上にもってくる処理を念の為書いたほうが良いかもしれない
        addMessageView()
        addButtonView()

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
            self?.messageView.messageTextView.text = Introduction1Model.messageEnum.zeroth.message
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
        mainButtonTappedCount += 1
        switch mainButtonTappedCount {
        case 1:
            messageView.messageTextView.text = Introduction1Model.messageEnum.first.message
        case 2:
            messageView.messageTextView.text = Introduction1Model.messageEnum.second.message
        case 3:
            messageView.messageTextView.text = Introduction1Model.messageEnum.third.message
        case 4:
            // TODO: 遷移処理を追加する
            return
        default:
            return
        }
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
