//
//  HomePageViewController.swift
//  guessWhere
//
//  Created by Eric Torigian on 5/12/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    let user = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("user id: \(user)")
    }
}