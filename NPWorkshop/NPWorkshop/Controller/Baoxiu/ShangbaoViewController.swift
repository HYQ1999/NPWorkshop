//
//  ShangbaoViewController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/2.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class ShangbaoViewController: UIViewController {

    @IBOutlet weak var shebeiname: UITextField!
    @IBOutlet weak var zichannum: UITextField!
    @IBOutlet weak var xinhaocanshu: UITextField!
    @IBOutlet weak var guzhangxianxiang: UITextView!
    var userlist = UserModel()
    var baoxiulist = BaoxiuModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        shebeiname.borderStyle = UITextField.BorderStyle.none
        shebeiname.clearButtonMode = .always
        zichannum.borderStyle = UITextField.BorderStyle.none
        zichannum.clearButtonMode = .always
        xinhaocanshu.borderStyle = UITextField.BorderStyle.none
        xinhaocanshu.clearButtonMode = .always
        
        self.guzhangxianxiang.layer.borderColor = UIColor(red: 206/255, green: 205/255, blue: 205/255, alpha: 1).cgColor
        
        self.guzhangxianxiang.layer.borderWidth = 2
        
        self.guzhangxianxiang.layer.cornerRadius = 16
        // Do any additional setup after loading the view.
    }
    
    @IBAction func viewclick(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func textclick(_ sender: Any) {
        shebeiname.resignFirstResponder()
        zichannum.resignFirstResponder()
        xinhaocanshu.resignFirstResponder()
    }
    @IBAction func shangbao(_ sender: Any) {
        
        userlist.loadData()
        if shebeiname.text == ""
        {
            let alertController  = UIAlertController(title: "提示！", message: "设备名称不能为空！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated:  true, completion: nil)
            return
        }
        if zichannum.text == ""
        {
            let alertController  = UIAlertController(title: "提示！", message: "资产序号不能为空！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated:  true, completion: nil)
            return
        }
        if xinhaocanshu.text == ""
        {
            let alertController  = UIAlertController(title: "提示！", message: "型号参数不能为空！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated:  true, completion: nil)
            return
        }
        if guzhangxianxiang.text == ""
        {
            let alertController  = UIAlertController(title: "提示！", message: "故障现象！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated:  true, completion: nil)
            return
        }
        else
        {
            
            let requesting : Models_ShangBao.Requesting = Models_ShangBao.Requesting(UserID: userlist.userlist[0].userid, EqptName: shebeiname.text!,AssetsNumber: zichannum.text!,Appearance:xinhaocanshu.text!,Parameter:guzhangxianxiang.text!)
            ShangBaoReposity().ShangBao(requesting: requesting) { (response, error) in
                if error == nil, let response = response{
                    let alerttController = UIAlertController(title: "提示！", message: response.ts, preferredStyle: .alert)
                    let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
                    alerttController.addAction(okkAction)
                    self.present( alerttController, animated:  true, completion: nil)
                }
            }
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
