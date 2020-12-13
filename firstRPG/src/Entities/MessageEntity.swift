//
//  MessageEntity.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2020/11/01.
//  Copyright © 2020 吉澤優衣. All rights reserved.
//

/**
 * メッセージEntity
 */
public struct MessageEntity {

    /// メッセージ内容
    let message: String
    /// 男性からのメッセージか
    let isMale: Bool
    /// 選択項目を表示するかどうか
    let shouldShowSelection: Bool
    /// 最後のメッセージかどうか
    let isLastMessage: Bool

}
