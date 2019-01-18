//
//  YiWanXiuViewController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/10.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class YiWanXiuViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    

    
    @IBOutlet weak var baoxiuid: UILabel!
    @IBOutlet weak var shebeiname: UILabel!
    @IBOutlet weak var zichanxuhao: UILabel!
    @IBOutlet weak var xinghaocanshu: UILabel!
    @IBOutlet weak var baoxiuzhuangtai: UILabel!
    @IBOutlet weak var guzhangxianxiang: UITextView!
    @IBOutlet weak var guzhangyuanyin: UITextView!
    @IBOutlet weak var baoxiuren: UILabel!
    @IBOutlet weak var baoxiubumen: UILabel!
    @IBOutlet weak var lianxifangshi: UILabel!
    @IBOutlet weak var jiexiuren: UILabel!
    @IBOutlet weak var weixiuren: UILabel!
    @IBOutlet weak var peijianshengouyuan: UILabel!
    @IBOutlet weak var rengongfei: UILabel!
    @IBOutlet weak var weixiujine: UILabel!
    @IBOutlet weak var baoxiushijian: UILabel!
    @IBOutlet weak var wanxiushijian: UILabel!
    @IBOutlet weak var peijiantableview: UITableView!
    
    var detaillist = DetailModel()
    var peijianuselist = PeiJianUserModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        peijiantableview.delegate = self
        peijiantableview.dataSource = self

        detaillist.loadData()
        peijianuselist.loadData()


        baoxiuid.text = detaillist.detail[0].RepairID
        shebeiname.text =  detaillist.detail[0].EqptName
        zichanxuhao.text = detaillist.detail[0].AssetsNumber
        xinghaocanshu.text = detaillist.detail[0].Parameter
        baoxiuzhuangtai.text = detaillist.detail[0].RepairState
         guzhangxianxiang.text = detaillist.detail[0].Appearance
        guzhangyuanyin.text = detaillist.detail[0].Reason
        baoxiuren.text = detaillist.detail[0].BXUser
        baoxiubumen.text = detaillist.detail[0].DeptName
        lianxifangshi.text = detaillist.detail[0].Telphone
        jiexiuren.text = detaillist.detail[0].TotalCost
        weixiuren.text = detaillist.detail[0].RepairUser
        peijianshengouyuan.text = detaillist.detail[0].ApplyUser
        rengongfei.text = detaillist.detail[0].Laborcost
        weixiujine.text = detaillist.detail[0].Total
        baoxiushijian.text = detaillist.detail[0].TotalCost
        wanxiushijian.text = detaillist.detail[0].FinishTime
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        peijianuselist.loadData()
        return peijianuselist.pjuselist.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        peijianuselist.loadData()
        let cell = tableView.dequeueReusableCell(withIdentifier: "peijianusecell", for: indexPath) as! PeiJianUseCell
        cell.peijianname.text = peijianuselist.pjuselist[indexPath.row].peijianminchen
        cell.peijianshuliang.text = peijianuselist.pjuselist[indexPath.row].peijiannum
        cell.peijiandanjia.text = peijianuselist.pjuselist[indexPath.row].peijianmoney
        cell.peijiantotal.text = peijianuselist.pjuselist[indexPath.row].peijiantotal
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
