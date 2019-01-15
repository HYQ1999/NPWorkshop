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
        var logo = UIImageView(image:UIImage(named: "weixiu"))
        var rightNavBarButton = UIBarButtonItem(customView:search)
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
  
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrders(_:)), name: NSNotification.Name(rawValue: "Models_Baoxiu"), object: nil)
        Messages().showNow(code: 0x2004)
        BaoxiuReposity().Baoxiulist()
            
        
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
        
        
        return tablelist.count
    }

    
      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "baoxiucell", for: indexPath) as! BaoxiuTableViewCell
        let list = tablelist[indexPath.row] as Models_Baoxiu.Response
        cell.baoxiuid.text = list.RepairID
        cell.baoxiustyle.text = list.RepairState
        cell.shebeimingchen.text = list.EqptName
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
