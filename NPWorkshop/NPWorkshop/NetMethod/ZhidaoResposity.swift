//
//  ZhidaoResposity.swift
//  NPWorkshop
//
//  Created by 欧张帆 on 2019/1/17.
//  Copyright © 2019 韩意谦. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

var zhidaoModel = ZhidaoModel()


class ZhidaoResposity: NSObject {
    func Weixiulist()
    {
        zhidaoModel.loadData()
        var Response: [Models_ZhiDao.Response]? = [Models_ZhiDao.Response(RepairMan: nil, EqptName: nil, RepairState: nil)]
        
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
                            zhidaoModel.loadData()
                            zhidaoModel.zdlist.append(ZhidaoList(RepairMan: repvm[i]["RepairMan"] as! String, EqptName: repvm[i]["EqptName"] as! String, RepairState: repvm[i]["RepairState"] as! String))
                            zhidaoModel.saveData()
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
            NotificationCenter.default.post(name: Notification.Name(rawValue: "Models_ZhiDao"), object: Response)
        }
    }
    
}
