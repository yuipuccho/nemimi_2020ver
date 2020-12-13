//
//  Introduction1ViewModel.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2020/10/30.
//  Copyright © 2020 吉澤優衣. All rights reserved.
//

class Introduction1ViewModel {

    // MARK: - Functions

    /**
     * メッセージ内容
     * - Parameters:
     *  - count: 表示するメッセージnumber
     */
    func message(count: Int) -> MessageEntity {
        /// メッセージ内容
        var message: String = ""
        /// 男性からのメッセージか
        var isMale: Bool = true
        /// 選択肢を表示するか
        let shouldShowSelection: Bool = false
        /// 最後のメッセージか
        var isLastMessage: Bool = false

        switch count {
        case 0:
            message = "＊「ホホホ......。」"
            isMale = true
        case 1:
            message = "姫「きゃあ！\n  どなたですか！？」"
            isMale = false
        case 2:
            message = "＊「さあ、わたしといっしょに\n  来てもらいますよ......。」"
            isMale = true
        case 3:
            message = "姫「きゃー！！」"
            isMale = false
            isLastMessage = true
        default:
            break
        }
        let messageModel = MessageEntity.init(message: message, isMale: isMale, shouldShowSelection: shouldShowSelection, isLastMessage: isLastMessage)
        return messageModel
    }

}
