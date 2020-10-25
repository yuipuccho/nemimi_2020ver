//
//  Introduction1Model.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2020/10/25.
//  Copyright © 2020 吉澤優衣. All rights reserved.
//

/**
 * 導入ストーリーModel
 * - Note: 姫がハーミットに連れ去られるシーン
 */
struct Introduction1Model {

    // MARK: - Properties

    /// メッセージ内容格納用Enum
    enum messageEnum: String {
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

}
