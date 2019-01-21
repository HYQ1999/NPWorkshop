//
//  PeiJianSearchTableViewController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/17.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit
import ProgressHUD
class PeiJianSearchTableViewController: UITableViewController,UITextFieldDelegate {

     var tablelist: [Models_PeiJianList.Response] = []
     var peijianlist = PeiJianModel()
     var peijianuselist = PeiJianUserModel()
    var sum:String! = "0"
    override func viewDidLoad() {
        super.viewDidLoad()

        peijianlist.loadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrders(_:)), name: NSNotification.Name(rawValue: "Models_PeiJianList"), object: nil)
        Messages().showNow(code: 0x2004)
        peijianlist.loadData()
        peijianlist.pjlist.removeAll()
        peijianlist.saveData()
        PeiJianListResposity().PeiJianList()
    }
    
    // MARK: - Table view data source
    
    @objc func TakeOrders(_ notification:Notification) {
        if let Response: [Models_PeiJianList.Response] = notification.object as! [Models_PeiJianList.Response]?{
            tablelist = Response
           self.tableView.reloadData()
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        peijianlist.loadData()
        return peijianlist.pjlist.count
    }
     override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        peijianlist.loadData()
        let cell = tableView.dequeueReusableCell(withIdentifier: "weixiupeijiancell", for: indexPath) as! WeiXiuPeiJianTableViewCell
        cell.peijiandanjia.text = "单价：" + peijianlist.pjlist[indexPath.row].peijiandanjia
        cell.peijianleibie.text = peijianlist.pjlist[indexPath.row].peijianleibie
        cell.peijianminchen.text = peijianlist.pjlist[indexPath.row].peijianminchen
         cell.peijianshuliang.text = "库存：" + peijianlist.pjlist[indexPath.row].peijiankucun
        return cell
    }
     override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        peijianlist.loadData()
        let sure = UITableViewRowAction(style: .normal, title: "确定"){
            actionm, index in
            let alertController = UIAlertController(title: "提示！",message: "请填写数量", preferredStyle: .alert)
            alertController.addTextField {
                (textField: UITextField!) -> Void in
                textField.placeholder = "数量"
            }
            
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                action in
                let newpw = alertController.textFields!.first!
                let expression2 = "[0-9]{1,1000}"
                let regex2 = try! NSRegularExpression.init(pattern: expression2, options: .allowCommentsAndWhitespace)
                let numberOfMatches2 = regex2.numberOfMatches(in: newpw.text!, options: .reportProgress, range: NSMakeRange(0, (newpw.text! as NSString).length))
                print(newpw.text!)
                  if numberOfMatches2 == 0
                  {
                    let alerttController = UIAlertController(title: "Error！", message: "请填写正确的数量！", preferredStyle: .alert)
                    let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
                    alerttController.addAction(okkAction)
                    self.present( alerttController, animated:  true, completion: nil)
                    return
                }
                if Int(newpw.text!)! > Int(self.peijianlist.pjlist[indexPath.row].peijiankucun)!
                {
                    let alerttController = UIAlertController(title: "Error！", message: "数量超过库存！", preferredStyle: .alert)
                    let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
                    alerttController.addAction(okkAction)
                    self.present( alerttController, animated:  true, completion: nil)
                    return
                }
                else
                {
                 self.peijianuselist.loadData()
                    
                    if self.peijianuselist.pjuselist.isEmpty
                    {
                let total = Int(newpw.text!)! * Int(self.peijianlist.pjlist[indexPath.row].peijiandanjia)!
                self.peijianuselist.pjuselist.append(PeiJianUserList(peijianminchen: self.peijianlist.pjlist[indexPath.row].peijianminchen, peijiannum: newpw.text!, peijianmoney: self.peijianlist.pjlist[indexPath.row].peijiandanjia, peijiantotal: String(total)))
                    self.peijianuselist.saveData()
                    let alerttController = UIAlertController(title: "提示！", message: "添加成功！", preferredStyle: .alert)
                    let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
                    alerttController.addAction(okkAction)
                    self.present( alerttController, animated:  true, completion: nil)
                    return
                    }
                    else
                    {
                        
                    }
                }
                
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        let shengou = UITableViewRowAction(style: .normal, title: "申购"){
            actionm, index in
        }
        sure.backgroundColor = UIColor.red
         shengou.backgroundColor = UIColor.orange
        return [sure,shengou]
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


