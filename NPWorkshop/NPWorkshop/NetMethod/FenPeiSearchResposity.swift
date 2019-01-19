//
//  FenPeiSearchResposity.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/17.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
var weixiuuser = WeiXiuRenModel()
class FenPeiSearchResposity: NSObject {

    
    func Search()
    {
        var Response: [Models_FenPeiSearch.Response]? = [Models_FenPeiSearch.Response(UserID: nil, UserName: nil, QX:nil )]
        
        Response?.removeAll()
           Alamofire.request("http://172.16.101.66:8083/api/RepAPI/Repair_users", method: .post, parameters:nil,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            if response.result.value != nil {
                do{
                    if let json = try? JSONSerialization.jsonObject(with: response.data! as Data, options: .allowFragments) as? [String:AnyObject],
                        let uservm = json?["uservm"] as?[[String: AnyObject]]{
                        count = uservm.count
                        print(count)
                        weixiuuser.loadData()
                        weixiuuser.weixiulist.removeAll()
                        weixiuuser.saveData()
                        for i in uservm
                        {
                            print(i)
                        }
                        
                        if count == 0
                        {
                              NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_FenPeiSearch"), object: Response)
                            return
                        }
                        else
                        {
                            for i in 0...count - 1 {
                                weixiuuser.weixiulist.append(WeiXiuRenList(userid: uservm[i]["UserID"] as! String, username: uservm[i]["UserName"] as! String, userqx: uservm[i]["UserRight"] as! String))
                                weixiuuser.saveData()


                            }
                        }
                        
                        
                    }
                    
                }
                catch{}
            }
            else{
                Response = nil
            }
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_FenPeiSearch"), object: Response)
            
            
        }
        
        
        
    }
}
