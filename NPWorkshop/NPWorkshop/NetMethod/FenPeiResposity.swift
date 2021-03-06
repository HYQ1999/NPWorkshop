//
//  FenPeiResposity.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/19.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class FenPeiResposity: NSObject {

    
    func FenPei(requesting: Models_FenPei.Requesting, handler:  @escaping(_ response: Models_FenPei.Response?, _ error: String?) -> Void)
    {
        let parameters :[String : Any] = [
            "repairaID": requesting.repairaID,//左边是接口
            "RepairUserID": requesting.RepairUserID
        ]
        
        Alamofire.request("http://172.16.101.66:8083/api/RepAPI/allot", method: .post, parameters:parameters,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if response.error == nil{//先判断response返回有没有error
                if let data = response.data{
                    do{
                        let jsonData: JSON = try JSON(data: data)
                        for i in jsonData
                        {
                            print(i)
                        }
                        let response : Models_FenPei.Response = Models_FenPei.Response(jsonData: jsonData)
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
