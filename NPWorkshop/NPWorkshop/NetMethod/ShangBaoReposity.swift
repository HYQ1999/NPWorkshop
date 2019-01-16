//
//  ShangBaoReposity.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/16.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ShangBaoReposity: NSObject {
    
    
func ShangBao(requesting: Models_ShangBao.Requesting, handler:  @escaping(_ response: Models_ShangBao.Response?, _ error: String?) -> Void)
{
    let parameters :[String : Any] = [
        "UserID": requesting.UserID,//左边是接口
        "EqptName": requesting.EqptName,
        "AssetsNumber":requesting.AssetsNumber,
        "Appearance":requesting.Appearance
    ]
    
     Alamofire.request("http://172.16.101.66:8083/api/RepAPI/RepAdd", method: .post, parameters:parameters,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
        if response.error == nil{//先判断response返回有没有error
            if let data = response.data{
                do{
                    let jsonData: JSON = try JSON(data: data)
                    
                    for i in jsonData
                    {
                        print(i)
                    }
                    let response : Models_ShangBao.Response = Models_ShangBao.Response(jsonData: jsonData)
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
