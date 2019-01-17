//
//  StartReposity.swift
//  NPWorkshop
//
//  Created by 欧张帆 on 2019/1/17.
//  Copyright © 2019 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class StartReposity: NSObject {
    func Start(requesting: Models_Start.Requesting, handler:  @escaping(_ response: Models_Start.Response?, _ error: String?) -> Void)
    {
        let parameters :[String : Any] = [
            "RepairID": requesting.RepairID,//左边是接口
            "operation": requesting.operation,
            ]
        Alamofire.request("http://172.16.101.66:8083/api/RepAPI/Cancel_Rep", method: .post, parameters:parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            if response.error == nil{//先判断response返回有没有error
                if let data = response.data{
                    do{
                        let jsonData: JSON = try JSON(data: data)
                        let response : Models_Start.Response = Models_Start.Response(jsonData: jsonData)
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
