//
//  QiXiuReposity.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/21.
//  Copyright © 2019年 韩意谦. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON

class QiXiuReposity: NSObject {

    func QiXiu(requesting: Models_QiXiu.Requesting, handler:  @escaping(_ response: Models_QiXiu.Response?, _ error: String?) -> Void)
    {
        let parameters :[String : Any] = [
            "type": requesting.type,
            "Laborcost": requesting.RenGonfei,
            "Reason": requesting.QiXiuReason,
              "RepairID": requesting.RepairId
        ]
        
        Alamofire.request("http://172.16.101.66:8083/api/RepAPI/RepairFinish", method: .post, parameters:parameters,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if response.error == nil{//先判断response返回有没有error
                if let data = response.data{
                    do{
                        let jsonData: JSON = try JSON(data: data)
                        for i in jsonData
                        {
                            print(i)
                        }
                        let response : Models_QiXiu.Response = Models_QiXiu.Response(jsonData: jsonData)
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
