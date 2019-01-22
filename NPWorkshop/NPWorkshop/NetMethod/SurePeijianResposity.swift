//
//  SurePeijianResposity.swift
//  NPWorkshop
//
//  Created by 欧张帆 on 2019/1/22.
//  Copyright © 2019 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SurePeijianResposity: NSObject {
    
    func SurePeijian(requesting: Models_SurePeijian.Requesting, handler:  @escaping(_ response: Models_SurePeijian.Response?, _ error: String?) -> Void)
    {
        let parameters :[String : Any] = [
            "ApplyID":requesting.RepairID
 
        ]
        
        Alamofire.request("http://172.16.101.66:8083/api/RepAPI/qrdh", method: .post, parameters:parameters,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if response.error == nil{//先判断response返回有没有error
                if let data = response.data{
                    do{
                        let jsonData: JSON = try JSON(data: data)
                        for i in jsonData
                        {
                            print(i)
                        }
                        let response : Models_SurePeijian.Response = Models_SurePeijian.Response(jsonData: jsonData)
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
