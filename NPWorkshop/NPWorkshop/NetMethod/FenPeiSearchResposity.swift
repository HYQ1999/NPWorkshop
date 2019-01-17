//
//  FenPeiSearchResposity.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/17.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class FenPeiSearchResposity: NSObject {

    
    func Search()
    {
        
        var Response: [Models_FenPeiSearch.Response]? = [Models_FenPeiSearch.Response(UserID: nil, UserName: nil, QX:nil )]
        
        Response?.removeAll()
           Alamofire.request("http://172.16.101.66:8083/api/RepAPI/PostRepLists", method: .post, parameters:nil,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            if response.result.value != nil {
                do{
                   
                    
                }
                catch{}
            }
            else{
                Response = nil
            }
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_ZhiDaoSearch"), object: Response)
            
            
        }
        
        
        
    }
}
