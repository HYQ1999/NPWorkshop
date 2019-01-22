//
//  ShenGouMsgResposity.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/22.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ShenGouMsgResposity: NSObject {
    var shengoulist = ShenGouMessageModel()
    func shengouMesage()
    {
        var Response: [Models_ShenGouMsg.Response]? = [Models_ShenGouMsg.Response(message: nil, repairid: nil, shengouren: nil, shijian: nil)]
        Response?.removeAll()
        
        //        Alamofire.request("http://172.16.101.66:8083/api/RepAPI/Message_Apply", method: .post, parameters:nil,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
        //            if response.result.value != nil {
        //            }
        //        }
        Alamofire.request("http://172.16.101.66:8083/api/RepAPI/Message_Apply", method: .post, parameters:nil,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if response.result.value != nil {
                do{
                    //当收到JSON相应时
                    //                print(response.request as Any)
                    //                print(response.result.value as Any)
                    if let json = try? JSONSerialization.jsonObject(with: response.data! as Data, options: .allowFragments) as? [String:AnyObject],
                        let repvm = json?["msgvm"] as?[[String: AnyObject]]{
                        count = repvm.count
                        
                        for x in repvm
                        {
                            print(x)
                        }
                        print(count)
                        if count == 0
                        {
                            NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_ShenGouMsg"), object: Response)
                            return
                        }
                        else
                        {
                            for i in 0...count - 1 {
                                self.shengoulist.loadData()
                                
                                self.shengoulist.shengoumsg.append(ShenGouMessageList(shengouren: repvm[i]["Publisher"] as! String, shijian: repvm[i]["AddDate"] as! String, message: repvm[i]["MsgContent"] as! String, repairid: (repvm[i]["RepairID"] as? String ?? "")!))
                                
                                self.shengoulist.saveData()
                                
                                
                                
                                
                            }
                            
                        }
                    }
                    
                    
                }
                catch{}
            }
            else{
                Response = nil
            }
            
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_ShenGouMsg"), object: Response)
        }
        
    }
}
