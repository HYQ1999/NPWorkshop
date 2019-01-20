//
//  Models_MiMaEdit.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/20.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Models_MiMaEdit: NSObject {

    
    class Requesting: NSObject {
        var UserID:String
        var NewPassWord:String
        init(UserID:String,NewPassWord:String) {
            self.UserID = UserID
            self.NewPassWord = NewPassWord
        }
    }
    
    class Response: NSObject {
        var ts:String?
        
        init(jsonData: JSON?){
            if let jsonData = jsonData{
                self.ts = jsonData["ts"].stringValue
            }
            print("ts: ", self.ts ?? "没有值")
        }
    }
    
}
