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
        }
        else
        {
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "baoxiusearchcell", for: indexPath) as! BaoxiuSearchTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //          baoxiulist.loadData()
        //        let requesting :  Models_BaoxiuSearch.Requesting =  Models_BaoxiuSearch.Requesting(EqpName: baoxiulist.bxlist[indexPath.row].EqptName)
        //        BaoxiuSearchResposity().Search(requesting: requesting)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let shouli = UITableViewRowAction(style: .normal, title: "受理"){
            actionm, index in
        }
        let fenpei = UITableViewRowAction(style: .normal, title: "分配"){
            actionm, index in
        }
        shouli.backgroundColor = UIColor.blue
        fenpei.backgroundColor = UIColor.orange
        return [shouli]
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

