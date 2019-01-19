//
//  BaoxiuViewController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2018/12/29.
//  Copyright © 2018年 韩意谦. All rights reserved.
//

import UIKit
import ProgressHUD
class BaoxiuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate  {

    
    var search:UISearchBar!
    var baoxiulist = BaoxiuModel()
    var tablelist: [Models_Baoxiu.Response] = []
     var tablelists: [Models_BaoxiuSearch.Response] = []
    var bxsearchlist = BaoxiuSearchModel()
     @IBOutlet weak var baoxiulistableview: UITableView!
    @IBOutlet weak var baoxiusearchtableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        baoxiulistableview.delegate = self
        baoxiulistableview.dataSource = self
        baoxiusearchtableview.delegate = self
        baoxiusearchtableview.dataSource = self
        search = UISearchBar(frame:CGRect(x:0, y:0, width:300, height:20))
        search.barTintColor = UIColor.white
        search.searchBarStyle = UISearchBar.Style.minimal
        search.barStyle = UIBarStyle(rawValue: 0)!
        search.barStyle = UIBarStyle.black
        search.tintColor = UIColor.blue
        search.placeholder = "请输入设备名称"
        
        
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
        
         addDoneButtonOnKeyboard()
        
        // Do any additional setup after loading the view.
    }
    
    //在键盘上添加“完成“按钮
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
        
        
        
//        let gestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.hideKeyboard(_:)))
//
//        gestureRecognizer.numberOfTapsRequired = 1
//        gestureRecognizer.cancelsTouchesInView = false
//
//        baoxiulistableview.addGestureRecognizer(gestureRecognizer)
//        baoxiusearchtableview.addGestureRecognizer(gestureRecognizer)
        if search.text == ""
        {
            NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrders(_:)), name: NSNotification.Name(rawValue: "Models_Baoxiu"), object: nil)
            Messages().showNow(code: 0x2004)
            baoxiulist.loadData()
            baoxiulist.bxlist.removeAll()
            baoxiulist.saveData()
            baoxiulistableview.isHidden = false
            baoxiusearchtableview.isHidden = true
            BaoxiuReposity().Baoxiulist()
        }
        
        else
        {
            NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrder(_:)), name: NSNotification.Name(rawValue: "Models_BaoxiuSearch"), object: nil)
            Messages().showNow(code: 0x2004)
             baoxiulist.loadData()
            
            if baoxiulist.bxlist.isEmpty
            {
                let alertController = UIAlertController(title: "提示!",
                                                        message: "查无此报修单(请填写正确的设备名称)！", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "返回", style: .default,handler:
                {
                    action in
                    NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrders(_:)), name: NSNotification.Name(rawValue: "Models_Baoxiu"), object: nil)
                    
                    Messages().showNow(code: 0x2004)
                    self.search.text = ""
                    self.baoxiulist.loadData()
                    self.baoxiulist.bxlist.removeAll()
                    self.baoxiulist.saveData()
                    self.baoxiulistableview.isHidden = false
                    self.baoxiusearchtableview.isHidden = true
                    
                    
                    BaoxiuReposity().Baoxiulist()
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
                    let requesting :  Models_BaoxiuSearch.Requesting =  Models_BaoxiuSearch.Requesting(EqpName: search.text!)
                    BaoxiuSearchResposity().Search(requesting: requesting)
                    baoxiulistableview.isHidden = true
                    baoxiusearchtableview.isHidden = false
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
                NotificationCenter.default.addObserver(self, selector: #selector(self.TakeOrders(_:)), name: NSNotification.Name(rawValue: "Models_Baoxiu"), object: nil)
               
                Messages().showNow(code: 0x2004)
                self.search.text = ""
                self.baoxiulist.loadData()
                self.baoxiulist.bxlist.removeAll()
                self.baoxiulist.saveData()
                self.baoxiulistableview.isHidden = false
                self.baoxiusearchtableview.isHidden = true
                
                
                BaoxiuReposity().Baoxiulist()
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            
        }
        }
        
        
        
    }
    
    @IBAction func viewclick(_ sender: Any) {
        self.view.endEditing(true)
        search.resignFirstResponder()
    }
    //   @objc  func hideKeyboard(_ notification:Notification) {
