//
//  ShoppingViewController.swift
//  DXStore
//
//  Created by 吕书涛 on 2018/8/23.
//  Copyright © 2018年 吕书涛. All rights reserved.
//

import UIKit
import MJRefresh //刷新
import SwiftyJSON
import Kingfisher
/**
 产品
 */
class ShoppingViewController: UIViewController {

    lazy var dataArry: NSMutableArray = {
        var temporaryPlayers = NSMutableArray()
        return temporaryPlayers
    }()
    
    var tableview = UITableView()
    
    var total = 0
    
    
    var brand = ""
    var catalog = ""
    var series = ""
    var type = ""
    var price = ""
    var keyWord = ""
    var startRow = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableview = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(ShoppingCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.view.addSubview(tableview)
        
        setUpRefresh()
    }

}


extension ShoppingViewController{
    
    func setUpRefresh() {
        weak var weakSelf = self
        self.tableview.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            weakSelf?.lodA()
        })
        self.tableview.mj_header.beginRefreshing()
        self.tableview.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            if weakSelf?.total == weakSelf?.dataArry.count {
                weakSelf?.tableview.mj_footer.endRefreshingWithNoMoreData()
            }else{
                weakSelf?.lodB()
            }
        })
    }
    
   private func lodA() {
        weak var weakSelf = self
        self.tableview.mj_footer.endRefreshing()
        startRow = 0
        let shopGStr1 = "product/search?keyWord=\(keyWord)&startRow=\(startRow)&pageSize=10&brand=\(brand)&catalog=\(catalog)&series=\(series)&type=\(type)&price=\(price)"
        
        NetworkRequest.sharedInstance.getRequest(urlString: NetworkRequest.sharedInstance.URLNSString(string: shopGStr1), params: ["":""], success: { (response) in
            let jsonData = JSON(response)
            let model = ShoppingModel(jsonData: jsonData)
            weakSelf?.total = Int(model.total!)!
            let itemsList = model.itemsList
            if itemsList.count <= 0 {
                return
            }
            //print(itemsList)
            weakSelf?.dataArry.removeAllObjects()
            for dic in itemsList {
                let jsonData = JSON(dic)
                let model = ShoppingModel_A.init(jsonData: jsonData)
                weakSelf?.dataArry.add(model)
            }
            weakSelf?.startRow = 10
            weakSelf?.tableview.reloadData()
            weakSelf?.tableview.mj_header.endRefreshing()
        }, failture: { (error) in
            print(error)
            weakSelf?.tableview.mj_header.endRefreshing()
        })
        
        
    }
    private func lodB() {
        weak var weakSelf = self
        self.tableview.mj_header.endRefreshing()
       
        let shopGStr1 = "product/search?keyWord=\(keyWord)&startRow=\(startRow)&pageSize=10&brand=\(brand)&catalog=\(catalog)&series=\(series)&type=\(type)&price=\(price)"
        
        NetworkRequest.sharedInstance.getRequest(urlString: NetworkRequest.sharedInstance.URLNSString(string: shopGStr1), params: ["":""], success: { (response) in
            let jsonData = JSON(response)
            let model = ShoppingModel(jsonData: jsonData)
            let itemsList = model.itemsList
            //print(itemsList)
            //weakSelf?.dataArry.removeAllObjects()
            for dic in itemsList {
                let jsonData = JSON(dic)
                let model = ShoppingModel_A.init(jsonData: jsonData)
                weakSelf?.dataArry.add(model)
            }
            weakSelf?.startRow += 10
            weakSelf?.tableview.reloadData()
            weakSelf?.tableview.mj_footer.endRefreshing()
        }, failture: { (error) in
            print(error)
            weakSelf?.tableview.mj_footer.endRefreshing()
        })
    }
  
}


extension ShoppingViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}

extension ShoppingViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ShoppingCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShoppingCell
        let model = dataArry[indexPath.row] as! ShoppingModel_A
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.setValueForCell(model: model)
        return cell
    }
    
}



class ShoppingModel: NSObject {
    var total: String?
    var itemsList: Array<Any>
    
    init(jsonData: JSON) {
        total    = jsonData["total"].stringValue
        itemsList = jsonData["itemsList"].arrayValue
    }
}





class ShoppingModel_A: NSObject {
    var model_name: String?
    var series_name: String?
    var sale_price: String?
    var model_img: String?
    var promotionTitle: String?
    var id: String?
    
    init(jsonData: JSON) {
        model_name    = jsonData["model_name"].stringValue
        series_name = jsonData["series_name"].stringValue
        sale_price    = jsonData["sale_price"].stringValue
        model_img = jsonData["model_img"].stringValue
        promotionTitle    = jsonData["promotionTitle"].stringValue
        id = jsonData["id"].stringValue
    }
}

class ShoppingCell: UITableViewCell {
    var model_img:UIImageView?
    var model_name: UILabel?
    var series_name: UILabel?
    var sale_price: UILabel?
    var promotionTitle: UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.lauoutUI()
    }
    
    func lauoutUI()  {
        let covc = COVCController()
        
        model_img = UIImageView(frame:CGRect(x:10,y:5,width:100,height:100))
        self.addSubview(model_img!)
        
        model_name = UILabel(frame:CGRect(x:120,y:5,width:Int(covc.returnWidth() - 130),height:30))
        self.addSubview(model_name!)
        
        series_name = UILabel(frame:CGRect(x:120,y:35,width:Int(covc.returnWidth() - 130),height:30))
        series_name?.font = UIFont.systemFont(ofSize: 14)
        series_name?.textColor = UIColor.gray
        self.addSubview(series_name!)
        
        sale_price = UILabel(frame:CGRect(x:120,y:65,width:Int(covc.returnWidth() - 130),height:30))
        sale_price?.textColor = UIColor.red
        self.addSubview(sale_price!)
    }
    
    func setValueForCell(model:ShoppingModel_A){
        self.model_name?.text = model.model_name
        self.series_name?.text = model.series_name
        self.sale_price?.text = model.sale_price
        let url = URL(string: NetworkRequest.sharedInstance.IMGURLNSString(string: (model.model_img! as NSString) as String) as String)
        self.model_img?.kf.setImage(with:url)
    }
    
    
}










