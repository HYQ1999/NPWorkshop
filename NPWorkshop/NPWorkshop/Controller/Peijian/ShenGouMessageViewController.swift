//
//  ShenGouMessageViewController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/22.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit
import ProgressHUD

class ShenGouMessageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var shengoutableview: UITableView!
    var tablelist: [Models_ShenGouMsg.Response] = []
    var shengoulist = ShenGouMessageModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrders(_:)), name: NSNotification.Name(rawValue: "Models_ShenGouMsg"), object: nil)
        Messages().showNow(code: 0x2004)
        shengoutableview.delegate = self
        shengoutableview.dataSource = self
        shengoutableview.reloadData()
        shengoulist.loadData()
        shengoulist.shengoumsg.removeAll()
        shengoulist.saveData()
        ShenGouMsgResposity().shengouMesage()
    }
    @objc func TakeOrders(_ notification:Notification) {
        if let Response: [Models_ShenGouMsg.Response] = notification.object as! [Models_ShenGouMsg.Response]?{
            tablelist = Response
            shengoutableview.reloadData()
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
        shengoulist.loadData()
        return shengoulist.shengoumsg.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shengoumsg", for: indexPath) as! ShenGouTableViewCell
        cell.message.text = shengoulist.shengoumsg[indexPath.row].message
        cell.repairid.text = shengoulist.shengoumsg[indexPath.row].repairid
        cell.shengouren.text = shengoulist.shengoumsg[indexPath.row].shengouren
        cell.shijian.text = shengoulist.shengoumsg[indexPath.row].shijian
        
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
