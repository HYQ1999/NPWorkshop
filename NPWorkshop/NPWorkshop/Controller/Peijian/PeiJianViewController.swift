//
//  PeiJianViewController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/18.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit
import ProgressHUD
class PeiJianViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate {

      var search:UISearchBar!
    @IBOutlet weak var PeiJianTableview: UITableView!
    @IBOutlet weak var PeiJianSearchTabelview: UITableView!
    @IBOutlet weak var MenuItem: UIBarButtonItem!
    var tablelist: [Models_ShenGou.Response] = []
     var tablelists: [Models_PeiJianSearch.Response] = []
    var bxsearchlist = BaoxiuSearchModel()
    var baoxiulist = BaoxiuModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        PeiJianSearchTabelview.delegate = self
        PeiJianSearchTabelview.dataSource = self
        PeiJianTableview.delegate = self
        PeiJianTableview.dataSource = self
        
        search = UISearchBar(frame:CGRect(x:0, y:0, width:300, height:20))
        search.barTintColor = UIColor.white
        search.searchBarStyle = UISearchBar.Style.minimal
        search.barStyle = UIBarStyle(rawValue: 0)!
        search.barStyle = UIBarStyle.black
        search.tintColor = UIColor.blue
        search.placeholder = "请输入设备名称"
        var rightNavBarButton = UIBarButtonItem(customView:search)
        
