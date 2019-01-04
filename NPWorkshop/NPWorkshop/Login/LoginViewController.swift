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
    @IBAction func ReturnBack(_ sender: Any) {
        username.resignFirstResponder()
        password.resignFirstResponder()
    }
    @IBAction func clicjk(_ sender: Any) {
        BtnSure()
       
    }
    func BtnSure()
    {
        if(username.text == "" && password.text == "")
        {
            let alertController  = UIAlertController(title: "提示！", message: "账号密码不能为空！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated:  true, completion: nil)
        }
        if( username.text == "" && password.text != "")
        {
            let alerttController = UIAlertController(title: "提示！", message: "账号不能为空", preferredStyle: .alert)
            let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
            alerttController.addAction(okkAction)
            self.present( alerttController, animated:  true, completion: nil)
        }
        if( username.text != "" && password.text == "")
        {
            let alerttController = UIAlertController(title: "提示！", message: "密码不能为空", preferredStyle: .alert)
            let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
            alerttController.addAction(okkAction)
            self.present( alerttController, animated:  true, completion: nil)
        }
        else
        {
            let alertttController = UIAlertController(title: "恭喜!", message: "登录成功" , preferredStyle: .alert)
            let okkkAction =  UIAlertAction(title: "返回" , style: .default , handler: nil )
            alertttController.addAction(okkkAction)
            self.present(alertttController, animated: true, completion: nil)
            self.performSegue(withIdentifier: "login", sender: self)
        }
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
