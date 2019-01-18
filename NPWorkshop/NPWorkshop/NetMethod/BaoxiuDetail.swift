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
    baoxiulist.loadData()
    detaillist.loadData()
    peijianuselist.loadData()
    let parameters :[String : Any] = [
        "RepairID": requesting.RepairID//左边是接口
    ]
    
    
    Alamofire.request("http://172.16.101.66:8083/api/RepAPI/RepDetail", method: .post, parameters:parameters,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
        if response.result.value != nil {
            do{
                //当收到JSON相应时
                //                print(response.request as Any)
                //                print(response.result.value as Any)
                if let json = try? JSONSerialization.jsonObject(with: response.data! as Data, options: .allowFragments) as? [String:AnyObject],
                    let repvm = json?["rep_list"] as?[[String: AnyObject]],let outvm = json?["outgoingvm"] as?[[String: AnyObject]]{
                    self.detaillist.detail.append(DetailList(Appearance: repvm[0]["Appearance"] as! String, ApplyUser: repvm[0]["ApplyUser"] as! String, AssetsNumber: repvm[0]["AssetsNumber"] as! String, BXUser: repvm[0]["BXUser"] as! String, CancelReason: repvm[0]["CancelReason"] as! String, DeptName: repvm[0]["DeptName"] as! String, EqptName: repvm[0]["EqptName"] as! String, FinishTime: repvm[0]["FinishTime"] as! String, Laborcost: repvm[0]["Laborcost"] as! String, Parameter: repvm[0]["Parameter"] as! String, Reason: repvm[0]["Reason"] as! String, RepairID: repvm[0]["RepairID"] as! String, RepairState: repvm[0]["RepairState"] as! String, RepairTime: repvm[0]["RepairTime"] as! String, RepairUser: repvm[0]["RepairUser"] as! String, Telphone: repvm[0]["Telphone"] as! String, Total: repvm[0]["Total"] as! String, TotalCost: repvm[0]["TotalCost"] as! String))
                    self.detaillist.saveData()
                    count = outvm.count
                    
                    if count == 0
                    {
                        return
                    }
                    else
                    {
                        for i in 0...count - 1
                        {
                            self.peijianuselist.pjuselist.append(PeiJianUserList(peijianminchen: outvm[i]["PartsName"] as! String, peijiannum: outvm[i]["PartsAmount"] as! String, peijianmoney: outvm[i]["PartsPrice"] as! String, peijiantotal: outvm[i]["Subtotal"] as! String))
                            self.peijianuselist.saveData()
                        }
                    }
                    
//                    for i in 0...count - 1 {
//                        print(repvm[i]["RepairID"] as! String)
//                        //                                        print(i)
//                    }
                    
                    
                }
                
                
            }
            catch{}
        }
        else{
            
        }
        
    }
    
    
    }
}
