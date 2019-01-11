//
//  YiShangBaoDetailController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/4.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class YiShangBaoDetailController: UIViewController {

    @IBOutlet weak var shebeiname: UITextField!
    @IBOutlet weak var baoxiuid: UILabel!
    @IBOutlet weak var zicannum: UITextField!
    @IBOutlet weak var xinhaocanshu: UITextField!
    @IBOutlet weak var baoxiutime: UILabel!
    @IBOutlet weak var baoxiustate: UILabel!
    @IBOutlet weak var guzhanxianxiang: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func viewclick(_ sender: Any) {
        self.view.endEditing(true)
    }
    @IBAction func ReturnBack(_ sender: Any) {
        shebeiname.resignFirstResponder()
        zicannum.resignFirstResponder()
        xinhaocanshu.resignFirstResponder()
        guzhanxianxiang.resignFirstResponder()
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
