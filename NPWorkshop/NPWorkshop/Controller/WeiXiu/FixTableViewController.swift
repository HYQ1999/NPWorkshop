//
//  FixTableViewController.swift
//  NPWorkshop
//
//  Created by 欧张帆 on 2019/1/16.
//  Copyright © 2019 韩意谦. All rights reserved.
//

import UIKit
import ProgressHUD

class FixTableViewController: UITableViewController {
    
    var weixiuModel = WeixiuModel()
    var weixiuUserModel = WeiXiuUserModel()
    var tablelist: [Models_Weixiu.Response] = []
    @IBOutlet weak var MenuItem: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = 250
        customSetup()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrders(_:)), name: NSNotification.Name(rawValue: "Models_Weixiu"), object: nil)
        Messages().showNow(code: 0x2004)
        weixiuModel.loadData()
        weixiuModel.wxlist.removeAll()
        weixiuModel.saveData()
        
        WeixiuReposity().Weixiulist()
//        weixiuModel.loadData()
    }
    // MARK: - Table view data source
    @objc func TakeOrders(_ notification:Notification) {
        if let Response: [Models_Weixiu.Response] = notification.object as! [Models_Weixiu.Response]?{
            tableView.reloadData()
            ProgressHUD.dismiss()
        }
        else {
            Messages().showError(code: 0x1002)
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        weixiuModel.loadData()
        return weixiuModel.wxlist.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weixiucell", for: indexPath) as! WeiXiuTableViewCell
        weixiuModel.loadData()
        cell.weixiuren.text = weixiuModel.wxlist[indexPath.row].FixID
        cell.weixiushebei.text = weixiuModel.wxlist[indexPath.row].EqptName
        cell.weixiuzhuangtai.text = weixiuModel.wxlist[indexPath.row].FixState
        return cell
    }
   override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let start = UITableViewRowAction(style: .normal, title: "开始检修") {
        action , index in
        if self.weixiuModel.wxlist[indexPath.row].FixState == "检修中"
        {
            let alerttController = UIAlertController(title: "Error！", message: "此维修单已开始检修", preferredStyle: .alert)
            let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
            alerttController.addAction(okkAction)
            self.present( alerttController, animated:  true, completion: nil)
        }
        else if(self.weixiuModel.wxlist[indexPath.row].FixState == "待检修")
        {
            let alertController = UIAlertController(title: "提示",
                                                    message: "操作成功！", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "好的", style: .default, handler: {
                action in
                self.weixiuModel.loadData()
                let requesting : Models_Start.Requesting = Models_Start.Requesting(RepairID: self.weixiuModel.wxlist[indexPath.row].FixID, operation: "开始检修")
                StartReposity().Start(requesting: requesting)
                {(response, error) in
                    if error == nil, let response = response
                    {
                        self.weixiuModel.wxlist[indexPath.row] = WeixiuList(FixID: self.weixiuModel.wxlist[indexPath.row].FixID,EqptName: self.weixiuModel.wxlist[indexPath.row].EqptName,FixState:"检修中")
                        self.weixiuModel.saveData()
                        
                        tableView.reloadData()
                    }
                    
                }
                
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    start.backgroundColor = UIColor.orange
    
//    let look = UITableViewRowAction(style: .normal, title: "查看详细") {
//        action , index in
//    }
//    look.backgroundColor = UIColor.blue
    
    return [start]
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
