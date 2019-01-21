//
//  YiShangBaoDetailController.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/4.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class YiShangBaoDetailController: UIViewController {

    @IBOutlet weak var baoxiuid: UILabel!
    @IBOutlet weak var shebeimingcheng: UILabel!
    @IBOutlet weak var zichannum: UILabel!
    @IBOutlet weak var xinhaocanshu: UILabel!
    @IBOutlet weak var baoxiuzhuangtai: UILabel!
    @IBOutlet weak var baoxiuren: UILabel!
    @IBOutlet weak var guzhangxianxiang: UITextView!
    @IBOutlet weak var baoxiubumen: UILabel!
    @IBOutlet weak var lianxifangshi: UILabel!
    @IBOutlet weak var baoxiushijian: UILabel!
    var detaillist = DetailModel()
    var repairid : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.guzhangxianxiang.layer.borderColor = UIColor(red: 206/255, green: 205/255, blue: 205/255, alpha: 1).cgColor
        
        self.guzhangxianxiang.layer.borderWidth = 2
        
        self.guzhangxianxiang.layer.cornerRadius = 16
        
        let parameters :[String : Any] = [
            "RepairID": String(repairid)//左边是接口
        ]
        guzhangxianxiang.isEditable = false
        
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
        zichannum.text = detaillist.detail[0].AssetsNumber
        xinhaocanshu.text = detaillist.detail[0].Parameter
        baoxiuzhuangtai.text = detaillist.detail[0].RepairState
        baoxiuren.text = detaillist.detail[0].BXUser
        if detaillist.detail[0].Appearance == ""
        {
            guzhangxianxiang.text = "无"
        }
        else
        {
            print(detaillist.detail[0].Appearance)
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
        baoxiubumen.text = detaillist.detail[0].DeptName
        lianxifangshi.text = detaillist.detail[0].Telphone
        baoxiushijian.text = detaillist.detail[0].RepairTime
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
