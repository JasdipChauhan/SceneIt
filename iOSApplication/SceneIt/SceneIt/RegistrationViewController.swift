//
//  ViewController.swift
//  SceneIt
//
//  Created by Jasdip Chauhan on 2017-04-22.
//  Copyright © 2017 Jasdip Chauhan. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    //MARK: UI Objects
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    //Singletons
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: ButtonClicks
    @IBAction func registerButtonClick(_ sender: Any) {
        
        if usernameTextField.text!.isEmpty ||
            passwordTextField.text!.isEmpty ||
            emailTextField.text!.isEmpty ||
            firstNameTextField.text!.isEmpty ||
            lastNameTextField.text!.isEmpty {
            
            usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSForegroundColorAttributeName: UIColor.red])
            
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: UIColor.red])
            
            emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName: UIColor.red])
        
            firstNameTextField.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [NSForegroundColorAttributeName: UIColor.red])
            
            lastNameTextField.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: [NSForegroundColorAttributeName: UIColor.red])

        } else {
            
            // create the new user in MySQL DB
            Backend.getInstance().registerUser(username: usernameTextField.text!.lowercased(),
                                               password: passwordTextField.text!.lowercased(),
                                               email: emailTextField.text!.lowercased(),
                                               fullname: firstNameTextField.text!.appending("%20".appending(lastNameTextField.text!.lowercased())).lowercased())
            
        }
        
        
        
    }
    
    @IBAction func accountButtonClick(_ sender: Any) {
    }
    
}

