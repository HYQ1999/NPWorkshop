//
//  MessagePeijianResposity.swift
//  NPWorkshop
//
//  Created by 欧张帆 on 2019/1/21.
//  Copyright © 2019 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessagePeijianResposity: NSObject {
    
    func Message(requesting: Models_MessagePeijian.Requesting, handler:  @escaping(_ response: Models_MessagePeijian.Response?, _ error: String?) -> Void)
    {
        let parameters :[String : Any] = [
            
            "PartsAmount": requesting.PartsAmount,
            "PartsID": requesting.PartsID,
            "ApplyUser": requesting.ApplyUser,
             "UserID": requesting.UserID
//            self.RepairID = RepairID
//            self.PartsAmount = PartsAmount
//            self.PartsID = PartsID
//            self.ApplyUser = ApplyUser
//            self.UserID = UserID
        ]
        
        Alamofire.request("http://172.16.101.66:8083/api/RepAPI/PartsApply", method: .post, parameters:parameters,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if response.error == nil{//先判断response返回有没有error
                if let data = response.data{
                    do{
                        let jsonData: JSON = try JSON(data: data)
                        for i in jsonData
                        {
                            print(i)
                        }
                        let response : Models_MessagePeijian.Response = Models_MessagePeijian.Response(jsonData: jsonData)
                        handler(response, nil)
                    }
                    catch{}
                }
            }
            else if response.error != nil{
                handler(nil, "网络连接失败")
            }
            
        }
    }
    
}
