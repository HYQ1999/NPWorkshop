//
//  RightMenuViewController.swift
//  NPWorkshop
//
//  Created by 欧张帆 on 2019/1/9.
//  Copyright © 2019 韩意谦. All rights reserved.
//

import UIKit

class RightMenuViewController: UIViewController {
    var weixiuUserModel = WeiXiuUserModel()
    var weixiuModel = WeixiuModel()
    @IBOutlet weak var imageview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageview.layer.cornerRadius = min(imageview.bounds.size.width, imageview.bounds.size.height) * 0.5
        imageview.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func out(_ sender: Any) {
        
        let alertController = UIAlertController(title: "提示",
                                                message: "您确定要退出此账号吗？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            self.weixiuUserModel.loadData()
            self.weixiuUserModel.userlist.removeAll()
            self.weixiuUserModel.saveData()
            
            self.weixiuModel.loadData()
            self.weixiuModel.wxlist.removeAll()
            self.weixiuModel.saveData()
            
            let destinationStoryboard = UIStoryboard(name:"Main",bundle:nil)
            let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: LoginViewController())))
                as! LoginViewController
            self.present(controller, animated: true, completion: nil)
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
//        let alerttController = UIAlertController(title: "提示!", message: response.ts, preferredStyle: .alert)
//        let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: {
//            action in
//            let destinationStoryboard = UIStoryboard(name:"JieXiu",bundle:nil)
//            let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: LoginViewController())))
//                as! LoginViewController
//            self.present(controller, animated: true, completion: nil)
//        })
//        alerttController.addAction(okkAction)
//        self.present( alerttController, animated:  true, completion: nil)
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
