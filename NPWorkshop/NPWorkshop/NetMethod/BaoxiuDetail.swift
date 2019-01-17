//
//  BaoxiuDetail.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/16.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
class BaoxiuDetail: NSObject {
    var baoxiulist = BaoxiuModel()
    
func Baoxiudetail()
{
    baoxiulist.loadData()
    let parameters :[String : Any] = [
        "RepairID": "20190116151028083"//左边是接口
    ]
    
    
    Alamofire.request("http://172.16.101.66:8083/api/RepAPI/RepDetail", method: .post, parameters:parameters,encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if response.result.value != nil {
                do{
                    //当收到JSON相应时
                    //                print(response.request as Any)
                    //                print(response.result.value as Any)
                    let json = try! JSON(data: response.data!) //JSON解析
                    for i in json
                    {
                        print(i)
                    }
                    
                    
                }
                catch{}
            }
        
    }
    
    
    }
}
