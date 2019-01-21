//
//  ManShengouTableViewController.swift
//  NPWorkshop
//
//  Created by 欧张帆 on 2019/1/21.
//  Copyright © 2019 韩意谦. All rights reserved.
//

import UIKit
import ProgressHUD

class ManShengouTableViewController: UITableViewController,UITextFieldDelegate {

        var tablelist: [Model_ManShengou.Response] = []
    var manshengouList = ManShengouModel()
    override func viewDidLoad() {
        super.viewDidLoad()
manshengouList.loadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrders(_:)), name: NSNotification.Name(rawValue: "Model_ManShengou"), object: nil)
        Messages().showNow(code: 0x2004)
        manshengouList.loadData()
        manshengouList.Manpeijianlist.removeAll()
        manshengouList.saveData()
        ManShengouResposity().ManShengouList()
//        PeiJianListResposity().PeiJianList()
    }
    @objc func TakeOrders(_ notification:Notification) {
        if let Response: [Model_ManShengou.Response] = notification.object as! [Model_ManShengou.Response]?{
            tablelist = Response
            self.tableView.reloadData()
            ProgressHUD.dismiss()
        }
        else {
            Messages().showError(code: 0x1002)
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        manshengouList.loadData()
        return manshengouList.Manpeijianlist.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        manshengouList.loadData()
        let cell = tableView.dequeueReusableCell(withIdentifier: "shengoucell", for: indexPath) as! PeiJianShenGouTableViewCell
        cell.userid.text =  manshengouList.Manpeijianlist[indexPath.row].userid
        cell.username.text =  manshengouList.Manpeijianlist[indexPath.row].username
       cell.userqx.text =  manshengouList.Manpeijianlist[indexPath.row].userqx
        return cell
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
