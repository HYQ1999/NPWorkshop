//
//  ManShengouResposity.swift
//  NPWorkshop
//
//  Created by 欧张帆 on 2019/1/21.
//  Copyright © 2019 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ManShengouResposity: NSObject {
    
    var manList = ManShengouModel()
    func ManShengouList()
    {

        var Response: [Model_ManShengou.Response]? = [Model_ManShengou.Response(ShengouId: nil, ShengouName: nil, ShengouQX: nil)]
        
        Response?.removeAll()
        
        Alamofire.request("http://172.16.101.66:8083/api/RepAPI/shengouUser", method: .post, parameters:nil,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if response.result.value != nil {
                do{
                    //当收到JSON相应时
                    //                print(response.request as Any)
                    //                print(response.result.value as Any)
                    if let json = try? JSONSerialization.jsonObject(with: response.data! as Data, options: .allowFragments) as? [String:AnyObject],
                        let repvm = json?["uservm"] as?[[String: AnyObject]]{
                        count = repvm.count
                        
                        for x in repvm
                        {
                            print(x)
                        }
                        print(count)
                        if count == 0
                        {
                            NotificationCenter.default.post(name: Notification.Name(rawValue: "Model_ManShengou"), object: Response)
                            return
                        }
                        else
                        {
                            for i in 0...count - 1 {
                             self.manList.loadData()

                               self.manList.Manpeijianlist.append(ManshengouList(userid: repvm[i]["UserID"] as! String, username: repvm[i]["UserName"] as! String, userqx: repvm[i]["UserRight"] as! String))
//                                peijianlist.saveData()
                                self.manList.saveData()
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
            
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "Model_ManShengou"), object: Response)
        }
        
        
        
    }
    
    
}
