//
//  story2ViewController.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2019/08/29.
//  Copyright © 2019 吉澤優衣. All rights reserved.
//

import UIKit

class story2ViewController: UIViewController {

    @IBOutlet weak var kingImage: UIImageView!
    @IBOutlet weak var textView: UITextView!

    var count = 0
    var button = false

    override func viewDidLoad() {
        super.viewDidLoad()

        kingImage.isHidden = true
        textView.isHidden = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.textView.isHidden = false    // メッセージ表示
            self.textView.text = "ほげぇよ......。"
            self.button = true

        }
    }


    @IBAction func mainButton(_ sender: Any) {
        if button == true {
            switch count {
            case 0:
                count += 1
                kingImage.isHidden = false    // 王様登場
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.textView.text = "王「ほげぇよ。」"
                }
            case 1:
                count += 1
                textView.text = "王「ねていたところ すまんの。」"
            case 2:
                count += 1
                textView.text = "王「じつは わしの姫が\n さらわれてしまったんじゃ。」"
            case 3:
                count += 1
                textView.text = "王「たすけにいってくれるな？」"
            case 4:
                count += 1
                textView.text = "王「姫がさらわれた洞窟まで\n 送りとどけよう。」"
            case 5:
                count += 1
                textView.text = "王「あとは たのんだぞ！」"
            case 6:
                performSegue(withIdentifier: "toCave1", sender: nil)
            default:
                return
            }
        }
    }

}
