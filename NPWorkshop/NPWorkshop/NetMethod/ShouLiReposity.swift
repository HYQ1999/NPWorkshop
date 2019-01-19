//
//  ShouLiReposity.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/18.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ShouLiReposity: NSObject {

    func ShouLi(requesting: Models_ShouLi.Requesting, handler:  @escaping(_ response: Models_ShouLi.Response?, _ error: String?) -> Void)
    {
        let parameters :[String : Any] = [
            "RepairID": requesting.RepairID,//左边是接口
            "operation": requesting.operation,
            "RepairState":requesting.RepairState,
        ]
        
        Alamofire.request("http://172.16.101.66:8083/api/RepAPI/Cancel_Rep", method: .post, parameters:parameters,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if response.error == nil{//先判断response返回有没有error
                if let data = response.data{
                    do{
                        let jsonData: JSON = try JSON(data: data)
                        let response : Models_ShouLi.Response = Models_ShouLi.Response(jsonData: jsonData)
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
