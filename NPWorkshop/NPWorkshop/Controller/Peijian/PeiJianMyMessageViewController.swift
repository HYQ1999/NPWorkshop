//
//  PeiJianMyMessageViewController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/22.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class PeiJianMyMessageViewController: UIViewController {
@IBOutlet weak var MenuItem: UIBarButtonItem!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var firstv: UIView!
    @IBOutlet weak var secondv: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = 250
        customSetup()
        firstv.isHidden = false
        secondv.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func indexchange(_ sender: UISegmentedControl) {
        switch segment.selectedSegmentIndex
        {
        case 0:
            firstv.isHidden = false
            secondv.isHidden = true
        case 1:
            firstv.isHidden = true
            secondv.isHidden = false
        default:
            break;
        }
        
        
    }
    func customSetup() {
        let revealViewController: SWRevealViewController? = self.revealViewController()
        if revealViewController != nil {
            //            revealViewController?.rightViewRevealWidth = 50
            MenuItem.target = self.revealViewController()
            MenuItem.action = #selector(SWRevealViewController.revealToggle(_:))
            //            navigationController?.navigationBar.addGestureRecognizer(self.revealViewController()!.panGestureRecognizer)
            self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        }
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
