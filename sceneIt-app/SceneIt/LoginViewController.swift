//
//  LoginViewController.swift
//  SceneIt
//
//  Created by Jasdip Chauhan on 2017-05-01.
//  Copyright © 2017 Jasdip Chauhan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginUsernameTextField: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: Actions
    @IBAction func loginClicked(_ sender: Any) {
                
        if loginUsernameTextField.text!.isEmpty || loginPasswordTextField.text!.isEmpty {
            loginUsernameTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName : UIColor.red])
            loginPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName : UIColor.red])
            
            return
        }
        
        let email = loginUsernameTextField.text!.lowercased()
        let password = loginPasswordTextField.text!.lowercased()
        
        Backend.getInstance().loginUser(email: email, password: password, completionHandler: {loginSuccessful in
            
            if loginSuccessful {
                
            } else {
                self.presentModal()
            }
            
        })
    }
    
    //MARK: Helper
    
    private func presentModal() {
        let errorModal = UIAlertController(title: "Error logging in", message: "Invalid email or password", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        errorModal.addAction(action)
        
        self.present(errorModal, animated: true, completion: nil)
    }
}
