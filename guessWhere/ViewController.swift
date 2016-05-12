//
//  ViewController.swift
//  guessWhere
//
//  Created by Eric Torigian on 5/3/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwdField: UITextField!
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        if let email = emailField.text where email != "", let pwd = passwdField.text where pwd != "" {
            
            DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: { error, authData in
                if error != nil {
                    
                    if error.code == STATUS_ACCOUNT_NONEXISTS {
                        DataService.ds.REF_BASE.createUser(email, password: pwd, withValueCompletionBlock: { error, results in
                            if error != nil {
                                self.showErrorAlert("Could not create account", msg: "Problem creating account on server \(error.description)")
                            } else {
                                DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: nil)
                                NSUserDefaults.standardUserDefaults().setValue(results[KEY_UID], forKey: KEY_UID)
                                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                            }
                        })
                    } else if error.code == STATUS_INVALID_PWD {
                        self.showErrorAlert("Error logging in", msg: "Invalid password/email combination.   Please try again")
                        
                    } else 	{
                        self.showErrorAlert("Error logging in", msg: error.description)
                    }
                }  else {
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: KEY_UID)
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                    
                }
            })
            
            
        } else {
            showErrorAlert("Login Error", msg: "You must include both an email and password to login")
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
        
        
    }

    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert )
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    


}

