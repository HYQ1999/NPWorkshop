//
//  WoViewController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/8.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class WoViewController: UIViewController {
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
    var userdetaillist = GerenDetailModel()
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
        
        GeRenDetailResposity().UserDetail()
        
        userdetaillist.loadData()
        bumen.text = userdetaillist.userdetail[0].userbumen
        username.text = userdetaillist.userdetail[0].username
        userqq.text = userdetaillist.userdetail[0].userqq
        telphone.text = userdetaillist.userdetail[0].userdianhua
        
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
    }
    
    @IBAction func zhuxiao(_ sender: Any) {
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


}
