//
//  ButtonView.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2020/10/23.
//  Copyright © 2020 吉澤優衣. All rights reserved.
//

import Foundation
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

    // MARK: - Properties

    var mainButtonTappedSubject: PublishSubject<Void> = PublishSubject<Void>()

    private let disposeBag = DisposeBag()

    // MARK: - LifeCycles

    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Functions

    func subscribe() {
        // メインボタンタップ
        mainButton.rx.tap.subscribe(onNext: { [unowned self] in
            self.mainButtonTappedSubject.onNext(())
        }).disposed(by: disposeBag)
    }

}

// MARK: - MakeInstance

extension ButtonView {

    static func makeInstance(owner: AnyObject? = nil, options: [UINib.OptionsKey: Any]? = nil) -> ButtonView {
        return R.nib.buttonView.firstView(owner: owner, options: options)!
    }

}
