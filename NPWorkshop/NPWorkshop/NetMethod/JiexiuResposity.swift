//
//  JiexiuResposity.swift
//  NPWorkshop
//
//  Created by 欧张帆 on 2019/1/17.
//  Copyright © 2019 韩意谦. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

var jiexiuModel = JiexiuModel()


class JiexiuResposity: NSObject {
    func Zhidaolist()
    {
        jiexiuModel.loadData()
        var Response: [Models_JieXiu.Response]? = [Models_JieXiu.Response(RepairMan: nil, EqptName: nil, RepairState: nil)]
        
        Response?.removeAll()
        //        let parameters :[String : Any] = [
        ////            "RepairMan": jiexiuModel.jxlist[0].RepairMan //左边是接口
        //            :]//???????
        Alamofire.request("http://172.16.101.66:8083/api/RepAPI/RepairList", method: .post, parameters: nil,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            if response.result.value != nil {
                do{
                    if let json = try? JSONSerialization.jsonObject(with: response.data! as Data, options: .allowFragments) as? [String:AnyObject],
                        let repvm = json?["repvm"] as?[[String: AnyObject]]{
                        count = repvm.count
                        print(count)
                        for i in 0..<count-1 {
                            print(repvm[i]["RepairMan"] as! String)
                            jiexiuModel.loadData()
                            jiexiuModel.jxlist.append(JiexiuList(RepairMan: repvm[i]["RepairMan"] as! String, EqptName: repvm[i]["EqptName"] as! String, RepairState: repvm[i]["RepairState"] as! String))
                            jiexiuModel.saveData()
                            //                                        print(i)
                        }
                        
                    }
                }
                catch{}
            }
            else
            {
                //                response = nil
            }
            NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_JieXiu"), object: Response)
        }
    }
    
}
