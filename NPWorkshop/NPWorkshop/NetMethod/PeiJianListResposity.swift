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
        var peijianlist = PeiJianModel()
        userlist.loadData()
        
        var Response: [Models_PeiJianList.Response]? = [Models_PeiJianList.Response(PeiJianName: nil, PeiJianNum: nil, PeiJianLeibie: nil, PEiJIanDanJIa: nil)]
        
        Response?.removeAll()
        
        Alamofire.request("http://172.16.101.66:8083/api/RepAPI/Part_List", method: .post, parameters:nil,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if response.result.value != nil {
                do{
                    //当收到JSON相应时
                    //                print(response.request as Any)
                    //                print(response.result.value as Any)
                    if let json = try? JSONSerialization.jsonObject(with: response.data! as Data, options: .allowFragments) as? [String:AnyObject],
                        let repvm = json?["partsvm"] as?[[String: AnyObject]]{
                        count = repvm.count
                        
                        for x in repvm
                        {
                            print(x)
                        }
                        print(count)
                        if count == 0
                        {
                            NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_PeiJianList"), object: Response)
                            return
                        }
                        else
                        {
                        for i in 0...count - 1 {
                            peijianlist.loadData()
                            peijianlist.pjlist.append(Peijianllist(peijianminchen: repvm[i]["PartsName"] as! String, peijiankucun: ((repvm[i]["PartsStock"] as? NSNumber)?.stringValue)!, peijianleibie: repvm[i]["PartsTypeName"] as! String, peijiandanjia: ((repvm[i]["PartsPrice"] as? NSNumber)?.stringValue)!, peijianid: repvm[i]["PartsID"] as! String))
                            peijianlist.saveData()
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
            
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_PeiJianList"), object: Response)
        }
        
        
        
    }
    
    
}
