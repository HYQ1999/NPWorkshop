//
//  GerenZhongxinViewController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/10.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class GerenZhongxinViewController: UIViewController {
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
    @IBOutlet weak var MenuItem: UIButton!
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
        self.revealViewController().rearViewRevealWidth = 250
                customSetup()
        // Do any additional setup after loading the view.
    }
    
    func customSetup() {
        let revealViewController: SWRevealViewController? = self.revealViewController()
        if revealViewController != nil {
            //            revealViewController?.rightViewRevealWidth = 50
            MenuItem.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            //            navigationController?.navigationBar.addGestureRecognizer(self.revealViewController()!.panGestureRecognizer)
            self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        }
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
        yuanmimatxt.resignFirstResponder()
        querenmimatxt.resignFirstResponder()
        xinmimatxt.resignFirstResponder()
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
