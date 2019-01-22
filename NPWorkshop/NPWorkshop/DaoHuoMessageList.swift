//
//  DaoHuoMessageList.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/22.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class DaoHuoMessageList: NSObject,NSCoding {
    var tongzhiren:String
    var shijian:String
    var message:String
    var repairid:String
    required init(tongzhiren:String = "", shijian:String = "", message: String = "", repairid: String = ""){
        self.tongzhiren = tongzhiren
        self.shijian = shijian
        self.message = message
        self.repairid = repairid
        // super.init()
    }
    
    //从nsobject解析回来
    required init(coder decoder:NSCoder){
        self.tongzhiren = decoder.decodeObject(forKey: "tongzhiren") as! String
        self.shijian = decoder.decodeObject(forKey: "shijian") as! String
        self.message = decoder.decodeObject(forKey: "message")as! String
        self.repairid = decoder.decodeObject(forKey: "repairid")as! String
    }
    
    //编码成object
    func encode(with coder : NSCoder){
        coder.encode(tongzhiren,forKey:"tongzhiren")
        coder.encode(shijian,forKey:"shijian")
        coder.encode(message, forKey: "message")
        coder.encode(repairid, forKey: "repairid")
    }
    
}
