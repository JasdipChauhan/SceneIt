//
//  ResetViewController.swift
//  SceneIt
//
//  Created by Jasdip Chauhan on 2017-05-01.
//  Copyright © 2017 Jasdip Chauhan. All rights reserved.
//

import UIKit

class ResetViewController: UIViewController {

    
    @IBOutlet weak var emailTokenTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func resetClicked(_ sender: Any) {
        
        let email = emailTokenTextField.text!
        
        if email.isEmpty {
            emailTokenTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName: UIColor.red])
        }
        
        
        
    }
    
    
}
