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
    
    @IBOutlet private weak var princessImageView: UIImageView!
    @IBOutlet private weak var hermitImageView: UIImageView!
    //@IBOutlet weak var textView: UITextView!
//
    var mainButtonTappedCount = 0
//    var button = false

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    /// ボタンView
    private lazy var buttonView = R.nib.buttonView.firstView(owner: nil)!
    /// メッセージView
    private lazy var messageView = R.nib.messageView.firstView(owner: nil)!

    /// メッセージ内容の格納用Enum
    // Enumにする必要はあるのか？
    // これを他の場所で持たせたい
    private enum messageEnum: String {
        case zeroth, first, second, third

        var message: String {
            get {
                switch self {
                case .zeroth:
                    return "＊「ホホホ......。」"
                case .first:
                    return "姫「きゃあ！\n  どなたですか！？」"
                case .second:
                    return "＊「さあ、わたしといっしょに\n  来てもらいますよ......。」"
                case .third:
                    return "姫「きゃー！！」"
                }
            }
        }
    }

    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()

        // ボタンViewを上にもってくる処理を念の為書いたほうが良いかもしれない
        addMessageView()
        addButtonView()
    }

}

// MARK: - Functions

extension Introduction1ViewController {

    /// ボタンViewを追加する
    private func addButtonView() {
        buttonView.frame = view.frame
        view.addSubview(buttonView)

        buttonView.subscribe()

        // メインボタンタップ
        buttonView.mainButtonTappedSubject.subscribe(onNext: { [unowned self] in
            main()
        }).disposed(by: disposeBag)
    }

    /// メッセージViewを追加する
    private func addMessageView() {
        messageView.frame = view.frame
        view.addSubview(messageView)
    }

}

extension Introduction1ViewController {

    /// メインボタンタップされたときの動作
    // 関数名
    private func main() {
        mainButtonTappedCount += 1
        switch mainButtonTappedCount {
        case 1:
            messageView.messageTextView.text = messageEnum.first.message
        case 2:
            messageView.messageTextView.text = messageEnum.second.message
        case 3:
            messageView.messageTextView.text = messageEnum.third.message
        case 4:
            // 遷移処理
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
