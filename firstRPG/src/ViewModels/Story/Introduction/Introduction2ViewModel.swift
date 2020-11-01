//
//  Introduction2ViewModel.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2020/10/25.
//  Copyright © 2020 吉澤優衣. All rights reserved.
//

class Introduction2ViewModel {

    // MARK: - Functions

    /**
     * メッセージ内容
     * - Parameters:
     *  - count: 表示するメッセージnumber
     *  - canProceed: 次のメッセージに進むことができるか
     */
    func message(count: Int, canProceed: Bool) -> MessageModel {
        /// メッセージ内容
        var message: String = ""
        /// 選択肢を表示するか
        var shouldShowSelection: Bool = false
        /// 最後のメッセージか
        var isLastMessage: Bool = false

        switch count {
        case 0:
            message = "ほげぇよ......。"
        case 1:
            message = "王「ほげぇよ。」"
        case 2:
            message = "王「ねていたところ すまんの。」"
        case 3:
            message = "王「じつは わしの姫が\n さらわれてしまったんじゃ。」"
        case 4:
            message = "王「たすけにいってくれるな？」"
            shouldShowSelection = true
        case 5:
            if canProceed {
                message = "王「そうか。いってくれるか。」"
            } else {
                message = "王「なんと。\n まあ そんなことはいわずに。」"
            }
        case 6:
            message = "王「姫がさらわれた洞窟までは\n わしが 送りとどけよう。」"
        case 7:
            message = "王「あとは たのんだぞ！」"
            isLastMessage = true
        default:
            break
        }
        let messageModel = MessageModel.init(message: message, shouldShowSelection: shouldShowSelection, isLastMessage: isLastMessage)
        return messageModel
    }

}

struct MessageModel {

    let message: String

    let shouldShowSelection: Bool

    let isLastMessage: Bool

}