        let gap = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                  action: nil)
        gap.width = 10;
        
       self.navigationItem.rightBarButtonItem = rightNavBarButton
        search.delegate = self
     
        
        let bgColor = UIColor(red:250/255, green:250/255, blue: 250/255, alpha: 0)
        
        self.navigationController?.navigationBar.barTintColor = bgColor
        addDoneButtonOnKeyboard()
        customSetup()
        // Do any additional setup after loading the view.
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
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar = UIToolbar()
        
        //左侧的空隙
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil, action: nil)
        //右侧的完成按钮
        let done: UIBarButtonItem = UIBarButtonItem(title: "完成", style: .done,
                                                    target: self,
                                                    action: #selector(doneButtonAction))
        
        var items:[UIBarButtonItem] = []
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.search.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        //收起键盘
        self.search.resignFirstResponder()
        print("您输入的是：\(search.text!)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if search.text == ""
        {
            NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrders(_:)), name: NSNotification.Name(rawValue: "Models_ShenGou"), object: nil)
            Messages().showNow(code: 0x2004)
            baoxiulist.loadData()
            baoxiulist.bxlist.removeAll()
            baoxiulist.saveData()
            PeiJianTableview.isHidden = false
            PeiJianSearchTabelview.isHidden = true
            ShenGouReposity().ShenGouList()
            
        }
        else
        {
            NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrder(_:)), name: NSNotification.Name(rawValue: "Models_PeiJianSearch"), object: nil)
            Messages().showNow(code: 0x2004)
            baoxiulist.loadData()
            
            if baoxiulist.bxlist.isEmpty
            {
                let alertController = UIAlertController(title: "提示!",
                                                        message: "查无此报修单(请填写正确的设备名称)！", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "返回", style: .default,handler:
                {
                    action in
                    NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrders(_:)), name: NSNotification.Name(rawValue: "Models_ShenGou"), object: nil)
                    Messages().showNow(code: 0x2004)
                    self.baoxiulist.loadData()
                    self.baoxiulist.bxlist.removeAll()
                    self.baoxiulist.saveData()
                    self.PeiJianTableview.isHidden = false
                    self.PeiJianSearchTabelview.isHidden = true
                  ShenGouReposity().ShenGouList()
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
            }
            else
            {
                for i in 0...baoxiulist.bxlist.count - 1
                {
                    if baoxiulist.bxlist[i].EqptName.hasPrefix(search.text!)
                    {
                        let requesting :  Models_PeiJianSearch.Requesting =  Models_PeiJianSearch.Requesting(EqpName: search.text!)
                        PeiJianSearchResposity().Search(requesting: requesting)
                        PeiJianTableview.isHidden = true
                        PeiJianSearchTabelview.isHidden = false
                        return
                    }
                }
                let alertController = UIAlertController(title: "提示!",
                                                        message: "查无此报修单(请填写正确的设备名称)！", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "返回", style: .default,handler:
                {
                    action in
                    NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrders(_:)), name: NSNotification.Name(rawValue: "Models_ShenGou"), object: nil)
                    Messages().showNow(code: 0x2004)
                    self.baoxiulist.loadData()
                    self.baoxiulist.bxlist.removeAll()
                    self.baoxiulist.saveData()
                    self.PeiJianTableview.isHidden = false
                    self.PeiJianSearchTabelview.isHidden = true
                    ShenGouReposity().ShenGouList()
                    
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
    }
    
    @objc func TakeOrders(_ notification:Notification) {
        if let Response: [Models_ShenGou.Response] = notification.object as! [Models_ShenGou.Response]?{
            tablelist = Response
            PeiJianTableview.reloadData()
            ProgressHUD.dismiss()
        }
        else {
            Messages().showError(code: 0x1002)
        }
    }
    @objc func TakeOrder(_ notification:Notification) {
        if let Response: [Models_PeiJianSearch.Response] = notification.object as! [Models_PeiJianSearch.Response]?{
            tablelists = Response
            PeiJianSearchTabelview.reloadData()
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
        bxsearchlist.loadData()
        baoxiulist.loadData()
        if PeiJianSearchTabelview == tableView
        {
            return bxsearchlist.bxsearchlist.count
        }
        else
        {
            return baoxiulist.bxlist.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        baoxiulist.loadData()
        bxsearchlist.loadData()
        if PeiJianSearchTabelview == tableView
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "baoxiusearchcell", for: indexPath) as! BaoxiuSearchTableViewCell
            cell.baoxiuid.text = bxsearchlist.bxsearchlist[indexPath.row].RepairID
            cell.baoxiustate.text = bxsearchlist.bxsearchlist[indexPath.row].RepairState
            cell.shebeimin.text = bxsearchlist.bxsearchlist[indexPath.row].EqptName
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "baoxiucell", for: indexPath) as! BaoxiuTableViewCell
            cell.baoxiuid.text = baoxiulist.bxlist[indexPath.row].RepairID
            cell.baoxiustyle.text = baoxiulist.bxlist[indexPath.row].RepairState
            cell.shebeimingchen.text = baoxiulist.bxlist[indexPath.row].EqptName
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        baoxiulist.loadData()
        bxsearchlist.loadData()
        if PeiJianSearchTabelview == tableView
        {
            if bxsearchlist.bxsearchlist[indexPath.row].RepairState == "已完修"
            {
                //                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: bxsearchlist.bxsearchlist[indexPath.row].RepairID)
                //                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let destinationStoryboard = UIStoryboard(name:"BaoxiuStoryboard",bundle:nil)
                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: YiWanXiuViewController())))
                    as! YiWanXiuViewController
                controller.repairid = bxsearchlist.bxsearchlist[indexPath.row].RepairID
                self.navigationController?.pushViewController(controller, animated: true)
                return
                
            }
            if bxsearchlist.bxsearchlist[indexPath.row].RepairState == "已上报"
            {
                //                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: bxsearchlist.bxsearchlist[indexPath.row].RepairID)
                //                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let destinationStoryboard = UIStoryboard(name:"BaoxiuStoryboard",bundle:nil)
                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: YiShangBaoDetailController())))
                    as! YiShangBaoDetailController
                controller.repairid = bxsearchlist.bxsearchlist[indexPath.row].RepairID
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
            if bxsearchlist.bxsearchlist[indexPath.row].RepairState == "弃修"
            {
                //                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: bxsearchlist.bxsearchlist[indexPath.row].RepairID)
                //                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let destinationStoryboard = UIStoryboard(name:"BaoxiuStoryboard",bundle:nil)
                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: QiXIuViewController())))
                    as! QiXIuViewController
                controller.repairid = bxsearchlist.bxsearchlist[indexPath.row].RepairID
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
            if bxsearchlist.bxsearchlist[indexPath.row].RepairState == "已撤销"
            {
                //                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: bxsearchlist.bxsearchlist[indexPath.row].RepairID)
                //                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let destinationStoryboard = UIStoryboard(name:"BaoxiuStoryboard",bundle:nil)
                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: CheXiaoViewController())))
                    as! CheXiaoViewController
                controller.repairid = bxsearchlist.bxsearchlist[indexPath.row].RepairID
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
            else
            {
                //                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: bxsearchlist.bxsearchlist[indexPath.row].RepairID)
                //                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let destinationStoryboard = UIStoryboard(name:"BaoxiuStoryboard",bundle:nil)
                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: QiTaStateViewController())))
                    as! QiTaStateViewController
                controller.repairid = bxsearchlist.bxsearchlist[indexPath.row].RepairID
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
        }
        else
        {
            if baoxiulist.bxlist[indexPath.row].RepairState == "已完修"
            {
                //                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: baoxiulist.bxlist[indexPath.row].RepairID)
                //                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let destinationStoryboard = UIStoryboard(name:"BaoxiuStoryboard",bundle:nil)
                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: YiWanXiuViewController())))
                    as! YiWanXiuViewController
                controller.repairid = baoxiulist.bxlist[indexPath.row].RepairID
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
            if baoxiulist.bxlist[indexPath.row].RepairState == "已上报"
            {
                //                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: baoxiulist.bxlist[indexPath.row].RepairID)
                //                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let destinationStoryboard = UIStoryboard(name:"BaoxiuStoryboard",bundle:nil)
                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: YiShangBaoDetailController())))
                    as! YiShangBaoDetailController
                controller.repairid = baoxiulist.bxlist[indexPath.row].RepairID
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
            if baoxiulist.bxlist[indexPath.row].RepairState == "弃修"
            {
                //                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: baoxiulist.bxlist[indexPath.row].RepairID)
                //                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let destinationStoryboard = UIStoryboard(name:"BaoxiuStoryboard",bundle:nil)
                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: QiXIuViewController())))
                    as! QiXIuViewController
                controller.repairid = baoxiulist.bxlist[indexPath.row].RepairID
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
            if baoxiulist.bxlist[indexPath.row].RepairState == "已撤销"
            {
                //                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: baoxiulist.bxlist[indexPath.row].RepairID)
                //                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let destinationStoryboard = UIStoryboard(name:"BaoxiuStoryboard",bundle:nil)
                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: CheXiaoViewController())))
                    as! CheXiaoViewController
                controller.repairid = baoxiulist.bxlist[indexPath.row].RepairID
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
            else
            {
                //                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: baoxiulist.bxlist[indexPath.row].RepairID)
                //                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let destinationStoryboard = UIStoryboard(name:"BaoxiuStoryboard",bundle:nil)
                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: QiTaStateViewController())))
                    as! QiTaStateViewController
                controller.repairid = baoxiulist.bxlist[indexPath.row].RepairID
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
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
extension PeiJianViewController {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        self.viewWillAppear(true)
        
        //
        //        let alertController = UIAlertController(title: "提示!",
        //                                                message: "查无此商品（请填写完整商品名称）！", preferredStyle: .alert)
        //        let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
        //        alertController.addAction(okAction)
        //        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.viewWillAppear(true)
            
        }
        
        
        
    }
    
    
    
}
