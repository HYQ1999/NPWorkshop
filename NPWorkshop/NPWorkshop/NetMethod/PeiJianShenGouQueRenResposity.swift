//
//  PeiJianShenGouQueRenResposity.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/22.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PeiJianShenGouQueRenResposity: NSObject {
    var querendaohuolist = QueRenDaoHuoModel()
    func PeiJianShenGouQueRenlist()
    {
        
        var Response: [
            Models_PeiJianShenGouQueRen.Response]? = [Models_PeiJianShenGouQueRen.Response(peijianshenbaoid: nil, peijianleibie: nil, peijianmingchen: nil, peijianshenbaoren: nil, shenbaoshuliang: nil, shenbaozhuangtai: nil, shenbaoshijian: nil, RepairID: nil, PartsID: nil)]
        
        Response?.removeAll()
        
        
        Alamofire.request("http://172.16.101.66:8083/api/RepAPI/ApplyList", method: .post, parameters:nil,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if response.result.value != nil {
                do{
                    //当收到JSON相应时
                    //                print(response.request as Any)
                    //                print(response.result.value as Any)
                    if let json = try? JSONSerialization.jsonObject(with: response.data! as Data, options: .allowFragments) as? [String:AnyObject],
                        let repvm = json?["applyvm"] as?[[String: AnyObject]]{
                        count = repvm.count
                        print(count)
                        for i in repvm
                        {
                            print(i)
                        }
                        if count == 0
                        {
                            NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_PeiJianShenGouQueRen"), object: Response)
                            return
                        }
                        else
                        {
                            for i in 0...count - 1 {
                                self.querendaohuolist.loadData()
                                self.querendaohuolist.querendaohuo.append(QueRenDaoHuoList(peijianshenbaoid: repvm[i]["PartsApplyID"] as! String, peijianleibie: repvm[i]["Mark3"] as! String, peijianmingchen: repvm[i]["PartsName"] as! String, peijianshenbaoren: repvm[i]["ReplyUser"] as! String, shenbaoshuliang: ((repvm[i]["PartsAmount"] as? NSNumber)?.stringValue)!, shenbaozhuangtai: repvm[i]["ApplyState"] as! String, shenbaoshijian: repvm[i]["ApplyDate"] as! String, RepairID: repvm[i]["RepairID"] as! String, PartsID: repvm[i]["PartsID"] as! String))
                                self.querendaohuolist.saveData()
                            }
                        }
                        
                    }
                    
                    
                }
                catch{}
            }
            else{
                Response = nil
            }
            
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_PeiJianShenGouQueRen"), object: Response)
            
            
        }
        
    }
    
    
}
