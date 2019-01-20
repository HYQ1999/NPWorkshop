//
//  FixViewController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/17.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit
import ProgressHUD
class FixViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate {
  var search:UISearchBar!
     @IBOutlet weak var MenuItem: UIBarButtonItem!
    @IBOutlet weak var FixSearchtableview: UITableView!
    @IBOutlet weak var FixTableview: UITableView!
    
    var weixiuModel = WeixiuModel()
    var weixiuUserModel = WeiXiuUserModel()
    var tablelist: [Models_Weixiu.Response] = []
     var tablelists: [Models_WeixiuSearch.Response] = []
    
      var bxsearchlist = BaoxiuSearchModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController().rearViewRevealWidth = 250
        customSetup()
        FixSearchtableview.delegate = self
        FixSearchtableview.dataSource = self
        FixTableview.delegate = self
        FixTableview.dataSource = self
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
            NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrders(_:)), name: NSNotification.Name(rawValue: "Models_Weixiu"), object: nil)
            Messages().showNow(code: 0x2004)
            weixiuModel.loadData()
            weixiuModel.wxlist.removeAll()
            weixiuModel.saveData()
            FixTableview.isHidden = false
            FixSearchtableview.isHidden = true
            WeixiuReposity().Weixiulist()
        }
        else
        {
              NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrder(_:)), name: NSNotification.Name(rawValue: "Models_WeixiuSearch"), object: nil)
              Messages().showNow(code: 0x2004)
              weixiuModel.loadData()
            if weixiuModel.wxlist.isEmpty
            {
                let alertController = UIAlertController(title: "提示!",
                                                        message: "查无此报修单(请填写正确的设备名称)！", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "返回", style: .default,handler:
                {
                    action in
                    NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrders(_:)), name: NSNotification.Name(rawValue: "Models_Weixiu"), object: nil)
                    Messages().showNow(code: 0x2004)
                    self.weixiuModel.loadData()
                    self.weixiuModel.wxlist.removeAll()
                    self.weixiuModel.saveData()
                    self.FixTableview.isHidden = false
                    self.FixSearchtableview.isHidden = true
                    WeixiuReposity().Weixiulist()
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else
            {
            for i in 0...weixiuModel.wxlist.count - 1
            {
                if weixiuModel.wxlist[i].EqptName.hasPrefix(search.text!)
                {
                    let requesting :  Models_WeixiuSearch.Requesting =  Models_WeixiuSearch.Requesting(EqpName: search.text!)
                    WeixiuSearchResposity().Search(requesting: requesting)
                    FixTableview.isHidden = true
                    FixSearchtableview.isHidden = false
                    return
                }
            }
            let alertController = UIAlertController(title: "提示!",
                                                    message: "查无此报修单(请填写正确的设备名称)！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "返回", style: .default,handler:
            {
                action in
                NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrders(_:)), name: NSNotification.Name(rawValue: "Models_Weixiu"), object: nil)
                Messages().showNow(code: 0x2004)
                self.weixiuModel.loadData()
                self.weixiuModel.wxlist.removeAll()
                self.weixiuModel.saveData()
                self.FixTableview.isHidden = false
                self.FixSearchtableview.isHidden = true
                WeixiuReposity().Weixiulist()
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            }
            
        }
    }
    
    @objc func TakeOrders(_ notification:Notification) {
        if let Response: [Models_Weixiu.Response] = notification.object as! [Models_Weixiu.Response]?{
            tablelist = Response
            FixTableview.reloadData()
            ProgressHUD.dismiss()
        }
        else {
            Messages().showError(code: 0x1002)
        }
    }
    @objc func TakeOrder(_ notification:Notification) {
        if let Response: [Models_WeixiuSearch.Response] = notification.object as! [Models_WeixiuSearch.Response]?{
            tablelists = Response
            FixSearchtableview.reloadData()
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
        weixiuModel.loadData()
        if FixSearchtableview == tableView
        {
            return  bxsearchlist.bxsearchlist.count
        }
        else
        {
            return  weixiuModel.wxlist.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        bxsearchlist.loadData()
        weixiuModel.loadData()
        if FixSearchtableview == tableView
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
            cell.baoxiuid.text = weixiuModel.wxlist[indexPath.row].FixID
            cell.shebeimingchen.text = weixiuModel.wxlist[indexPath.row].EqptName
            cell.baoxiustyle.text = weixiuModel.wxlist[indexPath.row].FixState
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
          let destinationStoryboard = UIStoryboard(name:"BaoxiuStoryboard",bundle:nil)
        let controller = destinationStoryboard.instantiateViewController(withIdentifier: String(describing: type(of: tianxieViewController())))
            as! tianxieViewController
//        let controller = self.storyboard!.instantiateViewController(withIdentifier: String(describing: type(of: tianxieViewController())))
//            as! tianxieViewController
//        controller.repairid = bxsearchlist.bxsearchlist[indexPath.row].RepairID
        
                   self.navigationController?.pushViewController(controller, animated: true)
        return
        //          baoxiulist.loadData()
        //        let requesting :  Models_BaoxiuSearch.Requesting =  Models_BaoxiuSearch.Requesting(EqpName: baoxiulist.bxlist[indexPath.row].EqptName)
        //        BaoxiuSearchResposity().Search(requesting: requesting)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        bxsearchlist.loadData()
        weixiuModel.loadData()
        if FixSearchtableview == tableView
        {
            let start = UITableViewRowAction(style: .normal, title: "开始检修") {
                action , index in
                if self.bxsearchlist.bxsearchlist[indexPath.row].RepairState == "检修中"
                {
                    let alerttController = UIAlertController(title: "Error！", message: "此维修单已开始检修", preferredStyle: .alert)
                    let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
                    alerttController.addAction(okkAction)
                    self.present( alerttController, animated:  true, completion: nil)
                }
                else if(self.bxsearchlist.bxsearchlist[indexPath.row].RepairState == "待检修")
                {
                    let alertController = UIAlertController(title: "提示",
                                                            message: "操作成功！", preferredStyle: .alert)
                    //                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                    let okAction = UIAlertAction(title: "好的", style: .default, handler: {
                        action in
                        let requesting : Models_Start.Requesting = Models_Start.Requesting(RepairID: self.bxsearchlist.bxsearchlist[indexPath.row].RepairID, operation: "开始检修")
                        StartReposity().Start(requesting: requesting)
                        {(response, error) in
                            if error == nil, let response = response
                            {
                                self.bxsearchlist.bxsearchlist[indexPath.row] = BaoxiuSearchList(RepairID: self.bxsearchlist.bxsearchlist[indexPath.row].RepairID,EqptName: self.bxsearchlist.bxsearchlist[indexPath.row].EqptName,RepairState:"检修中")
                                self.bxsearchlist.saveData()
                                let alerttController = UIAlertController(title: "提示！", message: response.ts, preferredStyle: .alert)
                                let okkAction =  UIAlertAction(title: "好的" , style: .default , handler:{
                                    action in
                                    self.FixSearchtableview.reloadData()
                                })
                                alerttController.addAction(okkAction)
                                self.present( alerttController, animated:  true, completion: nil)
                            }
                            
                        }
                        
                    })
                    //                alertController.addAction(cancelAction)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            start.backgroundColor = UIColor.orange
            
            //    let look = UITableViewRowAction(style: .normal, title: "查看详细") {
            //        action , index in
            //    }
            //    look.backgroundColor = UIColor.blue
            
            return [start]
        }
        else
        {
        let start = UITableViewRowAction(style: .normal, title: "开始检修") {
            action , index in
            if self.weixiuModel.wxlist[indexPath.row].FixState == "检修中"
            {
                let alerttController = UIAlertController(title: "Error！", message: "此维修单已开始检修", preferredStyle: .alert)
                let okkAction =  UIAlertAction(title: "好的" , style: .default , handler: nil )
                alerttController.addAction(okkAction)
                self.present( alerttController, animated:  true, completion: nil)
            }
            else if(self.weixiuModel.wxlist[indexPath.row].FixState == "待检修")
            {
              
                    self.weixiuModel.loadData()
                    let requesting : Models_Start.Requesting = Models_Start.Requesting(RepairID: self.weixiuModel.wxlist[indexPath.row].FixID, operation: "开始检修")
                    StartReposity().Start(requesting: requesting)
                    {(response, error) in
                        if error == nil, let response = response
                        {
                            self.weixiuModel.wxlist[indexPath.row] = WeixiuList(FixID: self.weixiuModel.wxlist[indexPath.row].FixID,EqptName: self.weixiuModel.wxlist[indexPath.row].EqptName,FixState:"检修中")
                            self.weixiuModel.saveData()
                            let alerttController = UIAlertController(title: "提示！", message: response.ts, preferredStyle: .alert)
                            let okkAction =  UIAlertAction(title: "好的" , style: .default , handler:{
                                action in
                            self.FixTableview.reloadData()
                            })
                            alerttController.addAction(okkAction)
                            self.present( alerttController, animated:  true, completion: nil)
                        }
                        
                    }
                    
    
                //                alertController.addAction(cancelAction)
          
            }
        }
        start.backgroundColor = UIColor.orange
        
        //    let look = UITableViewRowAction(style: .normal, title: "查看详细") {
        //        action , index in
        //    }
        //    look.backgroundColor = UIColor.blue
        
        return [start]
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
extension FixViewController {
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