//        search.resignFirstResponder()
//    }
   
  
    
    @objc func TakeOrders(_ notification:Notification) {
        if let Response: [Models_Baoxiu.Response] = notification.object as! [Models_Baoxiu.Response]?{
            tablelist = Response
            baoxiulistableview.reloadData()
            ProgressHUD.dismiss()
        }
        else {
            Messages().showError(code: 0x1002)
        }
    }
    
    @objc func TakeOrder(_ notification:Notification) {
        if let Response: [Models_BaoxiuSearch.Response] = notification.object as! [Models_BaoxiuSearch.Response]?{
            tablelists = Response
            baoxiusearchtableview.reloadData()
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
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        baoxiulist.loadData()
        bxsearchlist.loadData()
        if baoxiusearchtableview == tableView
        {
            return bxsearchlist.bxsearchlist.count
        }
        else
        {
        return baoxiulist.bxlist.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        baoxiulist.loadData()
        bxsearchlist.loadData()
        if baoxiusearchtableview == tableView
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        baoxiulist.loadData()
        bxsearchlist.loadData()
        if baoxiusearchtableview == tableView
        {
          if bxsearchlist.bxsearchlist[indexPath.row].RepairState == "已完修"
          {
             let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: bxsearchlist.bxsearchlist[indexPath.row].RepairID)
            BaoxiuDetail().Baoxiudetail(requesting: requesting)
            
            let controller = self.storyboard!.instantiateViewController(withIdentifier: String(describing: type(of: YiWanXiuViewController())))
                as! YiWanXiuViewController
            self.navigationController?.pushViewController(controller, animated: true)
            return
            
          }
          if bxsearchlist.bxsearchlist[indexPath.row].RepairState == "已上报"
          {
            let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: bxsearchlist.bxsearchlist[indexPath.row].RepairID)
            BaoxiuDetail().Baoxiudetail(requesting: requesting)
            
            let controller = self.storyboard!.instantiateViewController(withIdentifier: String(describing: type(of: YiShangBaoDetailController())))
                as! YiShangBaoDetailController
            self.navigationController?.pushViewController(controller, animated: true)
             return
            }
            if bxsearchlist.bxsearchlist[indexPath.row].RepairState == "弃修"
            {
                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: bxsearchlist.bxsearchlist[indexPath.row].RepairID)
                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let controller = self.storyboard!.instantiateViewController(withIdentifier: String(describing: type(of: QiXIuViewController())))
                    as! QiXIuViewController
                self.navigationController?.pushViewController(controller, animated: true)
                 return
            }
            if bxsearchlist.bxsearchlist[indexPath.row].RepairState == "已撤销"
            {
                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: bxsearchlist.bxsearchlist[indexPath.row].RepairID)
                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let controller = self.storyboard!.instantiateViewController(withIdentifier: String(describing: type(of: CheXiaoViewController())))
                    as! CheXiaoViewController
                self.navigationController?.pushViewController(controller, animated: true)
                 return
            }
            else
            {
                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: bxsearchlist.bxsearchlist[indexPath.row].RepairID)
                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let controller = self.storyboard!.instantiateViewController(withIdentifier: String(describing: type(of: QiTaStateViewController())))
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
                print(baoxiulist.bxlist[indexPath.row].RepairID)
                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let controller = self.storyboard!.instantiateViewController(withIdentifier: String(describing: type(of: YiWanXiuViewController())))
                    as! YiWanXiuViewController
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
            if baoxiulist.bxlist[indexPath.row].RepairState == "已上报"
            {
                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: baoxiulist.bxlist[indexPath.row].RepairID)
                print(baoxiulist.bxlist[indexPath.row].RepairID)
                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let controller = self.storyboard!.instantiateViewController(withIdentifier: String(describing: type(of: YiShangBaoDetailController())))
                    as! YiShangBaoDetailController
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
            if baoxiulist.bxlist[indexPath.row].RepairState == "弃修"
            {
                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: baoxiulist.bxlist[indexPath.row].RepairID)
                print(baoxiulist.bxlist[indexPath.row].RepairID)
                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let controller = self.storyboard!.instantiateViewController(withIdentifier: String(describing: type(of: QiXIuViewController())))
                    as! QiXIuViewController
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
            if baoxiulist.bxlist[indexPath.row].RepairState == "已撤销"
            {
                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: baoxiulist.bxlist[indexPath.row].RepairID)
                print(baoxiulist.bxlist[indexPath.row].RepairID)
                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let controller = self.storyboard!.instantiateViewController(withIdentifier: String(describing: type(of: CheXiaoViewController())))
                    as! CheXiaoViewController
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
            else
            {
                let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: baoxiulist.bxlist[indexPath.row].RepairID)
                print(baoxiulist.bxlist[indexPath.row].RepairID)
                BaoxiuDetail().Baoxiudetail(requesting: requesting)
                
                let controller = self.storyboard!.instantiateViewController(withIdentifier: String(describing: type(of: QiTaStateViewController())))
                    as! QiTaStateViewController
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        baoxiulist.loadData()
        bxsearchlist.loadData()
        if baoxiusearchtableview == tableView
        {
            let chehui = UITableViewRowAction(style: .normal, title: "撤销") {
                action , index in
                //            self.baoxiulist.loadData()
                //
                ////            let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: self.baoxiulist.bxlist[indexPath.row].RepairID)
                //            BaoxiuDetail().Baoxiudetail()
                if self.bxsearchlist.bxsearchlist[indexPath.row].RepairState != "已上报"
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
                        
                        let requesting : Models_CheXiao.Requesting = Models_CheXiao.Requesting(RepairID: self.bxsearchlist.bxsearchlist[indexPath.row].RepairID, operation: "撤销",RepairState: self.bxsearchlist.bxsearchlist[indexPath.row].RepairState,Mark1:newpw.text!)
                        CheXiaoReposity().Chexiao(requesting: requesting){(response, error) in
                            if error == nil, let response = response{
                                
                               self.bxsearchlist.bxsearchlist[indexPath.row] = BaoxiuSearchList(RepairID:  self.bxsearchlist.bxsearchlist[indexPath.row].RepairID,EqptName: self.bxsearchlist.bxsearchlist[indexPath.row].EqptName,RepairState:"已撤销")
                                self.bxsearchlist.saveData()
                                let alerttController = UIAlertController(title: "提示！", message: response.ts, preferredStyle: .alert)
                                let okkAction =  UIAlertAction(title: "好的" , style: .default , handler:{
                                    action in
                                    self.baoxiusearchtableview.reloadData()
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
        else
        {
        let chehui = UITableViewRowAction(style: .normal, title: "撤销") {
            action , index in
            //            self.baoxiulist.loadData()
            //
            ////            let requesting : Models_BaoxiuDetail.Requesting = Models_BaoxiuDetail.Requesting(RepairID: self.baoxiulist.bxlist[indexPath.row].RepairID)
            //            BaoxiuDetail().Baoxiudetail()
            if self.baoxiulist.bxlist[indexPath.row].RepairState != "已上报"
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
                    let requesting : Models_CheXiao.Requesting = Models_CheXiao.Requesting(RepairID: self.baoxiulist.bxlist[indexPath.row].RepairID, operation: "撤销",RepairState: self.baoxiulist.bxlist[indexPath.row].RepairState,Mark1:newpw.text!)
                    CheXiaoReposity().Chexiao(requesting: requesting){(response, error) in
                        if error == nil, let response = response{
    
                            self.baoxiulist.bxlist[indexPath.row] = BaoxiuList(RepairID: self.baoxiulist.bxlist[indexPath.row].RepairID,EqptName:self.baoxiulist.bxlist[indexPath.row].EqptName,RepairState:"已撤销")
                            self.baoxiulist.saveData()
                            let alerttController = UIAlertController(title: "提示！", message: response.ts, preferredStyle: .alert)
                            let okkAction =  UIAlertAction(title: "好的" , style: .default , handler:{
                                action in
                                self.baoxiulistableview.reloadData()
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


extension BaoxiuViewController {
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

