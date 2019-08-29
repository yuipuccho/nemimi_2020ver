//
//  story3ViewController.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2019/08/29.
//  Copyright © 2019 吉澤優衣. All rights reserved.
//

import UIKit

class story3ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    var button = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.label.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.button = true
            
        }
    }
    
    @IBAction func mainButton(_ sender: Any) {
        if button == true {
            performSegue(withIdentifier: "toTitle", sender: nil)
        }
    }
}
