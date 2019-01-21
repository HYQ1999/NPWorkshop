//
//  ShenGouReposity.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/17.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ShenGouReposity: NSObject {

    func ShenGouList()
    {
        
        var Response: [Models_ShenGou.Response]? = [Models_ShenGou.Response(RepairID: nil, EqptName: nil, RepairState: nil)]
        
        Response?.removeAll()
        let parameters :[String : Any] = [
            "RepairUser": ""//左边是接口
        ]
        
        
        Alamofire.request("http://172.16.101.66:8083/api/RepAPI/RepairList", method: .post, parameters:parameters,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if response.result.value != nil {
                do{
                    if let json = try? JSONSerialization.jsonObject(with: response.data! as Data, options: .allowFragments) as? [String:AnyObject],
                        let repvm = json?["repvm"] as?[[String: AnyObject]]{
                        count = repvm.count
                        print(count)
                        if count == 0
                        {
                            NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_ShenGou"), object: Response)
                            return
                        }
                        else
                        {
                        for i in 0...count - 1 {
                            print(repvm[i]["RepairID"] as! String)
                            baoxiulist.loadData()
                            baoxiulist.bxlist.append(BaoxiuList(RepairID: repvm[i]["RepairID"] as! String, EqptName: repvm[i]["EqptName"] as! String, RepairState: repvm[i]["RepairState"] as! String))
                            baoxiulist.saveData()
                            //                                        print(i)
                        }
                        }
                        
                    }
                    
                    
                }
                catch{}
            }
            else{
                Response = nil
            }
            
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_ShenGou"), object: Response)
        }
    }
    
}
