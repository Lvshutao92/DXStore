//
//  PersonViewController.swift
//  DXStore
//
//  Created by 吕书涛 on 2018/8/23.
//  Copyright © 2018年 吕书涛. All rights reserved.
//

import UIKit
import MBProgressHUD
/**
 个人中心
 */
class PersonViewController: UIViewController,UITextFieldDelegate {
    var isnoLogin:Bool = false
    
    var headerView = UIView()
    
    var window = UIWindow()
    var window1 = UIWindow()
    var loginView = UIView()
    var registerView = UIView()
    var cancelbtn = UIButton()
    var cancelbtn1 = UIButton()
    
    var phoneLoginTextField = UITextField()
    var passwordLoginTextField = UITextField()
    
    
    
    var tableview = UITableView()
    
    var userImgView  = UIImageView()
    var userNameLabel = UILabel()
    var userLoginBtn = UIButton()
    var userRegisterBtn = UIButton()
    
    lazy var titleArry: NSMutableArray = {
        var temporaryPlayers = NSMutableArray()
        return temporaryPlayers
    }()
    lazy var imgArry: NSMutableArray = {
        var temporaryPlayers = NSMutableArray()
        return temporaryPlayers
    }()
    @objc func noHiddenLoginView(){
        UIView.animate(withDuration: 0.5) {
            self.window.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }
    }
    @objc func noHiddenRegisterView(){
        UIView.animate(withDuration: 0.5) {
            self.window1.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }
    }
    func setupUserView() {
        userImgView.frame = CGRect(x: self.view.frame.size.width/2-45, y: 20, width: 90, height: 90)
        userImgView.image = UIImage(named: "person")
        userImgView.layer.cornerRadius = 45
        headerView.addSubview(userImgView)
        
        userLoginBtn.frame = CGRect(x: self.view.frame.size.width/2-55, y: 125, width: 50, height: 40)
        userLoginBtn.setTitle("登录", for: .normal)
        userLoginBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        userLoginBtn.addTarget(self, action: #selector(noHiddenLoginView), for: .touchUpInside)
        headerView.addSubview(userLoginBtn)
        
        let shu = UIView(frame: CGRect(x: self.view.frame.size.width/2-0.5, y: 135, width: 1, height: 20))
        shu.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        headerView.addSubview(shu)
        
        userRegisterBtn.frame = CGRect(x: self.view.frame.size.width/2+5, y: 125, width: 50, height: 40)
        userRegisterBtn.setTitle("注册", for: .normal)
        userRegisterBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        userRegisterBtn.addTarget(self, action: #selector(noHiddenRegisterView), for: .touchUpInside)
        headerView.addSubview(userRegisterBtn)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        titleArry = ["我的订单","我的优惠券","领券中心","我的收藏","QQ客服","联系我们","关于我们"]
        imgArry = ["a1","a2","a3","a4","a5","a6","a7"]
        
        tableview = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(PersonCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.view.addSubview(tableview)
        
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200)
        headerView.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        tableview.tableHeaderView = headerView
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 1))
        tableview.tableFooterView = footerView
        
        
        let vbar = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn.setImage(UIImage(named: "set"), for: .normal)
        btn.addTarget(self, action: #selector(slipSetController), for: .touchUpInside)
        vbar.addSubview(btn)
        let bar = UIBarButtonItem(customView: vbar)
        self.navigationItem.rightBarButtonItem = bar
        
        setupUserView()
        
        setupWindowview()
        setupLoginview()
        setupRegisterview()
        
        
    }
    @objc func slipSetController() {
        let set = SetViewController()
        set.navigationItem.title = "设置"
        self.navigationController?.pushViewController(set, animated: true)
    }
    func setupWindowview() {
        window.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height)
        window.windowLevel = UIWindowLevelNormal
        window.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        window.makeKeyAndVisible()
        
        window1.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height)
        window1.windowLevel = UIWindowLevelNormal
        window1.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        window1.makeKeyAndVisible()
    }
    func setupLoginview() {
        loginView.frame = CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: self.view.frame.size.height)
        loginView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        loginView.layer.cornerRadius = 10
        window.addSubview(loginView)
        
        let lab = UILabel(frame: CGRect(x: self.view.frame.size.width/2-50, y: 10, width: 100, height: 30))
        lab.text = "账号登录"
        lab.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lab.font = UIFont.systemFont(ofSize: 20)
        loginView.addSubview(lab)
        
        cancelbtn.frame = CGRect(x: self.view.frame.size.width-40, y: 10, width: 30, height: 30)
        cancelbtn.setImage(UIImage(named: "cancel"), for: .normal)
        cancelbtn.addTarget(self, action: #selector(cancelLoginview), for: .touchUpInside)
        loginView.addSubview(cancelbtn)
        
        let loginbtn = UIButton(type: .custom)
        loginbtn.frame = CGRect(x: 20, y: 310, width: self.view.frame.size.width-40, height: 50)
        loginbtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        loginbtn.setTitleColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), for: .normal)
        loginbtn.setTitle("登录", for: .normal)
        loginbtn.layer.cornerRadius = 8
        loginView.addSubview(loginbtn)
        
        phoneLoginTextField.frame = CGRect(x: 20, y: 150, width: self.view.frame.size.width-40, height: 50)
        phoneLoginTextField.delegate = self
        phoneLoginTextField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        phoneLoginTextField.placeholder = "请输入手机号码"
        phoneLoginTextField.borderStyle = UITextBorderStyle.roundedRect
        loginView.addSubview(phoneLoginTextField)
        
        passwordLoginTextField.frame = CGRect(x: 20, y: 220, width: self.view.frame.size.width-40, height: 50)
        passwordLoginTextField.delegate = self
        passwordLoginTextField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        passwordLoginTextField.placeholder = "请输入密码"
        passwordLoginTextField.borderStyle = UITextBorderStyle.roundedRect
        loginView.addSubview(passwordLoginTextField)
    }
    func setupRegisterview() {
        registerView.frame = CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: self.view.frame.size.height)
        registerView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        registerView.layer.cornerRadius = 10
        window1.addSubview(registerView)
        
        let lab = UILabel(frame: CGRect(x: self.view.frame.size.width/2-50, y: 10, width: 100, height: 30))
        lab.text = "账号注册"
        lab.font = UIFont.systemFont(ofSize: 20)
        lab.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        registerView.addSubview(lab)
        
        cancelbtn1.frame = CGRect(x: self.view.frame.size.width-40, y: 10, width: 30, height: 30)
        cancelbtn1.setImage(UIImage(named: "cancel"), for: .normal)
        cancelbtn1.addTarget(self, action: #selector(cancelLoginview1), for: .touchUpInside)
        registerView.addSubview(cancelbtn1)
    }
    @objc func cancelLoginview() {
        UIView.animate(withDuration: 0.5) {
            self.window.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }
    }
    @objc func cancelLoginview1() {
        UIView.animate(withDuration: 0.5) {
            self.window1.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }
    }
    
    func zanweikaifang() {
        let mb = MBProgressHUD(view: self.view)
        mb.label.text = "等待更新"
        self.view.addSubview(mb)
        mb.removeFromSuperViewOnHide = true
        mb.mode = .customView
        mb.show(animated: true)
        mb.hide(animated: true, afterDelay: 1)
    }
   
}




