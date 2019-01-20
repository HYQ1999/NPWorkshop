//
//  BaoxiuDetail.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/16.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
class BaoxiuDetail: NSObject {
    var baoxiulist = BaoxiuModel()
    var detaillist = DetailModel()
    var peijianuselist = PeiJianUserModel()
func Baoxiudetail(requesting: Models_BaoxiuDetail.Requesting)
{
    
    var Response: [Models_BaoxiuDetail.Response]? = [Models_BaoxiuDetail.Response(RepairID: nil, EqptName: nil, RepairState: nil)]
    Response?.removeAll()
    
    let parameters :[String : Any] = [
        "RepairID": requesting.RepairID//左边是接口
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
//                当收到JSON相应时
//                                print(response.request as Any)
//                                print(response.result.value as Any)
//                ,let outvm = json?["outgoingvm"] as?[[String: AnyObject]]
                if let json = try? JSONSerialization.jsonObject(with: response.data! as Data, options: .allowFragments) as? [String:AnyObject],
                    let repvm = json?["rep_list"] as?[[String: AnyObject]]{
                    for i in repvm
                    {
                        print(i)
                    }
//                    self.detaillist.detail.append(DetailList(Appearance: repvm[0]["Appearance"] as! String, ApplyUser: repvm[0]["ApplyUser"] as! String, AssetsNumber: repvm[0]["AssetsNumber"] as! String, BXUser: repvm[0]["BXUser"] as! String, CancelReason: repvm[0]["CancelReason"] as! String, DeptName: repvm[0]["DeptName"] as! String, EqptName: repvm[0]["EqptName"] as! String, FinishTime: repvm[0]["FinishTime"] as! String, Laborcost: repvm[0]["Laborcost"] as! String, Parameter: repvm[0]["Parameter"] as! String, Reason: repvm[0]["Reason"] as! String, RepairID: repvm[0]["RepairID"] as! String, RepairState: repvm[0]["RepairState"] as! String, RepairTime: repvm[0]["RepairTime"] as! String, RepairUser: repvm[0]["RepairUser"] as! String, Telphone: repvm[0]["Telphone"] as! String, Total: repvm[0]["Total"] as! String, TotalCost: repvm[0]["Accepter"] as! String))
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

                
            }
            catch{}
        }
        else{
            
        }
        
           NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_BaoxiuDetail"), object: Response)
        
        
    }
    
    
    }
}
