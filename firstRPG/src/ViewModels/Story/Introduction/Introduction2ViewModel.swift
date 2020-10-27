//
//  Introduction2ViewModel.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2020/10/25.
//  Copyright © 2020 吉澤優衣. All rights reserved.
//

class Introduction2ViewModel {

    private lazy var model = Introduction2Model()

    /// 表示するメッセージの番号
    private var messageNum = 0

    func mainButtonTapped() {
        messageNum += 1
        let message = model.message(count: messageNum, canProceed: true)
        //print(message)
    }

}
