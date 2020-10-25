//
//  Introduction2ViewController.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2019/08/29.
//  Copyright © 2019 吉澤優衣. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/**
 * 導入ストーリーVC
 * - Note: 王様に助けを求められるシーン
 */
class Introduction2ViewController: UIViewController {

    // MARK: - Outlets

    /// 王様ImageView
    @IBOutlet weak var kingImage: UIImageView!

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    /// ボタンView
    private lazy var buttonView = R.nib.buttonView.firstView(owner: nil)!
    /// メッセージView
    private lazy var messageView = R.nib.messageView.firstView(owner: nil)!

    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

// MARK: - Functions

extension Introduction1ViewController {

}

// MARK: - MakeInstance

extension Introduction2ViewController {

    static func makeInstance() -> UIViewController {
        guard let vc = R.storyboard.introduction2ViewController.introduction2ViewController() else {
            return UIViewController()
        }
        return vc
    }

}
