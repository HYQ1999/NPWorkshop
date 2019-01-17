//
//  Models_FenPeiSearch.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/17.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Models_FenPeiSearch: NSObject {

    
    class Response: NSObject {
        var UserID:String?
        var UserName:String?
        var QX:String?
        
        init(
            UserID: String?,
            UserName: String?,
            QX: String?
            ){
            self.UserID = UserID
            self.UserName = UserName
            self.QX = QX
            
        }
    }
    
}
