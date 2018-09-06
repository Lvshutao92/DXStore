//
//  ViewController.swift
//  DXStore
//
//  Created by 吕书涛 on 2018/8/23.
//  Copyright © 2018年 吕书涛. All rights reserved.
//

import UIKit
import SwiftyJSON


/**
 首页
 */
class HomeViewController: UIViewController {
    
    lazy var dataArry: NSMutableArray = {
        var temporaryPlayers = NSMutableArray()
        return temporaryPlayers
    }()
    lazy var imgLunBoArry: NSMutableArray = {
        var temporaryPlayers = NSMutableArray()
        return temporaryPlayers
    }()
    
    var tableview = UITableView()
    let cycleView = ZCycleView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableview = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.view.addSubview(tableview)
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 1))
        tableview.tableFooterView = footerView
        
        
        /*
        cycleView.frame = CGRect(x: 0, y: 0, width: 375, height: Int(Manager.returnWidth(controller: self)*240/640))
        cycleView.delegate = self
        cycleView.itemSize = CGSize(width: self.view.frame.size.width-160, height: (self.view.frame.size.width-160)*300/750)
        cycleView.itemSpacing = 40
        cycleView.itemZoomScale = 1.2
        cycleView.itemBorderWidth = 1
        cycleView.itemBorderColor = UIColor.gray
        cycleView.pageControlIndictorImage = UIImage(named: "page1")
        cycleView.pageControlCurrentIndictorImage = UIImage(named: "page2")
        cycleView.pageControlHeight = 18
        cycleView.pageControlItemSize = CGSize(width: 16, height: 16)
        cycleView.pageControlAlignment = .center
        tableview.tableHeaderView = cycleView
        */
        
   
        cycleView.frame = CGRect(x: 0, y: 0, width: 375, height: Int(Manager.returnWidth(controller: self)*240/640))
        cycleView.placeholderImage = #imageLiteral(resourceName: "4")
        cycleView.delegate = self
        cycleView.pageControlItemSize = CGSize(width: 16, height: 4)
        cycleView.pageControlItemRadius = 0
        cycleView.pageControlAlignment = .right
        tableview.tableHeaderView = cycleView
        
        
        
        getTopInformation()
        
        
        let tool = ToolObj()
        print(tool.kNavigationbarHeight)
        
        
    }
    
    //顶部轮播
    func getTopInformation() {
        weak var weakSelf = self
        NetworkRequest.sharedInstance.getRequest(urlString: NetworkRequest.sharedInstance.URLNSString(string:"index/poster") as String, params: ["":""], success: { (response) in
            let dct = response as NSDictionary
            //let str = dct.object(forKey: "code")
            weakSelf?.dataArry.removeAllObjects()
            let arr = (dct["object"]! as! NSArray).mutableCopy() as! NSMutableArray
            for i in 0..<arr.count {
                let dic = arr[i] as! NSDictionary
                let jsonData = JSON(dic)
                let model = SimpModel.init(jsonData: jsonData)
                weakSelf?.dataArry.add(model)
            }
            
            
            weakSelf?.imgLunBoArry.removeAllObjects()
            for mo in (weakSelf?.dataArry)!{
                let mode = mo as! SimpModel
                weakSelf?.imgLunBoArry.add(NetworkRequest.sharedInstance.IMGURLNSString(string: mode.imgUrl!))
                print(NetworkRequest.sharedInstance.IMGURLNSString(string: mode.imgUrl!))
                self.cycleView.setUrlsGroup(weakSelf?.imgLunBoArry as! Array<String>)
            }
            
            weakSelf?.tableview.reloadData()
        }) { (error) in
            print(error)
        }
    }
}


extension HomeViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


extension HomeViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
}

extension HomeViewController:didselectedimgDelegate{
    func okAction(index: Int) {
        let imgStr = self.imgLunBoArry[index]
        print(imgStr)
    }
}



























