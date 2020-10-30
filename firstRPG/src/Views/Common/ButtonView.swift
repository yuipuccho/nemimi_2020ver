//
//  ButtonView.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2020/10/23.
//  Copyright © 2020 吉澤優衣. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/**
 * 共通ボタンView
 */
class ButtonView: UIView {

    // MARK: - Outlets

    /// メインボタン
    @IBOutlet weak var mainButton: UIButton!
    /// 戻るボタン
    @IBOutlet weak var backButton: UIButton!
    /// 上ボタン
    @IBOutlet weak var upButton: UIButton!
    /// 左ボタン
    @IBOutlet weak var leftButton: UIButton!
    /// 右ボタン
    @IBOutlet weak var rightButton: UIButton!
    /// 下ボタン
    @IBOutlet weak var downButton: UIButton!

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    /// メインボタンタップ
    var mainButtonTappedSubject: PublishSubject<Void> = PublishSubject<Void>()
    /// 戻るボタンタップ
    var backButtonTappedSubject: PublishSubject<Void> = PublishSubject<Void>()
    /// 上ボタンタップ
    var upButtonTappedSubject: PublishSubject<Void> = PublishSubject<Void>()
    /// 左ボタンタップ
    var leftButtonTappedSubject: PublishSubject<Void> = PublishSubject<Void>()
    /// 右ボタンタップ
    var rightButtonTappedSubject: PublishSubject<Void> = PublishSubject<Void>()
    /// 下ボタンタップ
    var downButtonTappedSubject: PublishSubject<Void> = PublishSubject<Void>()

    // MARK: - Functions

    func subscribe() {
        // メインボタンタップ
        mainButton.rx.tap.subscribe(onNext: { [unowned self] in
            self.mainButtonTappedSubject.onNext(())
        }).disposed(by: disposeBag)

        // 戻るボタンタップ
        backButton.rx.tap.subscribe(onNext: { [unowned self] in
            self.backButtonTappedSubject.onNext(())
        }).disposed(by: disposeBag)

        // 上ボタンタップ
        upButton.rx.tap.subscribe(onNext: { [unowned self] in
            self.upButtonTappedSubject.onNext(())
        }).disposed(by: disposeBag)

        // 左ボタンタップ
        leftButton.rx.tap.subscribe(onNext: { [unowned self] in
            self.leftButtonTappedSubject.onNext(())
        }).disposed(by: disposeBag)

        // 右ボタンタップ
        rightButton.rx.tap.subscribe(onNext: { [unowned self] in
            self.rightButtonTappedSubject.onNext(())
        }).disposed(by: disposeBag)

        // 下ボタンタップ
        downButton.rx.tap.subscribe(onNext: { [unowned self] in
            self.downButtonTappedSubject.onNext(())
        }).disposed(by: disposeBag)
    }

}

// MARK: - MakeInstance

extension ButtonView {

    static func makeInstance(owner: AnyObject? = nil, options: [UINib.OptionsKey: Any]? = nil) -> ButtonView {
        return R.nib.buttonView.firstView(owner: owner, options: options)!
    }

}
