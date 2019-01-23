//
//  DaoHuoMsgResposity.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/22.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DaoHuoMsgResposity: NSObject {
var daohuolist = DaoHuoMessageModel()
    var userlist = UserModel()
    var weixiuuserlist = WeiXiuUserModel()
    func Daohuolist()
    {
        userlist.loadData()
        weixiuuserlist.loadData()
        var Response: [
            Models_DaoHuoMsg.Response]? = [Models_DaoHuoMsg.Response(message: nil, repairid: nil, fasonren: nil, shijian: nil)]
        
        Response?.removeAll()
        
        
        if userlist.userlist.isEmpty
        {
            let parameters :[String : Any] = [
                "UserID": weixiuuserlist.userlist[0].userid
            ]
            
            Alamofire.request("http://172.16.101.66:8083/api/RepAPI/Messages_daohuo", method: .post, parameters:parameters,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
                if response.result.value != nil {
                    do{
                        //当收到JSON相应时
                        //                print(response.request as Any)
                        //                print(response.result.value as Any)
                        if let json = try? JSONSerialization.jsonObject(with: response.data! as Data, options: .allowFragments) as? [String:AnyObject],
                            let repvm = json?["msgvm"] as?[[String: AnyObject]]{
                            count = repvm.count
                            print(count)
                            for i in repvm
                            {
                                print(i)
                            }
                            if count == 0
                            {
                                NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_DaoHuoMsg"), object: Response)
                                return
                            }
                            else
                            {
                                for i in 0...count - 1 {
                                    self.daohuolist.loadData()
                                    self.daohuolist.daohuomsg.append(DaoHuoMessageList(tongzhiren: repvm[i]["Publisher"] as! String, shijian: repvm[i]["AddDate"] as! String, message: repvm[i]["MsgContent"] as! String, repairid: (repvm[i]["RepairID"] as? String ?? "")!))
                                    self.daohuolist.saveData()
                                }
                            }
                            
                        }
                        
                        
                    }
                    catch{}
                }
                else{
                    Response = nil
                }
                
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_DaoHuoMsg"), object: Response)
                
                
            }
            
            
        }
        else
        {
        let parameters :[String : Any] = [
            "UserID": userlist.userlist[0].userid
        ]
            
            
            Alamofire.request("http://172.16.101.66:8083/api/RepAPI/Messages_daohuo", method: .post, parameters:parameters,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
                if response.result.value != nil {
                    do{
                        //当收到JSON相应时
                        //                print(response.request as Any)
                        //                print(response.result.value as Any)
                        if let json = try? JSONSerialization.jsonObject(with: response.data! as Data, options: .allowFragments) as? [String:AnyObject],
                            let repvm = json?["msgvm"] as?[[String: AnyObject]]{
                            count = repvm.count
                            print(count)
                            for i in repvm
                            {
                                print(i)
                            }
                            if count == 0
                            {
                                NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_DaoHuoMsg"), object: Response)
                                return
                            }
                            else
                            {
                                for i in 0...count - 1 {
                                    self.daohuolist.loadData()
                                    self.daohuolist.daohuomsg.append(DaoHuoMessageList(tongzhiren: repvm[i]["Publisher"] as! String, shijian: repvm[i]["AddDate"] as! String, message: repvm[i]["MsgContent"] as! String, repairid: (repvm[i]["RepairID"] as? String ?? "")!))
                                    self.daohuolist.saveData()
                                }
                            }
                            
                        }
                        
                        
                    }
                    catch{}
                }
                else{
                    Response = nil
                }
                
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_DaoHuoMsg"), object: Response)
                
                
            }
            
        }
        
        
    
    }
        
    }
    
    

