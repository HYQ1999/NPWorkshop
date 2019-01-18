//
//  BaoxiuReposity.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/13.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

var userlist = UserModel()
var baoxiulist = BaoxiuModel()
var data: NSData!
var count:Int!
var BaoxiuUrl = "172.16.101.66:8083/api/RepAPI"
var httpMethod = "POST"
var timeoutInterval = 10.0 //超时时间
class BaoxiuReposity: NSObject {
   func Baoxiulist()
   {
     userlist.loadData()
    if userlist.userlist.isEmpty == false
    {
    
    var Response: [Models_Baoxiu.Response]? = [Models_Baoxiu.Response(RepairID: nil, EqptName: nil, RepairState: nil)]
        
        Response?.removeAll()
        let parameters :[String : Any] = [
            "UserID": userlist.userlist[0].userid //左边是接口
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
                            print(repvm[i]["RepairID"] as! String)
                          baoxiulist.loadData()
                            baoxiulist.bxlist.append(BaoxiuList(RepairID: repvm[i]["RepairID"] as! String, EqptName: repvm[i]["EqptName"] as! String, RepairState: repvm[i]["RepairState"] as! String))
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
            
            
              NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_Baoxiu"), object: Response)
//                if let data = response.data{
//                    do{
//
//                        let jsonData: JSON = try JSON(data: data)
//                        let response : Models_Baoxiu.Response = Models_Baoxiu.Response(jsonData: jsonData)
//                        handler(response, nil)
//
////                        print(jsonData.count)
////                         for i in 0..<jsonData.count
////                         {
////                            Response?.append(Models_Baoxiu.Response(
////                                RepairID: jsonData[i]["RepairID"].string,
////                                EqptName: jsonData[i]["EqptName"].string,
////                                RepairState: jsonData[i]["RepairState"].string))
////                        }
//                    }
//                    catch{}
//
//                }
        
            
        }
    }
    }
    
    
    
   
}
