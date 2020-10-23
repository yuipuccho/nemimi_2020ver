//
//  Introduction1ViewController.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2019/08/29.
//  Copyright © 2019 吉澤優衣. All rights reserved.
//

import UIKit

class Introduction1ViewController: UIViewController {
    
//    @IBOutlet weak var princessImage: UIImageView!
//    @IBOutlet weak var hermitImage: UIImageView!
//    @IBOutlet weak var textView: UITextView!
//    
//    var count = 0
//    var button = false
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        hermitImage.isHidden = true
//        textView.isHidden = true
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            self.hermitImage.isHidden = false    // ハーミット登場
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//            self.textView.isHidden = false    // メッセージ表示
//            self.textView.text = "＊「ホホホ......。」"
//            self.button = true
//        }
//    }
//    
//    
//    @IBAction func mainButton(_ sender: UIButton) {
//        if button == true {
//            switch count {
//            case 0:
//                count += 1
//                textView.text = "姫「きゃあ！\n  どなたですか！？」"
//            case 1:
//                count += 1
//                textView.text = "＊「さあ、わたしといっしょに\n  来てもらいますよ......。」"
//            case 2:
//                count += 1
//                textView.text = "姫「きゃー！！」"
//            case 3:
//                performSegue(withIdentifier: "toStory2", sender: nil)
//                
//            default:
//                return
//            }
//        }
//    }
}

// MARK: - MakeInstance

extension Introduction1ViewController {

    static func makeInstance() -> UIViewController {
        guard let vc = R.storyboard.introduction1ViewController.introduction1ViewController() else {
            return UIViewController()
        }
        return vc
    }

}
