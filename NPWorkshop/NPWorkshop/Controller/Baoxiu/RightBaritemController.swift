//
//  RightBaritemController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/2.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class RightBaritemController: UIViewController {
    @IBOutlet weak var userimg: UIImageView!
    @IBOutlet weak var xinmima: UIImageView!
    @IBOutlet weak var xinmimatxt: UITextField!
    @IBOutlet weak var fengexian: UIImageView!
    @IBOutlet weak var querenmima: UIImageView!
    @IBOutlet weak var querenmimatxt: UITextField!
    @IBOutlet weak var xiugaimima: UIButton!
    @IBOutlet weak var surebtn: UIButton!
    @IBOutlet weak var yuanmima: UIImageView!
    @IBOutlet weak var yuanmimatxt: UITextField!
    @IBOutlet weak var fenxian: UIImageView!
    
    @IBOutlet weak var bumen: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userqq: UILabel!
    @IBOutlet weak var telphone: UILabel!
    var userlist = UserModel()
    var baoxiulist = BaoxiuModel()
    var userdetaillist = GerenDetailModel()
    //    @IBOutlet weak var MenuItem: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.selectedIndex = 1
        self.tabBarItem = UITabBarItem(title: "我", image: UIImage(named: "wo1"),
                                       selectedImage: UIImage(named: "wo"))
        userimg.layer.cornerRadius = min(userimg.bounds.size.width, userimg.bounds.size.height) * 0.5
        userimg.layer.masksToBounds = true
        let bgColor = UIColor(red:18/255, green:113/255, blue: 183/255, alpha: 0)
        
        self.navigationController?.navigationBar.barTintColor = bgColor
        xiugaimima.isHidden = false
        xinmima.isHidden = true
        xinmimatxt.isHidden = true
        fengexian.isHidden = true
        querenmima.isHidden = true
        querenmimatxt.isHidden = true
        surebtn.isHidden = true
        yuanmima.isHidden = true
        yuanmimatxt.isHidden = true
        fenxian.isHidden = true

        
        GeRenDetailResposity().UserDetail(){ (response, error) in
            if error == nil, let response = response{
                self.bumen.text = response.role
                self.username.text = response.username
                self.userqq.text = response.userqq
                self.telphone.text = response.userdianhua
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
 
    
    
    @IBAction func xiugaimimaclick(_ sender: Any) {
        xiugaimima.isHidden = true
        xinmima.isHidden = false
        xinmimatxt.isHidden = false
        fengexian.isHidden = false
        querenmima.isHidden = false
        querenmimatxt.isHidden = false
        surebtn.isHidden = false
        yuanmima.isHidden = false
        yuanmimatxt.isHidden = false
        fenxian.isHidden = false
    }
    
    @IBAction func sureclick(_ sender: Any) {
        
        if yuanmimatxt.text == ""
        {
            let alerttController = UIAlertController(title: "Error！", message: "请填写原密码", preferredStyle: .alert)
            let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
            alerttController.addAction(okkAction)
            self.present( alerttController, animated:  true, completion: nil)
            return
        }
        if xinmimatxt.text == ""
        {
            let alerttController = UIAlertController(title: "Error！", message: "请填写新密码", preferredStyle: .alert)
            let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
            alerttController.addAction(okkAction)
            self.present( alerttController, animated:  true, completion: nil)
            return
        }
        if querenmimatxt.text == ""
        {
            let alerttController = UIAlertController(title: "Error！", message: "请确认密码", preferredStyle: .alert)
            let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
            alerttController.addAction(okkAction)
            self.present( alerttController, animated:  true, completion: nil)
            return
        }
        
        let expression2 = "^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}"
        let regex2 = try! NSRegularExpression(pattern: expression2, options: .allowCommentsAndWhitespace)//生成NSRegularExpression实例
        
        let numberOfMatches2 = regex2.numberOfMatches(in: xinmimatxt.text!, options:.reportProgress, range: NSMakeRange(0, (xinmimatxt.text! as NSString).length))//获取匹配的个数
        if numberOfMatches2 == 0
        {
            let alertController = UIAlertController(title: "提示!", message: "密码格式有误", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "确认", style: .default,handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
            if querenmimatxt.text != xinmimatxt.text
            {
                let alerttController = UIAlertController(title: "Error！", message: "两次密码不同，请重新输入", preferredStyle: .alert)
                let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
                alerttController.addAction(okkAction)
                self.present( alerttController, animated:  true, completion: nil)
                return
            }
                
                
                
        else
        {
            GeRenDetailResposity().UserDetail(){ (response, error) in
                if error == nil, let response = response{
                    if  self.yuanmimatxt.text == response.password
                  {
                    self.userlist.loadData()
                    let requesting : Models_MiMaEdit.Requesting = Models_MiMaEdit.Requesting(UserID: self.userlist.userlist[0].userid, NewPassWord: self.xinmimatxt.text!)
                    MiMaEditResposity().Edit(requesting: requesting){ (response, error) in
                        if error == nil, let response = response{
                            let alerttController = UIAlertController(title: "提示！", message: response.ts, preferredStyle: .alert)
                            let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: {
                                action in
                                
                                let destinationStoryboard = UIStoryboard(name:"Main",bundle:nil)
                                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: LoginViewController())))
                                    as! LoginViewController
                                self.present(controller, animated: true, completion: nil)
                                
                            })
                            alerttController.addAction(okkAction)
                            self.present( alerttController, animated:  true, completion: nil)
                            
                        }
                    }
                    }
                    else
                    {
                        let alerttController = UIAlertController(title: "Error！", message: "原密码不符", preferredStyle: .alert)
                        let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
                        alerttController.addAction(okkAction)
                        self.present( alerttController, animated:  true, completion: nil)
                    }
                }
            }
        }
    }
    
    @IBAction func zhuxiao(_ sender: Any) {
        userlist.loadData()
        userlist.userlist.removeAll()
        userlist.saveData()
        
        baoxiulist.loadData()
        baoxiulist.bxlist.removeAll()
        baoxiulist.saveData()
        
        let destinationStoryboard = UIStoryboard(name:"Main",bundle:nil)
        let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: LoginViewController())))
            as! LoginViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    
    @IBAction func viewclick(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func returnback(_ sender: Any) {
        xinmimatxt.resignFirstResponder()
        yuanmimatxt.resignFirstResponder()
        querenmimatxt.resignFirstResponder()
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
