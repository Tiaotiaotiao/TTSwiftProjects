//
//  ViewController.swift
//  TTSwiftCustomFont
//
//  Created by Tiaotiao on 2019/8/28.
//  Copyright © 2019 Tiaotiao. All rights reserved.
//

import UIKit

let TTScreenRect : CGRect = UIScreen.main.bounds
let TTScreenWidth = UIScreen.main.bounds.width
let TTScreenHeight = UIScreen.main.bounds.height

let fontCellIdentify = "fontCellIdentify"

class ViewController: UIViewController {
    
    let datasArr = ["点击一下改变字体🙄，","字体就会改变，","你相信不，","不相信么，","点一下试试吧😊！"]
    
    // PingFangSC-Medium
    let fontNameArr = ["MFTongXin_Noncommercial-Regular", "MFJinHei_Noncommercial-Regular", "PingFangSC-Regular", "Heiti SC", "SimplonBP-Medium"]
 
    
    //MARK: - Life (deinit init viewDidLoad memoryWarning...)

    deinit {
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubView();
        
    }
    
    func initSubView() {
        view.addSubview(tb)
        view.addSubview(changeBtn)
    }
    
    func initData() {
     
    }
    
    //MARK: - Public
    //MARK: - Event Respone
    
    @objc func changBtnClick(button : UIButton) {
        print("点击 了 改变字体")

        tb.reloadData()
    }
    
    //MARK: - Delegate
    
    //MARK: - Private
    
    
    //MARK: - Lazy
    lazy var tb : UITableView = {
        let fontTb = UITableView.init(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.size.height, width: TTScreenWidth , height: TTScreenHeight - 250), style: .grouped)
        fontTb.delegate = self;
        fontTb.dataSource = self;
        fontTb.backgroundColor = UIColor.white
        fontTb.rowHeight = 60.0
        //fontTb.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: fontCellIdentify)
        
        return fontTb;
    }()
    
    lazy var changeBtn : UIButton = {
        let changeBtn = UIButton.init(frame: CGRect(x: (TTScreenWidth - 100) * 0.5, y: TTScreenHeight - 50 - 50, width: 100 , height: 50))
        changeBtn.backgroundColor = UIColor.white
        changeBtn.setTitle("改变字体", for: .normal)
        changeBtn.setTitleColor(.black, for: .normal)
        changeBtn.addTarget(self, action: #selector(changBtnClick(button:)), for: .touchUpInside)
        changeBtn.layer.cornerRadius = 5.0
        changeBtn.layer.borderColor = UIColor.black.cgColor
        changeBtn.layer.borderWidth = 1.0
        
         return changeBtn;
    }()
    
    //MARK: - Supperclass
    
    //MARK: - NSObject
}


// MARK: - UITableViewDelegate

extension ViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 如果tb 注册了cell 用这个方法
        //let cell = tableView.dequeueReusableCell(withIdentifier: fontCellIdentify, for: indexPath)

        // tb 没有注册cell 的时候
        var cell = tableView.dequeueReusableCell(withIdentifier: fontCellIdentify);
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: fontCellIdentify)
        }
 
        if indexPath.row < datasArr.count {
            let randomIndex = Int(Int(arc4random()) % fontNameArr.count)
            let fontNameStr = fontNameArr[randomIndex]
            
            cell?.textLabel?.text = "\(datasArr[indexPath.row])"
            cell?.detailTextLabel?.text = "字体为：\(fontNameStr)"
            cell?.textLabel?.font = UIFont(name: fontNameStr, size: 17.0)
        }
        
        return cell!
    }
}

extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
