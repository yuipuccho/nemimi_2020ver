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
import GhostTypewriter

/**
 * 共通メッセージView
 */
class MessageView: UIView {

    // MARK: - Outlets

    /// メッセージLabel
    @IBOutlet weak var messageLabel: TypewriterLabel!
    /// 選択項目表示View
    @IBOutlet weak var selectMessageView: UIView!

    /// 1つ目の選択項目Label
    @IBOutlet weak var firstOptionLabel: UILabel!
    /// 2つ目の選択項目Label
    @IBOutlet weak var secondOptionLabel: UILabel!

    /// 1つ目の選択項目を選択しているときに表示される"▶"
    @IBOutlet weak var firstSelectionMarkLabel: UILabel!
    /// 2つ目の選択項目を選択しているのときに表示される"▶"
    @IBOutlet weak var secondSelectionMarkLabel: UILabel!

    /// 選択項目の管理用Enum
    enum SelectionType {
        case first
        case second
    }

    // MARK: - Functions

    /// 選択中の項目に"▶"を表示する
    func showSelectionMark(selectedItem: SelectionType) {
        switch selectedItem{
        case .first:
            firstSelectionMarkLabel.text = "▶"
            secondSelectionMarkLabel.text = ""
        case .second:
            firstSelectionMarkLabel.text = ""
            secondSelectionMarkLabel.text = "▶"
        }
    }

}

// MARK: - MakeInstance

extension MessageView {

    static func makeInstance(owner: AnyObject? = nil, options: [UINib.OptionsKey: Any]? = nil) -> MessageView {
        return R.nib.messageView.firstView(owner: owner, options: options)!
    }

}
