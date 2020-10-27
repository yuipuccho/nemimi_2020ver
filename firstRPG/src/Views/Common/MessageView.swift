//
//  MessageView.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2020/10/25.
//  Copyright © 2020 吉澤優衣. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/**
 * 共通メッセージView
 */
class MessageView: UIView {

    // MARK: - Outlets

    /// メッセージTextView
    @IBOutlet weak var messageTextView: UITextView!
    /// 選択項目表示View
    @IBOutlet weak var selectMessageView: UIView!

    /// 1つ目の選択項目Label
    @IBOutlet weak var firstOptionLabel: UILabel!
    /// 2つ目の選択項目Label
    @IBOutlet weak var secondOptionLabel: UILabel!

    /// 1つ目の選択項目を選択しているときに表示される"▶"
    @IBOutlet weak var firstSelectionMarkLabel: UILabel!
    /// 2つ目の選択項目を選択しているのときに表示される"▶"
    @IBOutlet weak var secondselectionMarkLabel: UILabel!

    // MARK: - Functions

    func setupSelectMessageView() {
        firstSelectionMarkLabel.text = "▶"
        secondselectionMarkLabel.text = ""
    }

}

// MARK: - MakeInstance

extension MessageView {

    static func makeInstance(owner: AnyObject? = nil, options: [UINib.OptionsKey: Any]? = nil) -> MessageView {
        return R.nib.messageView.firstView(owner: owner, options: options)!
    }

}
