//
//  ZhiDaoSearchResposity.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/17.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ZhiDaoSearchResposity: NSObject {

    
    func Search(requesting: Models_ZhiDaoSearch.Requesting)
    {
        userlist.loadData()
        
        let parameters :[String : Any] = [
            //左边是接口
            "EqptName": requesting.EqpName
        ]
        
        var Response: [Models_ZhiDaoSearch.Response]? = [Models_ZhiDaoSearch.Response(RepairID: nil, EqptName: nil, RepairState: nil)]
        
        Response?.removeAll()
        
        Alamofire.request("http://172.16.101.66:8083/api/RepAPI/RepairList", method: .post, parameters:parameters,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if response.result.value != nil {
                do{
                    if let json = try? JSONSerialization.jsonObject(with: response.data! as Data, options: .allowFragments) as? [String:AnyObject],
                        let repvm = json?["repvm"] as?[[String: AnyObject]]{
                        count = repvm.count
                        print(count)
                        for i in repvm
                        {
                            print(i)
                        }
                        bxsearchlist.loadData()
                        bxsearchlist.bxsearchlist.removeAll()
                        bxsearchlist.saveData()
                        
                        if count == 1
                        {
                            print(repvm[0]["RepairID"] as! String)
                            bxsearchlist.bxsearchlist.append(BaoxiuSearchList(RepairID: repvm[0]["RepairID"] as! String, EqptName: repvm[0]["EqptName"] as! String, RepairState: repvm[0]["RepairState"] as! String))
                            bxsearchlist.saveData()
                        }
                        else
                        {
                            for i in 0...count - 1
                            {
                                print(repvm[i]["RepairID"] as! String)
                                bxsearchlist.loadData()
                                bxsearchlist.bxsearchlist.append(BaoxiuSearchList(RepairID: repvm[i]["RepairID"] as! String, EqptName: repvm[i]["EqptName"] as! String, RepairState: repvm[i]["RepairState"] as! String))
                                bxsearchlist.saveData()
                            }
                        }
                        
                        //                                        print(i)
                        
                        
                    }
                    
                    
                }
                catch{}
            }
            else{
                Response = nil
            }
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_ZhiDaoSearch"), object: Response)
            
        }
        
        
    }
    
}
