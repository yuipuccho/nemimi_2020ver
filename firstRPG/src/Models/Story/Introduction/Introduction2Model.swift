//
//  Introduction2Model.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2020/10/25.
//  Copyright © 2020 吉澤優衣. All rights reserved.
//

/**
 * 導入ストーリーModel
 * - Note: 王様に助けを求められるシーン
 */
struct Introduction2Model {

    // MARK: - Properties

    /// メッセージ内容格納用Enum
    enum messageEnum: String {
        case zeroth, first, second, third, fourth, ditention, fifth, sixth, seventh

        var message: String {
            get {
                switch self {
                case .zeroth:
                    return "ほげぇよ......。"
                case .first:
                    return "王「ほげぇよ。」"
                case .second:
                    return "王「ねていたところ すまんの。」"
                case .third:
                    return "王「じつは わしの姫が\n さらわれてしまったんじゃ。」"
                case .fourth:
                    return "王「たすけにいってくれるな？」"
                case .ditention:
                    return "王「なんと。\n まあ そんなことはいわずに。」"
                case .fifth:
                    return "王「そうか。いってくれるか。」"
                case .sixth:
                    return "王「姫がさらわれた洞窟までは\n わしが 送りとどけよう。」"
                case .seventh:
                    return "王「あとは たのんだぞ！」"
                }
            }
        }
    }

    /// メッセージ内容
    func message(count: Int, canProceed: Bool) -> [String: Any]? {
        var message: String
        var shouldShowSelection: Bool = false

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
        default:
            return nil
        }
        return ["message": message, "shouldShowSelection": shouldShowSelection]
    }

}
