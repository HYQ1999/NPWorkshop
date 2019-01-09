//
//  JIexiuMoneyBox.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/9.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class JIexiuMoneyBox: UIViewController {

    @IBOutlet weak var userimg: UIImageView!
    var i:Int!
    override func viewDidLoad() {
        super.viewDidLoad()

        userimg.layer.cornerRadius = min(userimg.bounds.size.width, userimg.bounds.size.height) * 0.5
        userimg.layer.masksToBounds = true
        let bgColor = UIColor(red:55/255, green:225/255, blue: 165/255, alpha: 1)
        
        self.navigationController?.navigationBar.barTintColor = bgColor
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
  self.navigationController?.navigationBar.shadowImage = UIImage()
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
