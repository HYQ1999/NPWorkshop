//
//  ViewController.swift
//  NPWorkshop
//
//  Created by 韩意谦 on 2018/12/28.
//  Copyright © 2018 韩意谦. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let alertController = UIAlertController(title: "提示!", message: "撤销成功", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确认", style: .default,handler: {
            action in
            self.viewWillAppear(true)
            
            
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
        
        
        
        let alertController1 = UIAlertController(title: "提示!", message: "分配成功", preferredStyle: .alert)
        let okAction1 = UIAlertAction(title: "确认", style: .default,handler: {
            action in
            self.viewWillAppear(true)
            
            
        })
        alertController1.addAction(okAction1)
        self.present(alertController1, animated: true, completion: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }


}

