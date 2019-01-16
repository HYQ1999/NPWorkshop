//
//  BXTableViewController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2018/12/29.
//  Copyright © 2018年 韩意谦. All rights reserved.
//

import UIKit
import ProgressHUD
class BXTableViewController: UITableViewController,UISearchBarDelegate,SearchTableViewDelegate {
    
var search:UISearchBar!
    var baoxiulist = BaoxiuModel()
        var tablelist: [Models_Baoxiu.Response] = []
    @IBOutlet var BxTableview: SearchTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        search = UISearchBar(frame:CGRect(x:0, y:0, width:300, height:20))
        search.barTintColor = UIColor.white
        search.searchBarStyle = UISearchBar.Style.minimal
        search.barStyle = UIBarStyle(rawValue: 0)!
        search.barStyle = UIBarStyle.black
        search.tintColor = UIColor.blue
        search.placeholder = "请输入搜索信息"
        BxTableview.mDelegate = self
        self.tableView.tableFooterView = UIView(frame:CGRect.zero)
        let logo = UIImageView(image:UIImage(named: "weixiu"))
        let rightNavBarButton = UIBarButtonItem(customView:search)
        //        self.navigationItem.rightBarButtonItem = rightNavBarButton
        self.navigationItem.titleView = logo
        search.delegate = self
        
        let button2 = UIButton(frame:CGRect(x:0, y:0,width:18,height:18))
        button2.setImage(UIImage(named: "tianjia"), for: .normal)
        button2.addTarget(self,action: #selector(tapped2),for:.touchUpInside)
        let barButton2 = UIBarButtonItem(customView: button2)
        
        
        let gap = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                  action: nil)
        gap.width = 15;
        
        self.navigationItem.rightBarButtonItems = [barButton2,rightNavBarButton]
        
        self.tabBarItem = UITabBarItem(title: "我的报修", image: UIImage(named: "xiuli"),
                                       selectedImage: UIImage(named: "baoxiu"))
        
        let bgColor = UIColor(red:250/255, green:250/255, blue: 250/255, alpha: 0)
        
        self.navigationController?.navigationBar.barTintColor = bgColor
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
  
//    override func viewDidDisappear(_ animated: Bool) {
//        NotificationCenter.default.removeObserver(self)
//    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrders(_:)), name: NSNotification.Name(rawValue: "Models_Baoxiu"), object: nil)
        Messages().showNow(code: 0x2004)
        BaoxiuReposity().Baoxiulist()
            baoxiulist.loadData()
        
    }
    @objc func TakeOrders(_ notification:Notification) {
        if let Response: [Models_Baoxiu.Response] = notification.object as! [Models_Baoxiu.Response]?{
            tablelist = Response
            tableView.reloadData()
            ProgressHUD.dismiss()
        }
        else {
            Messages().showError(code: 0x1002)
        }
    }

   
    
    
    @objc func tapped2(){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: String(describing: type(of: ShangbaoViewController()))) as! ShangbaoViewController
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func hideKeyBoard() {
        search.resignFirstResponder()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        baoxiulist.loadData()
        return baoxiulist.bxlist.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         baoxiulist.loadData()
        let cell = tableView.dequeueReusableCell(withIdentifier: "baoxiucell", for: indexPath) as! BaoxiuTableViewCell
        cell.baoxiuid.text = baoxiulist.bxlist[indexPath.row].RepairID
        cell.baoxiustyle.text = baoxiulist.bxlist[indexPath.row].RepairState
        cell.shebeimingchen.text = baoxiulist.bxlist[indexPath.row].EqptName
        return cell
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let chehui = UITableViewRowAction(style: .normal, title: "撤销") {
            action , index in
//            self.baoxiulist.loadData()
//            
////            let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: self.baoxiulist.bxlist[indexPath.row].RepairID)
//            BaoxiuDetail().Baoxiudetail()
            if self.baoxiulist.bxlist[indexPath.row].RepairState != "未分配"
            {
                let alerttController = UIAlertController(title: "Error！", message: "此报修单无法撤销", preferredStyle: .alert)
                let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
                alerttController.addAction(okkAction)
                self.present( alerttController, animated:  true, completion: nil)
            }
            else
            {
                 let alertController = UIAlertController(title: "提示！",message: "请填写故障原因", preferredStyle: .alert)
                alertController.addTextField {
                    (textField: UITextField!) -> Void in
                    textField.placeholder = "故障原因"
                }
                 let newpw = alertController.textFields!.first!
                 let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                    action in
                    self.baoxiulist.loadData()
    
                    let requesting : Models_CheXiao.Requesting = Models_CheXiao.Requesting(RepairID: self.baoxiulist.bxlist[indexPath.row].RepairID, operation: "撤销",RepairState: self.baoxiulist.bxlist[indexPath.row].RepairState,Mark1:newpw.text!)
                        CheXiaoReposity().Chexiao(requesting: requesting){(response, error) in
                              if error == nil, let response = response{
                                
                                self.baoxiulist.bxlist[indexPath.row] = BaoxiuList(RepairID: self.baoxiulist.bxlist[indexPath.row].RepairID,EqptName:self.baoxiulist.bxlist[indexPath.row].EqptName,RepairState:"已撤销")
                                self.baoxiulist.saveData()
                                let alerttController = UIAlertController(title: "提示！", message: response.ts, preferredStyle: .alert)
                                let okkAction =  UIAlertAction(title: "好的" , style: .default , handler:{
                                    action in
                                    self.tableView.reloadData()
                                })
                                alerttController.addAction(okkAction)
                                self.present( alerttController, animated:  true, completion: nil)
                                
                            }
                            
                        }
                        
                    
                    
                })
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
                
        }
            
        chehui.backgroundColor = UIColor.red
        return [chehui]
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
