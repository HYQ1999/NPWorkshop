//
//  LoginViewController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2018/12/29.
//  Copyright © 2018年 韩意谦. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        username.borderStyle = UITextField.BorderStyle.none
        username.clearButtonMode = .always
        password.borderStyle = UITextField.BorderStyle.none
        password.clearButtonMode = .always
        password.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func viewclick(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
