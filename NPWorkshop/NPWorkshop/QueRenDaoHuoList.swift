//
//  QueRenDaoHuoList.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/22.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class QueRenDaoHuoList: NSObject,NSCoding {

    var peijianshenbaoid:String
    var peijianleibie:String
    var peijianmingchen:String
    var peijianshenbaoren:String
    var shenbaoshuliang:String
    var shenbaozhuangtai:String
    var shenbaoshijian:String
    var RepairID:String
    var PartsID:String
    required init(peijianshenbaoid:String = "", peijianleibie:String = "", peijianmingchen: String = "", peijianshenbaoren: String = "", shenbaoshuliang: String = "", shenbaozhuangtai: String = "", shenbaoshijian: String = "", RepairID: String = "", PartsID: String = ""){
        self.peijianshenbaoid = peijianshenbaoid
        self.peijianleibie = peijianleibie
        self.peijianmingchen = peijianmingchen
        self.peijianshenbaoren = peijianshenbaoren
        self.shenbaoshuliang = shenbaoshuliang
        self.shenbaozhuangtai = shenbaozhuangtai
        self.shenbaoshijian = shenbaoshijian
        self.RepairID = RepairID
        self.PartsID = PartsID
        // super.init()
    }
    
    //从nsobject解析回来
    required init(coder decoder:NSCoder){
        self.peijianshenbaoid = decoder.decodeObject(forKey: "peijianshenbaoid") as! String
        self.peijianleibie = decoder.decodeObject(forKey: "peijianleibie") as! String
        self.peijianmingchen = decoder.decodeObject(forKey: "peijianmingchen")as! String
        self.peijianshenbaoren = decoder.decodeObject(forKey: "peijianshenbaoren")as! String
        self.shenbaoshuliang = decoder.decodeObject(forKey: "shenbaoshuliang") as! String
        self.shenbaozhuangtai = decoder.decodeObject(forKey: "shenbaozhuangtai")as! String
        self.shenbaoshijian = decoder.decodeObject(forKey: "shenbaoshijian")as! String
        self.RepairID = decoder.decodeObject(forKey: "RepairID")as! String
        self.PartsID = decoder.decodeObject(forKey: "PartsID")as! String
    }
    
    //编码成object
    func encode(with coder : NSCoder){
        coder.encode(peijianshenbaoid,forKey:"peijianshenbaoid")
        coder.encode(peijianleibie,forKey:"peijianleibie")
        coder.encode(peijianmingchen, forKey: "peijianmingchen")
        coder.encode(peijianshenbaoren, forKey: "peijianshenbaoren")
        coder.encode(shenbaoshuliang,forKey:"shenbaoshuliang")
        coder.encode(shenbaozhuangtai, forKey: "shenbaozhuangtai")
        coder.encode(shenbaoshijian, forKey: "shenbaoshijian")
        coder.encode(RepairID, forKey: "RepairID")
        coder.encode(RepairID, forKey: "PartsID")
    }
    
}
