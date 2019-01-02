//
//  cehuaViewController.swift
//  NPWorkshop
//
//  Created by 欧张帆 on 2019/1/2.
//  Copyright © 2019 韩意谦. All rights reserved.
//

import UIKit
import MMDrawerController

class cehuaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Left Menu"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor =
            UIColor(red: 255/255, green: 218/255, blue: 68/255, alpha: 1)
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 20)]
        // Do any additional setup after loading the view.
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
