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

}

// MARK: - MakeInstance

extension MessageView {

    static func makeInstance(owner: AnyObject? = nil, options: [UINib.OptionsKey: Any]? = nil) -> MessageView {
        return R.nib.messageView.firstView(owner: owner, options: options)!
    }

}
