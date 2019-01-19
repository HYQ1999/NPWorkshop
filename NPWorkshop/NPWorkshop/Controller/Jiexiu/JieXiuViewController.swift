//
//  JieXiuViewController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/17.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit
import ProgressHUD
class JieXiuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate {
    
    
   
    var search:UISearchBar!
 @IBOutlet weak var MenuItem: UIBarButtonItem!
    @IBOutlet weak var JieXiuSearchTableview: UITableView!
    @IBOutlet weak var JieXiuTableview: UITableView!
    var tablelist: [Models_JieXiu.Response] = []
    var tablelists: [Models_JieXiuSearch.Response] = []
     var bxsearchlist = BaoxiuSearchModel()
    var baoxiulist = BaoxiuModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController().rearViewRevealWidth = 250
        customSetup()
        JieXiuSearchTableview.delegate = self
        JieXiuSearchTableview.dataSource = self
        JieXiuTableview.delegate = self
        JieXiuTableview.dataSource = self
        
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
            NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrders(_:)), name: NSNotification.Name(rawValue: "Models_JieXiu"), object: nil)
            Messages().showNow(code: 0x2004)
            baoxiulist.loadData()
            baoxiulist.bxlist.removeAll()
            baoxiulist.saveData()
            JieXiuTableview.isHidden = false
            JieXiuSearchTableview.isHidden = true
            JieXiuReposity().JieXiuList()
            
            
        }
        else
        {
            NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrder(_:)), name: NSNotification.Name(rawValue: "Models_JieXiuSearch"), object: nil)
            Messages().showNow(code: 0x2004)
            baoxiulist.loadData()
            
            if baoxiulist.bxlist.isEmpty
            {
                let alertController = UIAlertController(title: "提示!",
                                                        message: "查无此报修单(请填写正确的设备名称)！", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "返回", style: .default,handler:
                {
                    action in
                    NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrders(_:)), name: NSNotification.Name(rawValue: "Models_JieXiu"), object: nil)
                    Messages().showNow(code: 0x2004)
                    self.baoxiulist.loadData()
                    self.baoxiulist.bxlist.removeAll()
                    self.baoxiulist.saveData()
                    self.JieXiuTableview.isHidden = false
                    self.JieXiuSearchTableview.isHidden = true
                    JieXiuReposity().JieXiuList()
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
                        let requesting :  Models_JieXiuSearch.Requesting =  Models_JieXiuSearch.Requesting(EqpName: search.text!)
                        JieXiuSearchResposity().Search(requesting: requesting)
                        JieXiuTableview.isHidden = true
                        JieXiuSearchTableview.isHidden = false
                        return
                    }
                    //                else
                    //                {
                    //                    let alertController = UIAlertController(title: "提示!",
                    //                                                            message: "查无此报修单(请填写正确的设备名称)！", preferredStyle: .alert)
                    //                    let okAction = UIAlertAction(title: "返回", style: .default,handler: nil)
                    //                    alertController.addAction(okAction)
                    //                    self.present(alertController, animated: true, completion: nil)
                    //                }
                }
                let alertController = UIAlertController(title: "提示!",
                                                        message: "查无此报修单(请填写正确的设备名称)！", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "返回", style: .default,handler:
                {
                    action in
                    NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrders(_:)), name: NSNotification.Name(rawValue: "Models_JieXiu"), object: nil)
                    Messages().showNow(code: 0x2004)
                    self.baoxiulist.loadData()
                    self.baoxiulist.bxlist.removeAll()
                    self.baoxiulist.saveData()
                    self.JieXiuTableview.isHidden = false
                    self.JieXiuSearchTableview.isHidden = true
                    JieXiuReposity().JieXiuList()

                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
                
            }
            
            
        }
    }
    
    @objc func TakeOrders(_ notification:Notification) {
        if let Response: [Models_JieXiu.Response] = notification.object as! [Models_JieXiu.Response]?{
            tablelist = Response
            JieXiuTableview.reloadData()
            ProgressHUD.dismiss()
        }
        else {
            Messages().showError(code: 0x1002)
        }
    }
    
    @objc func TakeOrder(_ notification:Notification) {
        if let Response: [Models_JieXiuSearch.Response] = notification.object as! [Models_JieXiuSearch.Response]?{
            tablelists = Response
            JieXiuSearchTableview.reloadData()
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
   if JieXiuSearchTableview == tableView
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
        if JieXiuSearchTableview == tableView
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
        if JieXiuSearchTableview == tableView
        {
            if bxsearchlist.bxsearchlist[indexPath.row].RepairState == "已完修"
            {
                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: bxsearchlist.bxsearchlist[indexPath.row].RepairID)
                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                 let destinationStoryboard = UIStoryboard(name:"BaoxiuStoryboard",bundle:nil)
                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: YiWanXiuViewController())))
                    as! YiWanXiuViewController
                self.navigationController?.pushViewController(controller, animated: true)
                return
                
            }
            if bxsearchlist.bxsearchlist[indexPath.row].RepairState == "已上报"
            {
                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: bxsearchlist.bxsearchlist[indexPath.row].RepairID)
                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let destinationStoryboard = UIStoryboard(name:"BaoxiuStoryboard",bundle:nil)
                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: YiShangBaoDetailController())))
                    as! YiShangBaoDetailController
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
            if bxsearchlist.bxsearchlist[indexPath.row].RepairState == "弃修"
            {
                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: bxsearchlist.bxsearchlist[indexPath.row].RepairID)
                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let destinationStoryboard = UIStoryboard(name:"BaoxiuStoryboard",bundle:nil)
                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: QiXIuViewController())))
                    as! QiXIuViewController
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
            if bxsearchlist.bxsearchlist[indexPath.row].RepairState == "已撤销"
            {
                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: bxsearchlist.bxsearchlist[indexPath.row].RepairID)
                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let destinationStoryboard = UIStoryboard(name:"BaoxiuStoryboard",bundle:nil)
                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: CheXiaoViewController())))
                    as! CheXiaoViewController
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
            else
            {
                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: bxsearchlist.bxsearchlist[indexPath.row].RepairID)
                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let destinationStoryboard = UIStoryboard(name:"BaoxiuStoryboard",bundle:nil)
                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: QiTaStateViewController())))
                    as! QiTaStateViewController
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
        }
        else
        {
            if baoxiulist.bxlist[indexPath.row].RepairState == "已完修"
            {
                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: baoxiulist.bxlist[indexPath.row].RepairID)
                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let destinationStoryboard = UIStoryboard(name:"BaoxiuStoryboard",bundle:nil)
                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: YiWanXiuViewController())))
                    as! YiWanXiuViewController
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
            if baoxiulist.bxlist[indexPath.row].RepairState == "已上报"
            {
                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: baoxiulist.bxlist[indexPath.row].RepairID)
                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let destinationStoryboard = UIStoryboard(name:"BaoxiuStoryboard",bundle:nil)
                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: YiShangBaoDetailController())))
                    as! YiShangBaoDetailController
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
            if baoxiulist.bxlist[indexPath.row].RepairState == "弃修"
            {
                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: baoxiulist.bxlist[indexPath.row].RepairID)
                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let destinationStoryboard = UIStoryboard(name:"BaoxiuStoryboard",bundle:nil)
                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: QiXIuViewController())))
                    as! QiXIuViewController
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
            if baoxiulist.bxlist[indexPath.row].RepairState == "已撤销"
            {
                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: baoxiulist.bxlist[indexPath.row].RepairID)
                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let destinationStoryboard = UIStoryboard(name:"BaoxiuStoryboard",bundle:nil)
                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: CheXiaoViewController())))
                    as! CheXiaoViewController
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
            else
            {
                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: baoxiulist.bxlist[indexPath.row].RepairID)
                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let destinationStoryboard = UIStoryboard(name:"BaoxiuStoryboard",bundle:nil)
                let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: QiTaStateViewController())))
                    as! QiTaStateViewController
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        baoxiulist.loadData()
        bxsearchlist.loadData()
        if JieXiuSearchTableview == tableView
        {
        let shouli = UITableViewRowAction(style: .normal, title: "受理"){
            actionm, index in
            if self.bxsearchlist.bxsearchlist[indexPath.row].RepairState == "已上报"
            {
                let requesting : Models_ShouLi.Requesting = Models_ShouLi.Requesting(RepairID: self.bxsearchlist.bxsearchlist[indexPath.row].RepairID, operation: "受理",RepairState: self.bxsearchlist.bxsearchlist[indexPath.row].RepairState)
                ShouLiReposity().ShouLi(requesting: requesting){(response, error) in
                    if error == nil, let response = response{
                self.bxsearchlist.bxsearchlist[indexPath.row] = BaoxiuSearchList(RepairID:  self.bxsearchlist.bxsearchlist[indexPath.row].RepairID,EqptName: self.bxsearchlist.bxsearchlist[indexPath.row].EqptName,RepairState:"待分配")
                self.bxsearchlist.saveData()
                        
                        let alerttController = UIAlertController(title: "提示！", message: response.ts, preferredStyle: .alert)
                        let okkAction =  UIAlertAction(title: "好的" , style: .default , handler:{
                            action in
                            self.JieXiuSearchTableview.reloadData()
                        })
                        alerttController.addAction(okkAction)
                        self.present( alerttController, animated:  true, completion: nil)
                        
                    }
                }
                
            }
            
            else
            {
                let alerttController = UIAlertController(title: "提示！", message: "无法再次受理！", preferredStyle: .alert)
                let okkAction =  UIAlertAction(title: "好的" , style: .default , handler:{
                    action in
                    self.JieXiuSearchTableview.reloadData()
                })
                alerttController.addAction(okkAction)
                self.present( alerttController, animated:  true, completion: nil)
            }
            
            
        }
        let fenpei = UITableViewRowAction(style: .normal, title: "分配"){
            actionm, index in
            if self.bxsearchlist.bxsearchlist[indexPath.row].RepairState == "已上报" || self.bxsearchlist.bxsearchlist[indexPath.row].RepairState == "待检修" || self.bxsearchlist.bxsearchlist[indexPath.row].RepairState == "检修中"
            {
                let alerttController = UIAlertController(title: "提示！", message: "此维修单无法分配！", preferredStyle: .alert)
                let okkAction =  UIAlertAction(title: "好的" , style: .default , handler:{
                    action in
                    self.JieXiuSearchTableview.reloadData()
                })
                alerttController.addAction(okkAction)
                self.present( alerttController, animated:  true, completion: nil)
                
            }
            else
            {
                
            }
            
            
        }
        shouli.backgroundColor = UIColor.blue
        fenpei.backgroundColor = UIColor.orange
        return [shouli,fenpei]
        }
        else
        {
            let shouli = UITableViewRowAction(style: .normal, title: "受理"){
                actionm, index in
                
                if self.baoxiulist.bxlist[indexPath.row].RepairState == "已上报"
                {
                    let requesting : Models_ShouLi.Requesting = Models_ShouLi.Requesting(RepairID: self.baoxiulist.bxlist[indexPath.row].RepairID, operation: "受理",RepairState: self.baoxiulist.bxlist[indexPath.row].RepairState)
                    ShouLiReposity().ShouLi(requesting: requesting){(response, error) in
                        if error == nil, let response = response{
                            self.baoxiulist.bxlist[indexPath.row] = BaoxiuList(RepairID:  self.baoxiulist.bxlist[indexPath.row].RepairID,EqptName: self.baoxiulist.bxlist[indexPath.row].EqptName,RepairState:"待分配")
                            self.baoxiulist.saveData()
                            
                            let alerttController = UIAlertController(title: "提示！", message: response.ts, preferredStyle: .alert)
                            let okkAction =  UIAlertAction(title: "好的" , style: .default , handler:{
                                action in
                                self.JieXiuTableview.reloadData()
                            })
                            alerttController.addAction(okkAction)
                            self.present( alerttController, animated:  true, completion: nil)
                            
                        }
                    }
                    
                }
                else
                {
                    let alerttController = UIAlertController(title: "提示！", message: "无法再次受理！", preferredStyle: .alert)
                    let okkAction =  UIAlertAction(title: "好的" , style: .default , handler:{
                        action in
                        self.JieXiuTableview.reloadData()
                    })
                    alerttController.addAction(okkAction)
                    self.present( alerttController, animated:  true, completion: nil)
                }
                
                
            }
            let fenpei = UITableViewRowAction(style: .normal, title: "分配"){
                actionm, index in
                
                if self.baoxiulist.bxlist[indexPath.row].RepairState == "已上报" || self.baoxiulist.bxlist[indexPath.row].RepairState == "待检修" || self.baoxiulist.bxlist[indexPath.row].RepairState == "检修中"
                {
                    let alerttController = UIAlertController(title: "提示！", message: "此维修单无法分配！", preferredStyle: .alert)
                    let okkAction =  UIAlertAction(title: "好的" , style: .default , handler:{
                        action in
                        self.JieXiuTableview.reloadData()
                    })
                    alerttController.addAction(okkAction)
                    self.present( alerttController, animated:  true, completion: nil)
                    
                }
                else
                {
                    
                }
                
            }
            shouli.backgroundColor = UIColor.blue
            fenpei.backgroundColor = UIColor.orange
            return [shouli,fenpei]
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

extension JieXiuViewController {
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

