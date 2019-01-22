//
//  Models_PeiJianShenGouQueRen.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/22.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class Models_PeiJianShenGouQueRen: NSObject {

    
    class Response: NSObject {
        var peijianshenbaoid:String?
        var peijianleibie:String?
        var peijianmingchen:String?
        var peijianshenbaoren:String?
        var shenbaoshuliang:String?
        var shenbaozhuangtai:String?
        var shenbaoshijian:String?
          var RepairID:String?
         var PartsID:String?
        init(
            peijianshenbaoid: String?,
            peijianleibie: String?,
            peijianmingchen: String?,
            peijianshenbaoren: String?,
            shenbaoshuliang: String?,
            shenbaozhuangtai: String?,
            shenbaoshijian: String?,
            RepairID: String?,
            PartsID: String?
            ){
            self.peijianshenbaoid = peijianshenbaoid
            self.peijianleibie = peijianleibie
            self.peijianmingchen = peijianmingchen
            self.peijianshenbaoren = peijianshenbaoren
             self.shenbaoshuliang = peijianshenbaoren
             self.shenbaozhuangtai = shenbaozhuangtai
             self.shenbaoshijian = shenbaoshijian
            self.RepairID = RepairID
            self.PartsID = PartsID
            
        }
    }
    
}
