//
//  WodePeiJianShenGouTableViewController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/22.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit
import ProgressHUD
class WodePeiJianShenGouTableViewController: UITableViewController {

    @IBOutlet weak var MenuItem: UIBarButtonItem!
    var querendaohuolist = QueRenDaoHuoModel()
    var tablelist: [Models_PeiJianShenGouQueRen.Response] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = 250
        customSetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrders(_:)), name: NSNotification.Name(rawValue: "Models_PeiJianShenGouQueRen"), object: nil)
        Messages().showNow(code: 0x2004)
        querendaohuolist.loadData()
        querendaohuolist.querendaohuo.removeAll()
        querendaohuolist.saveData()
        PeiJianShenGouQueRenResposity().PeiJianShenGouQueRenlist()
    }
    
    @objc func TakeOrders(_ notification:Notification) {
        if let Response: [Models_PeiJianShenGouQueRen.Response] = notification.object as! [Models_PeiJianShenGouQueRen.Response]?{
            tablelist = Response
            tableView.reloadData()
            ProgressHUD.dismiss()
        }
        else {
            Messages().showError(code: 0x1002)
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
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       querendaohuolist.loadData()
        return querendaohuolist.querendaohuo.count
    }
    
     override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        querendaohuolist.loadData()
        let cell = tableView.dequeueReusableCell(withIdentifier: "wodepeijianshengoucell", for: indexPath) as! WodePeiJianShenGouTableViewCell
        cell.shenbaobianhao.text = "配件申报编号:" + querendaohuolist.querendaohuo[indexPath.row].peijianshenbaoid
        cell.peijianname.text =  "配件名称:" + querendaohuolist.querendaohuo[indexPath.row].peijianmingchen
        cell.shenbaoren.text = "配件申报人:" + querendaohuolist.querendaohuo[indexPath.row].peijianshenbaoren
        cell.shengoushuliang.text = "申报数量:" + querendaohuolist.querendaohuo[indexPath.row].shenbaoshuliang
        cell.shengoutime.text = "申报时间:" + querendaohuolist.querendaohuo[indexPath.row].shenbaoshijian
        cell.shengouzhuangtai.text = "申购状态:" + querendaohuolist.querendaohuo[indexPath.row].shenbaozhuangtai
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
         querendaohuolist.loadData()
        let sure = UITableViewRowAction(style: .normal, title: "确认到货"){
            actionm, index in
            let requesting : Models_SurePeijian.Requesting = Models_SurePeijian.Requesting(RepairID: self.querendaohuolist.querendaohuo[indexPath.row].RepairID)
        SurePeijianResposity().SurePeijian(requesting: requesting) { (response, error) in
            if error == nil, let response = response{
                let alerttController = UIAlertController(title: "提示！", message: response.ts, preferredStyle: .alert)
                let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
                alerttController.addAction(okkAction)
                self.present( alerttController, animated:  true, completion: nil)
                return
            }
            }
            
            
        }
        
        sure.backgroundColor = UIColor.blue
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
