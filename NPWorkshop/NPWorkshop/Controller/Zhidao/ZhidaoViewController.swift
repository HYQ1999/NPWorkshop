//
//  ZhidaoViewController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2018/12/29.
//  Copyright © 2018年 韩意谦. All rights reserved.
//

import UIKit
import ProgressHUD
class ZhidaoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate {
    
    
 
    var search:UISearchBar!
    @IBOutlet weak var ZhiDaosearchTableview: UITableView!
   
    @IBOutlet weak var ZhiDaoListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        ZhiDaosearchTableview.delegate = self
        ZhiDaosearchTableview.dataSource = self
        ZhiDaoListTableView.delegate = self
        ZhiDaoListTableView.dataSource = self
       
        search = UISearchBar(frame:CGRect(x:0, y:0, width:300, height:20))
        search.barTintColor = UIColor.white
        search.searchBarStyle = UISearchBar.Style.minimal
        search.barStyle = UIBarStyle(rawValue: 0)!
        search.barStyle = UIBarStyle.black
        search.tintColor = UIColor.blue
        search.placeholder = "请输入设备名称"
        var logo = UIImageView(image:UIImage(named: "weixiu"))
        var rightNavBarButton = UIBarButtonItem(customView:search)
        var logoes = UIBarButtonItem(customView:logo)
        
        let gap = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                  action: nil)
        gap.width = 10;
        
        self.navigationItem.leftBarButtonItems = [logoes,gap,rightNavBarButton]
        search.delegate = self
        
        self.tabBarItem = UITabBarItem(title: "我的分配", image: UIImage(named: "wodefenpei"),
                                       selectedImage: UIImage(named: "fenpei"))
        
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
        return 0
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
extension ZhidaoViewController {
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
