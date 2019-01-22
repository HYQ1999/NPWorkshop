//
//  ShenGouPeiJianResposity.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/22.
//  Copyright © 2019年 韩意谦. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON

class ShenGouPeiJianResposity: NSObject {

    func ShenGouPeiJian(requesting: Models_ShenGouPeiJian.Requesting, handler:  @escaping(_ response: Models_ShenGouPeiJian.Response?, _ error: String?) -> Void)
    {
        let parameters :[String : Any] = [
            "PartsAmount": requesting.PartsAmount,
            "PartsID": requesting.PartsID,
            "ReplyUser": requesting.ReplyUser,
            "ApplyUser": requesting.ApplyUser
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
                        let response : Models_ShenGouPeiJian.Response = Models_ShenGouPeiJian.Response(jsonData: jsonData)
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
