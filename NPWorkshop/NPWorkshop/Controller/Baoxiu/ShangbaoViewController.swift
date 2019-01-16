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
