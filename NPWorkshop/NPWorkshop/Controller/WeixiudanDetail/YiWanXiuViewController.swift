//
//  YiWanXiuViewController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/10.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
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
    
    var repairid : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.guzhangxianxiang.layer.borderColor = UIColor(red: 206/255, green: 205/255, blue: 205/255, alpha: 1).cgColor
        
        self.guzhangxianxiang.layer.borderWidth = 2
        
        self.guzhangxianxiang.layer.cornerRadius = 16
        
        self.guzhangyuanyin.layer.borderColor = UIColor(red: 206/255, green: 205/255, blue: 205/255, alpha: 1).cgColor
        
        self.guzhangyuanyin.layer.borderWidth = 2
        
        self.guzhangyuanyin.layer.cornerRadius = 16
        peijiantableview.delegate = self
        peijiantableview.dataSource = self
        guzhangxianxiang.isEditable = false
        guzhangyuanyin.isEditable = false
        let parameters :[String : Any] = [
            "RepairID": String(repairid)//左边是接口
        ]
        
        
        Alamofire.request("http://172.16.101.66:8083/api/RepAPI/RepDetail", method: .post, parameters:parameters,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if response.result.value != nil {
                do{
                    self.detaillist.loadData()
                    self.peijianuselist.loadData()
                    self.detaillist.detail.removeAll()
                    self.detaillist.saveData()
                    self.peijianuselist.pjuselist.removeAll()
                    self.peijianuselist.saveData()
                    if let json = try? JSONSerialization.jsonObject(with: response.data! as Data, options: .allowFragments) as? [String:AnyObject],
                        let repvm = json?["rep_list"] as?[[String: AnyObject]]{
                        for i in repvm
                        {
                            print(i)
                        }
                        self.detaillist.detail.append(DetailList(Appearance: (repvm[0]["Appearance"] as? String ?? "")! , ApplyUser: (repvm[0]["ApplyUser"] as? String ?? "")!, AssetsNumber: (repvm[0]["AssetsNumber"] as? String ?? "")!, BXUser: (repvm[0]["BXUser"] as? String ?? "")!, CancelReason: (repvm[0]["CancelReason"] as? String ?? "")!, DeptName: (repvm[0]["DeptName"] as? String ?? "")!, EqptName: (repvm[0]["EqptName"] as? String ?? "")!, FinishTime: (repvm[0]["FinishTime"] as? String ?? "")!, Laborcost: ((repvm[0]["Laborcost"] as? NSNumber)?.stringValue ?? "")!, Parameter: (repvm[0]["Parameter"] as? String ?? "")!, Reason: (repvm[0]["Reason"] as? String ?? "")!, RepairID: (repvm[0]["RepairID"] as? String ?? "")!, RepairState: (repvm[0]["RepairState"] as? String ?? "")!, RepairTime: (repvm[0]["RepairTime"] as? String ?? "")!, RepairUser: (repvm[0]["RepairUser"] as? String ?? "")!, Telphone: (repvm[0]["Telphone"] as? String ?? "")!, Total: ((repvm[0]["Total"] as? NSNumber)?.stringValue ?? "")!, Accepter: (repvm[0]["Accepter"] as? String ?? "")!))
                        self.detaillist.saveData()
                        
                        
                    }
                    if let json1 = try? JSONSerialization.jsonObject(with: response.data! as Data, options: .allowFragments) as? [String:AnyObject],
                        let outvm = json1?["outgoingvm"] as?[[String: AnyObject]]{
                        count = outvm.count
                        for x in outvm
                        {
                            print(x)
                        }
                        
                        if count == 0
                        {
                            return
                        }
                        else
                        {
                            for i in 0...count - 1
                            {
                                self.peijianuselist.pjuselist.append(PeiJianUserList(peijianminchen: outvm[i]["PartsName"] as! String, peijiannum: ((outvm[i]["PartsAmount"] as? NSNumber)?.stringValue)!, peijianmoney: ((outvm[i]["PartsPrice"] as? NSNumber)?.stringValue)!, peijiantotal: ((outvm[i]["Subtotal"] as? NSNumber)?.stringValue)!))
                                self.peijianuselist.saveData()
                            }
                        }
                        
                    }
                    self.xianshi()
                    
                    
                }
                catch{}
                
                
            }
            else
            {
                
            }
        }
        // Do any additional setup after loading the view.
    }
    
    
    
    func xianshi()
    {
        
        detaillist.loadData()
        peijianuselist.loadData()
        
        
        
        baoxiuid.text = detaillist.detail[0].RepairID
        shebeiname.text =  detaillist.detail[0].EqptName
        zichanxuhao.text = detaillist.detail[0].AssetsNumber
        xinghaocanshu.text = detaillist.detail[0].Parameter
        baoxiuzhuangtai.text = detaillist.detail[0].RepairState
        if detaillist.detail[0].Appearance == ""
        {
            guzhangxianxiang.text = "无"
        }
        else
        {
            if detaillist.detail[0].Appearance.contains("<p>")
            {
                let index1 = detaillist.detail[0].Appearance.index(detaillist.detail[0].Appearance.startIndex, offsetBy: 3)
                let index2 = detaillist.detail[0].Appearance.index(detaillist.detail[0].Appearance.endIndex, offsetBy: -4)
                guzhangxianxiang.text = String(detaillist.detail[0].Appearance[index1 ..< index2])
            }
            else
            {
                guzhangxianxiang.text = detaillist.detail[0].Appearance
            }
        }
        
        if detaillist.detail[0].Reason == ""
        {
            guzhangyuanyin.text = "无"
        }
        else
        {
            if  detaillist.detail[0].Reason.contains("<p>")
            {
                let index3 = detaillist.detail[0].Reason.index(detaillist.detail[0].Reason.startIndex, offsetBy: 3)
                let index4 = detaillist.detail[0].Reason.index(detaillist.detail[0].Reason.endIndex, offsetBy: -4)
                guzhangyuanyin.text = String(detaillist.detail[0].Reason[index3 ..< index4])
            }
            else
            {
                
                guzhangyuanyin.text = detaillist.detail[0].Reason
            }
        }
        baoxiuren.text = detaillist.detail[0].BXUser
        baoxiubumen.text = detaillist.detail[0].DeptName
        lianxifangshi.text = detaillist.detail[0].Telphone
        jiexiuren.text = detaillist.detail[0].Accepter
        weixiuren.text = detaillist.detail[0].RepairUser
        peijianshengouyuan.text = detaillist.detail[0].ApplyUser
        rengongfei.text = detaillist.detail[0].Laborcost
        weixiujine.text = detaillist.detail[0].Total
        baoxiushijian.text = detaillist.detail[0].RepairTime
        wanxiushijian.text = detaillist.detail[0].FinishTime
        
        peijiantableview.reloadData()
        
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
        cell.peijiandanjia.text = "¥" + peijianuselist.pjuselist[indexPath.row].peijianmoney
        cell.peijiantotal.text = "¥" + peijianuselist.pjuselist[indexPath.row].peijiantotal
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