/**
 UITableViewDelegate
 */
extension PersonViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let order = OrderViewController()
            order.navigationItem.title = "订单"
            self.navigationController?.pushViewController(order, animated: true)
            break
        case 1:
            zanweikaifang()
            break
        case 2:
            zanweikaifang()
            break
        case 3:
            zanweikaifang()
            break
        case 4:
            let qqstr = "mqq://im/chat?chat_type=wpa&uin=\(309718069)&version=1&src_type=web"
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(NSURL(string: qqstr)! as URL, options: ["" : ""]) { (res) in
                    print(res)
                }
            } else {
                // Fallback on earlier versions
            }
            break
        case 5:
            let phone = "tel:\(13270109384)";
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(NSURL(string: phone)! as URL, options: ["" : ""]) { (res) in
                    print(res)
                }
            } else {
                // Fallback on earlier versions
            }
            break
        case 6:
            let aboutour = AboutOurViewController()
            aboutour.navigationItem.title = "关于我们"
            self.navigationController?.pushViewController(aboutour, animated: true)
            break
        default:
            break
        }
    }
}
/**
 UITableViewDataSource
 */
extension PersonViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PersonCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PersonCell
        
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.titLabel?.text = titleArry[indexPath.row] as? String
        let imgStr = imgArry[indexPath.row]
        print(imgStr)
        cell.imgView?.image = UIImage(named: imgStr as! String)
        return cell
    }
}




class PersonCell: UITableViewCell {
    var imgView:UIImageView?
    var titLabel: UILabel?
    var imgViewJiantou:UIImageView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        lauoutUI()
    }
    
    func lauoutUI()  {
        let covc = COVCController()
        imgView = UIImageView(frame:CGRect(x:7.5,y:12.5,width:25,height:25))
        self.addSubview(imgView!)
        
        titLabel = UILabel(frame:CGRect(x:40,y:10,width:Int(covc.returnWidth() - 80),height:30))
        self.addSubview(titLabel!)
    }
}









