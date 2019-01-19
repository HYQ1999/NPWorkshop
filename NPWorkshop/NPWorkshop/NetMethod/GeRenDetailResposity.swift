//
//  GeRenDetailResposity.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/19.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GeRenDetailResposity: NSObject {

    var userdetaillist = GerenDetailModel()
    func UserDetail()
    {
        Alamofire.request("http://172.16.101.66:8083/api/RepAPI/Info_Personal", method: .post, parameters:nil,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if response.result.value != nil {
                do{
//                    //当收到JSON相应时
//                    //                print(response.request as Any)
//                    //                print(response.result.value as Any)
                    
                    self.userdetaillist.loadData()
                    self.userdetaillist.userdetail.removeAll()
                    self.userdetaillist.saveData()
                    if let json = try? JSONSerialization.jsonObject(with: response.data! as Data, options: .allowFragments) as? [String:AnyObject],
                        let repvm = json?["rpvm"] as?[[String: AnyObject]]{
                        self.userdetaillist.userdetail.append(GerenDetailList(username: repvm[0]["UserName"] as! String, userbumen: repvm[0]["role"] as! String, userqq: repvm[0]["QQ"] as! String, userdianhua: repvm[0]["Telphone"] as! String, userpassword: repvm[0]["PassWord"] as! String))
                        
                        self.userdetaillist.saveData()
                    }
//                        count = repvm.count
//                        print(count)
//                        if count == 0
//                        {
//                            NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_Baoxiu"), object: Response)
//                            return
//                        }
//                        else
//                        {
//                            for i in 0...count - 1 {
//                                print(repvm[i]["UserID"] as! String)
//                                baoxiulist.loadData()
//                                baoxiulist.bxlist.append(BaoxiuList(RepairID: repvm[i]["UserID"] as! String, EqptName: repvm[i]["UserName"] as! String, RepairState: repvm[i]["QX"] as! String))
//                                baoxiulist.saveData()
//                                //                                        print(i)
//                            }
//
//                        }
//                    }
                    
                    
                }
                catch{}
            }
            else{
               
            }
                
            }
        }
    }
    

