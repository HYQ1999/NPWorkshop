//
//  RightMenuViewController.swift
//  NPWorkshop
//
//  Created by 欧张帆 on 2019/1/3.
//  Copyright © 2019 韩意谦. All rights reserved.
//

import UIKit

class RightMenuViewController: UIViewController {

    @IBOutlet weak var imageview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageview.layer.cornerRadius = min(imageview.bounds.size.width, imageview.bounds.size.height) * 0.5
        imageview.layer.masksToBounds = true
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
