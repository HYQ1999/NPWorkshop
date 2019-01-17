//
//  PeiJianListResposity.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/17.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class PeiJianListResposity: NSObject {

    func PeiJianList()
    {
        userlist.loadData()
        
        var Response: [Models_PeiJianList.Response]? = [Models_PeiJianList.Response(PeiJianName: nil, PeiJianNum: nil, PeiJianLeibie: nil, PEiJIanDanJIa: nil)]
        
        Response?.removeAll()
        let parameters :[String : Any] = [
            "UserId": userlist.userlist[0].userid //左边是接口
        ]
        
        Alamofire.request("http://172.16.101.66:8083/api/RepAPI/PostRepLists", method: .post, parameters:parameters,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if response.result.value != nil {
                do{
                    //当收到JSON相应时
                    //                print(response.request as Any)
                    //                print(response.result.value as Any)
                    if let json = try? JSONSerialization.jsonObject(with: response.data! as Data, options: .allowFragments) as? [String:AnyObject],
                        let repvm = json?["repvm"] as?[[String: AnyObject]]{
                        count = repvm.count
                        print(count)
                        for i in 0...count - 1 {
                            print(repvm[i]["UserID"] as! String)
                            baoxiulist.loadData()
                            baoxiulist.bxlist.append(BaoxiuList(RepairID: repvm[i]["UserID"] as! String, EqptName: repvm[i]["UserName"] as! String, RepairState: repvm[i]["QX"] as! String))
                            baoxiulist.saveData()
                            //                                        print(i)
                        }
                        
                        
                    }
                    
                    
                }
                catch{}
            }
            else{
                Response = nil
            }
            
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_PeiJianList"), object: Response)
        }
        
        
        
    }
    
    
}
