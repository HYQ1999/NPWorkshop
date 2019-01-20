//
//  QiXIuViewController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/16.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class QiXIuViewController: UIViewController {

    @IBOutlet weak var baoxiuid: UILabel!
    @IBOutlet weak var shebeimingcheng: UILabel!
    @IBOutlet weak var cichanxuhao: UILabel!
    @IBOutlet weak var xinhaocanshu: UILabel!
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
       var detaillist = DetailModel()
    var repairid : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.guzhangxianxiang.layer.borderColor = UIColor(red: 206/255, green: 205/255, blue: 205/255, alpha: 1).cgColor
        
        self.guzhangxianxiang.layer.borderWidth = 2
        
        self.guzhangxianxiang.layer.cornerRadius = 16
        
        self.guzhangyuanyin.layer.borderColor = UIColor(red: 206/255, green: 205/255, blue: 205/255, alpha: 1).cgColor
        
        self.guzhangyuanyin.layer.borderWidth = 2
        
        self.guzhangyuanyin.layer.cornerRadius = 16
        
        let parameters :[String : Any] = [
            "RepairID": String(repairid)//左边是接口
        ]
        
        
        Alamofire.request("http://172.16.101.66:8083/api/RepAPI/RepDetail", method: .post, parameters:parameters,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if response.result.value != nil {
                do{
                    self.detaillist.loadData()
                    self.detaillist.detail.removeAll()
                    self.detaillist.saveData()
                    if let json = try? JSONSerialization.jsonObject(with: response.data! as Data, options: .allowFragments) as? [String:AnyObject],
                        let repvm = json?["rep_list"] as?[[String: AnyObject]]{
                        for i in repvm
                        {
                            print(i)
                        }
                        self.detaillist.detail.append(DetailList(Appearance: (repvm[0]["Appearance"] as? String ?? "")! , ApplyUser: (repvm[0]["ApplyUser"] as? String ?? "")!, AssetsNumber: (repvm[0]["AssetsNumber"] as? String ?? "")!, BXUser: (repvm[0]["BXUser"] as? String ?? "")!, CancelReason: (repvm[0]["CancelReason"] as? String ?? "")!, DeptName: (repvm[0]["DeptName"] as? String ?? "")!, EqptName: (repvm[0]["EqptName"] as? String ?? "")!, FinishTime: (repvm[0]["FinishTime"] as? String ?? "")!, Laborcost: ((repvm[0]["Laborcost"] as? NSNumber)?.stringValue ?? "")!, Parameter: (repvm[0]["Parameter"] as? String ?? "")!, Reason: (repvm[0]["Reason"] as? String ?? "")!, RepairID: (repvm[0]["RepairID"] as? String ?? "")!, RepairState: (repvm[0]["RepairState"] as? String ?? "")!, RepairTime: (repvm[0]["RepairTime"] as? String ?? "")!, RepairUser: (repvm[0]["RepairUser"] as? String ?? "")!, Telphone: (repvm[0]["Telphone"] as? String ?? "")!, Total: ((repvm[0]["Total"] as? NSNumber)?.stringValue ?? "")!, Accepter: (repvm[0]["Accepter"] as? String ?? "")!))
                        self.detaillist.saveData()
                        
                        
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
        baoxiuid.text = detaillist.detail[0].RepairID
        shebeimingcheng.text =  detaillist.detail[0].EqptName
        cichanxuhao.text = detaillist.detail[0].AssetsNumber
        xinhaocanshu.text = detaillist.detail[0].Parameter
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
