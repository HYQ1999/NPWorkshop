//
//  JieXiuFendanTableViewController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/22.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class JieXiuFendanTableViewController: UITableViewController {

    var weixiussskj = WeiXiuRenModel()
    var repairid : String!
    override func viewDidLoad() {
        super.viewDidLoad()

        weixiussskj.loadData()
        print(weixiussskj.weixiulist.count)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        weixiussskj.loadData()
        return weixiussskj.weixiulist.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        weixiussskj.loadData()
        let cell = tableView.dequeueReusableCell(withIdentifier: "fendancell", for: indexPath) as! Fendancell
        
        cell.UserId.text = weixiussskj.weixiulist[indexPath.row].userid
        cell.username.text = weixiussskj.weixiulist[indexPath.row].username
        cell.userquanxian.text = weixiussskj.weixiulist[indexPath.row].userqx
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let sure = UITableViewRowAction(style: .normal, title: "确认"){
            actionm, index in
            self.weixiussskj.loadData()
            print(String(self.repairid))
            print(self.weixiussskj.weixiulist[indexPath.row].userid)
            let requesting : Models_FenPei.Requesting = Models_FenPei.Requesting(repairaID: String(self.repairid), RepairUserID: self.weixiussskj.weixiulist[indexPath.row].userid)
            FenPeiResposity().FenPei(requesting: requesting){(response, error) in
                if error == nil, let response = response{
                    let alerttController = UIAlertController(title: "提示！", message: response.ts, preferredStyle: .alert)
                    let okkAction =  UIAlertAction(title: "好的" , style: .default , handler:{
                        action in
                        let destinationStoryboard = UIStoryboard(name:"JieXiu",bundle:nil)
                        let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: SWRevealViewController())))
                            as! SWRevealViewController
                        self.present(controller, animated: true, completion: nil)
                    })
                    alerttController.addAction(okkAction)
                    self.present( alerttController, animated:  true, completion: nil)
                }
            }
            
            
        }
        sure.backgroundColor = UIColor.red
        return [sure]
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
