//
//  DaoHuoViewController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/22.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit
import ProgressHUD
class DaoHuoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
var tablelist: [Models_DaoHuoMsg.Response] = []
    var daohuolist = DaoHuoMessageModel()
    @IBOutlet weak var daohuotableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrders(_:)), name: NSNotification.Name(rawValue: "Models_DaoHuoMsg"), object: nil)
         Messages().showNow(code: 0x2004)
        daohuolist.loadData()
        daohuolist.daohuomsg.removeAll()
        daohuolist.saveData()
        daohuotableview.delegate = self
        daohuotableview.dataSource = self
        daohuotableview.reloadData()
        DaoHuoMsgResposity().Daohuolist()
    }
    
    @objc func TakeOrders(_ notification:Notification) {
        if let Response: [Models_DaoHuoMsg.Response] = notification.object as! [Models_DaoHuoMsg.Response]?{
            tablelist = Response
            daohuotableview.reloadData()
            ProgressHUD.dismiss()
        }
        else {
            Messages().showError(code: 0x1002)
        }
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
         daohuolist.loadData()
        return daohuolist.daohuomsg.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         daohuolist.loadData()
        let cell = tableView.dequeueReusableCell(withIdentifier: "daohuomsg", for: indexPath) as! DaoHuoTableViewCell
        cell.message.text = daohuolist.daohuomsg[indexPath.row].message
        cell.repairid.text = daohuolist.daohuomsg[indexPath.row].repairid
        cell.shijian.text = daohuolist.daohuomsg[indexPath.row].shijian
        cell.tongzhiren.text = daohuolist.daohuomsg[indexPath.row].tongzhiren
        return cell
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
