//
//  Model.swift
//  DXStore
//
//  Created by 吕书涛 on 2018/8/23.
//  Copyright © 2018年 吕书涛. All rights reserved.
//

import UIKit
import SwiftyJSON

//model
class SimpModel: NSObject {
    var imgUrl: String?
    var id: String?
    init(jsonData: JSON) {
        imgUrl    = jsonData["imgUrl"].stringValue
        id = jsonData["id"].stringValue
    }
}






