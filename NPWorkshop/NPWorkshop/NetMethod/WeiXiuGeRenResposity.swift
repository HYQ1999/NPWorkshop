//
//  WeiXiuGeRenResposity.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/20.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class WeiXiuGeRenResposity: NSObject {

    func UserDetail(handler:  @escaping(_ response: Models_WeiXiuGeRenDetail.Response?, _ error: String?) -> Void)
    {
        weixiuuserModel.loadData()
        let parameters :[String : Any] = [
            "UserID" : weixiuuserModel.userlist[0].userid
        ]
        
        
        Alamofire.request("http://172.16.101.66:8083/api/RepAPI/Info_Personal", method: .post, parameters:parameters,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            if response.error == nil{//先判断response返回有没有error
                if let data = response.data{
                    do{
                        let jsonData: JSON = try JSON(data: data)
                        let response : Models_WeiXiuGeRenDetail.Response = Models_WeiXiuGeRenDetail.Response(jsonData: jsonData)
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
