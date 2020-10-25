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

/**
 * タイトル画面VC
 */
class AppTopViewController: UIViewController {

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    /// ボタンView
    private lazy var buttonView = R.nib.buttonView.firstView(owner: nil)!

    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addButtonView()
        subscribe()
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
            // 導入ストーリーへ遷移する
            let vc = Introduction1ViewController.makeInstance()
            self.present(vc, animated: true)
        }).disposed(by: disposeBag)
    }

}
