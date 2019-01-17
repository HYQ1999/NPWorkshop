//
//  ZhidaoViewController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2018/12/29.
//  Copyright © 2018年 韩意谦. All rights reserved.
//

import UIKit
import ProgressHUD
class ZhidaoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
 
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
        search.placeholder = "请输入搜索信息"
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
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
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
