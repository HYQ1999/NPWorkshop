//
//  WeixiuReposity.swift
//  NPWorkshop
//
//  Created by 欧张帆 on 2019/1/16.
//  Copyright © 2019 韩意谦. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

var weixiuModel = WeixiuModel()
var weixiuuserModel = WeiXiuUserModel()

class WeixiuReposity: NSObject {
    func Weixiulist()
    {
        weixiuuserModel.loadData()
        var Response: [Models_Weixiu.Response]? = [Models_Weixiu.Response(RepairID: nil, EqptName: nil, RepairState: nil)]
        
        Response?.removeAll()
        let parameters :[String : Any] = [
            "RepairUser": weixiuuserModel.userlist[0].userid,
            "role": weixiuuserModel.userlist[0].userrole,
            "rights": weixiuuserModel.userlist[0].quanxian
        ]
        Alamofire.request("http://172.16.101.66:8083/api/RepAPI/RepairList", method: .post, parameters:parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            if response.result.value != nil {
                do{
                    if let json = try? JSONSerialization.jsonObject(with: response.data! as Data, options: .allowFragments) as? [String:AnyObject],
                        let repvm = json?["repvm"] as?[[String: AnyObject]]{
                        count = repvm.count
                        print(count)
                        if count == 0
                        {
                            NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_Weixiu"), object: Response)
                            return
                        }
                        else
                        {
                        for i in 0..<count-1 {
                            print(repvm[i]["RepairID"] as! String)
                            weixiuModel.loadData()
                            weixiuModel.wxlist.append(WeixiuList(FixID: repvm[i]["RepairID"] as! String, EqptName: repvm[i]["EqptName"] as! String, FixState: repvm[i]["RepairState"] as! String))
                            weixiuModel.saveData()
                            //                                        print(i)
                        }
                        }
                    }
                }
                catch{}
            }
            else
            {
                //                response = nil
            }
            NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_Weixiu"), object: Response)
        }
    }
    
}
