//
//  PeiJianList.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/17.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class PeiJianList: NSObject {
    var peijianminchen:String
    var peijiankucun:String
    var peijianleibie:String
    var peijiandanjia:String
    required init(peijianminchen:String = "", peijiankucun:String = "", peijianleibie: String = "", peijiandanjia: String = ""){
        self.peijianminchen = peijianminchen
        self.peijiankucun = peijiankucun
        self.peijianleibie = peijianleibie
          self.peijiandanjia = peijiandanjia
        // super.init()
    }
    
    //从nsobject解析回来
    required init(coder decoder:NSCoder){
        self.peijianminchen = decoder.decodeObject(forKey: "peijianminchen") as! String
        self.peijiankucun = decoder.decodeObject(forKey: "peijiankucun") as! String
        self.peijianleibie = decoder.decodeObject(forKey: "peijianleibie")as! String
        self.peijiandanjia = decoder.decodeObject(forKey: "peijiandanjia")as! String
    }
    
    //编码成object
    func encode(with coder : NSCoder){
        coder.encode(peijianminchen,forKey:"peijianminchen")
        coder.encode(peijiankucun,forKey:"peijiankucun")
        coder.encode(peijianleibie, forKey: "peijianleibie")
        coder.encode(peijiandanjia, forKey: "peijiandanjia")
    }
}
