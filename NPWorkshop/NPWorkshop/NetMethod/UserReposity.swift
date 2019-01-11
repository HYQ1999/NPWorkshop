//
//  UserReposity.swift
//  NPWorkshop
//
//  Created by 韩意谦 on 2019/1/11.
//  Copyright © 2019 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class UserReposity: NSObject {
    func user_login(requesting: Models_Login.Requesting, handler:  @escaping(_ response: Models_Login.Response?, _ error: String?) -> Void){
        
        let parameters :[String : Any] = [
            "UserName": requesting.UserName ,//左边是接口
            "Password" : requesting.Password
        ]
        
        Alamofire.request("http://172.16.101.66:8083/api/RepAPI/Login", method: .post, parameters: parameters).responseJSON { response in
            
            if response.error == nil{//先判断response返回有没有error
                if let data = response.data{
                    do{
                        let jsonData: JSON = try JSON(data: data)
                        let response : Models_Login.Response = Models_Login.Response(jsonData: jsonData)
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
