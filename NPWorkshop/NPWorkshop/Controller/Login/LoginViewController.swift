//
//  LoginViewController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2018/12/29.
//  Copyright © 2018年 韩意谦. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var UserNameTextField: UITextField!
    @IBOutlet weak var PassWordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        UserNameTextField.borderStyle = UITextField.BorderStyle.none
        UserNameTextField.clearButtonMode = .always
        PassWordTextField.borderStyle = UITextField.BorderStyle.none
        PassWordTextField.clearButtonMode = .always
        PassWordTextField.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    

    @IBAction func viewclick(_ sender: Any) {
        self.view.endEditing(true)
    }
    @IBAction func ReturnBack(_ sender: Any) {
        UserNameTextField.resignFirstResponder()
        PassWordTextField.resignFirstResponder()
    }
    @IBAction func clicjk(_ sender: Any) {
        BtnSure()
       
    }
    func BtnSure()
    {
        if(UserNameTextField.text == "" && PassWordTextField.text == "")
        {
            let alertController  = UIAlertController(title: "提示！", message: "账号密码不能为空！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated:  true, completion: nil)
        }
        if( UserNameTextField.text == "" && PassWordTextField.text != "")
        {
            let alerttController = UIAlertController(title: "提示！", message: "账号不能为空", preferredStyle: .alert)
            let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
            alerttController.addAction(okkAction)
            self.present( alerttController, animated:  true, completion: nil)
        }
        if( UserNameTextField.text != "" && PassWordTextField.text == "")
        {
            let alerttController = UIAlertController(title: "提示！", message: "密码不能为空", preferredStyle: .alert)
            let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
            alerttController.addAction(okkAction)
            self.present( alerttController, animated:  true, completion: nil)
        }
        else
        {
            if let username = UserNameTextField.text, let password = PassWordTextField.text{
                let requesting : Models_Login.Requesting = Models_Login.Requesting(UserName: username, Password: password)
                UserReposity().user_login(requesting: requesting) { (response, error) in
                    if error == nil, let response = response{
                        if response.id == ""  && response.roel == ""{
                            let alerttController = UIAlertController(title: "Error!", message: response.ts, preferredStyle: .alert)
                            let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
                            alerttController.addAction(okkAction)
                            self.present( alerttController, animated:  true, completion: nil)
                            return
                        }
                        
                        if response.id != "" && response.roel == Models_Login.UserRole.guanliyuan.rawValue
                        {
                            let alerttController = UIAlertController(title: "Error!", message: "身份不匹配，无法进入", preferredStyle: .alert)
                            let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
                            alerttController.addAction(okkAction)
                            self.present( alerttController, animated:  true, completion: nil)
                            return
                        }
                        
                        if response.id != "" && response.roel == Models_Login.UserRole.weixiuyonghu.rawValue
                        {
                            let alerttController = UIAlertController(title: "Error!", message: response.ts, preferredStyle: .alert)
                            let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: {
                                action in
                                let destinationStoryboard = UIStoryboard(name:"JieXiu",bundle:nil)
                                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: SWRevealViewController())))
                                    as! SWRevealViewController
                                self.present(controller, animated: true, completion: nil)
                            })
                            alerttController.addAction(okkAction)
                            self.present( alerttController, animated:  true, completion: nil)
                            return
                        }
                        
                        if response.id != "" && response.roel == Models_Login.UserRole.baoxiuyonghu.rawValue
                        {
                            let alerttController = UIAlertController(title: "Error!", message: response.ts, preferredStyle: .alert)
                            let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: {
                                action in
                                let destinationStoryboard = UIStoryboard(name:"BaoxiuStoryboard",bundle:nil)
                                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: BaoxiuTabViewController())))
                                    as! BaoxiuTabViewController
                                self.present(controller, animated: true, completion: nil)
                            })
                            alerttController.addAction(okkAction)
                            self.present( alerttController, animated:  true, completion: nil)
                            return
                        }
                        
                        if response.id != "" && response.roel == Models_Login.UserRole.zhidaojiaoshi.rawValue
                        {
                            let alerttController = UIAlertController(title: "Error!", message: response.ts, preferredStyle: .alert)
                            let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: {
                                action in
                                let destinationStoryboard = UIStoryboard(name:"ZhidaoJiaoshiStoryboard",bundle:nil)
                                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: ZhidaoTabBarController())))
                                    as! ZhidaoTabBarController
                                self.present(controller, animated: true, completion: nil)
                            })
                            alerttController.addAction(okkAction)
                            self.present( alerttController, animated:  true, completion: nil)
                            return
                        }
                        print(response.id ?? "")
                    }
                        
                    else if let error = error {
                        let alerttController = UIAlertController(title: "Error!", message: error, preferredStyle: .alert)
                        let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
                        alerttController.addAction(okkAction)
                        self.present( alerttController, animated:  true, completion: nil)
                        print(error)
                    }
                    
                }
                //                UserReposity().user_login(requesting: requesting, handler: getLoginresponse(response:error:))
            }
        
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
     } let destinationStoryboard = UIStoryboard(name:"BaoxiuStoryboard",bundle:nil)
     let destinationViewController = destinationStoryboard.instantiateViewController(withIdentifier:  String(describing: type(of: YiWanXiuViewController()))) as! YiWanXiuViewController
     self.present(destinationViewController, animated: true, completion: nil)
    */

}
