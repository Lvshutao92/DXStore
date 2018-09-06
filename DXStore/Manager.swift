//
//  Manager.swift
//  DXStore
//
//  Created by 吕书涛 on 2018/8/23.
//  Copyright © 2018年 吕书涛. All rights reserved.
//

import UIKit

class Manager: NSObject {
    //单利
    static let instance: Manager = Manager()
    class func sharedInstance() -> Manager {
        return instance
    }
    //width
    class func returnWidth(controller:UIViewController) -> Float {
        return Float(controller.view.frame.size.width)
    }
    //height
    class func returnHeight(controller:UIViewController) -> Float {
        return Float(controller.view.frame.size.height)
    }
    //存储信息
    class func cunchu(str:String,name:String) -> String {
      
        return String()
    }
    //取出信息
    class func quchu(str:String,name:String) -> String {
        
        return String()
    }
}








class COVCController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //width
    func returnWidth() -> Float {
        return  Float(self.view.frame.size.width)
    }
    //height
    func returnHeight() -> Float {
        return Float(self.view.frame.size.height)
    }
    
    
}



