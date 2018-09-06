//
//  NavController.swift
//  DXStore
//
//  Created by 吕书涛 on 2018/8/23.
//  Copyright © 2018年 吕书涛. All rights reserved.
//

import UIKit

class NavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.isNavigationBarHidden = false //上部的导航栏
        self.isToolbarHidden = true //底部的状态栏
        
       self.navigationBar.tintColor = UIColor.black
       
        //设置导航栏背景颜色
        self.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let dict:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.black,NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)]
        //标题颜色
        self.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey : AnyObject]
        
       
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
//    [self.navigationBar setTintColor:[UIColor blackColor]];
//    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        //更改选中的图片颜色
        let tintImage1 =  UIImage.init(named: "01")
        let newImage01 = tintImage1?.imageWithTintColor(color: UIColor.red)
        
        let tintImage2 =  UIImage.init(named: "02")
        let newImage02 = tintImage2?.imageWithTintColor(color: UIColor.red)
        
        let tintImage3 =  UIImage.init(named: "03")
        let newImage03 = tintImage3?.imageWithTintColor(color: UIColor.red)
        
        let tintImage4 =  UIImage.init(named: "04")
        let newImage04 = tintImage4?.imageWithTintColor(color: UIColor.red)
        
        
        //首页
        let homeVC = HomeViewController()
        self.addChildViewController(childerVC: homeVC, title: "首页", normalImg: "1", selectedImg: newImage01!)
        
        //产品
        let treasureBoxVC = ShoppingViewController()
        self.addChildViewController(childerVC: treasureBoxVC, title: "产品", normalImg: "2", selectedImg: newImage02!)

        //购物车
        let myShowVC = ShoppingCartViewController()
        self.addChildViewController(childerVC: myShowVC, title: "购物车", normalImg: "3", selectedImg: newImage03!)

        //个人中心
        let memberCenterVc = PersonViewController()
        self.addChildViewController(childerVC: memberCenterVc, title: "个人中心", normalImg: "4", selectedImg: newImage04!)
        
        self.selectedIndex = 0
    }
    
    //添加子控制器
    func addChildViewController(childerVC:UIViewController,title:NSString,normalImg:NSString,selectedImg:UIImage)  {
        
        self.tabBarItem.title = title as String
        let color = UIColor.red
        self.tabBar.tintColor = color
        
        childerVC.title = title as String
        
        var norImg = UIImage(named:normalImg as String)
        norImg = norImg?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        
        var selImg = selectedImg
        selImg = selImg.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        
        let tabItem = UITabBarItem(title: title as String, image: norImg,selectedImage: selImg)
        
        let naVc = NavController()
        
        naVc.tabBarItem = tabItem
        
        naVc.addChildViewController(childerVC)
        
        self.addChildViewController(naVc)
        
    }
    
}



extension UIImage{
    /// 更改图片颜色
    public func imageWithTintColor(color : UIColor) -> UIImage{
        UIGraphicsBeginImageContext(self.size)
        color.setFill()
        let bounds = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
}




