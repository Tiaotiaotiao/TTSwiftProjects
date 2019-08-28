//
//  ViewController.swift
//  SwiftTimer
//
//  Created by Tiaotiao on 2019/7/25.
//  Copyright © 2019 Tiaotiao. All rights reserved.
//

import UIKit

let TTScreenRect : CGRect = UIScreen.main.bounds
let TTScreenWidth = UIScreen.main.bounds.width
let TTScreenHeight = UIScreen.main.bounds.height


class ViewController: UIViewController {
    var timer : Timer?
    var timerCount = 0
    
    
    // MARK: - life
    override func viewDidLoad() {
        super.viewDidLoad()
 
        initSubview()
  
    }
    
    func initSubview() {
        self.view.addSubview(showLbl)
        self.view.addSubview(beginBtn)
        self.view.addSubview(pauseBtn)
        
        [beginBtn, pauseBtn].forEach {
            ($0.addTarget(self, action: #selector(btnAction(sender:)), for: UIControl.Event.touchUpInside))
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
    // MARK: - Action

    @objc func btnAction(sender : UIButton) {
        //print("点击了 \(sender)")
        
        switch sender {
        case beginBtn:
            sender.isSelected = !sender.isSelected
            sender.isSelected ? beginAction() : endAction()
            print("点击了 \(sender)")
        case pauseBtn:
            if !beginBtn.isSelected {
                print("请先开始")
                return
            }
            
            sender.isSelected = !sender.isSelected
            sender.isSelected ? pauseAction() : continueAction()
        default:
            break
        }
    }
    
    func beginAction() {
        //print("11111111")
        //timer?.fire()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    func endAction() {
        //print("22222")
        showLbl.text = "0"
        timerCount = 0
        
        timer?.invalidate()
        timer = nil
    }
    
    func pauseAction() {
        //print("33333")
        timer?.invalidate()
        timer = nil
    }
    
    func continueAction() {
        //print("44444")
        beginAction()
    }
    
    @objc func timerAction() {
        timerCount += 1
        showLbl.text = String(timerCount)
    }
    
    // MARK: - lazy
    lazy var showLbl : UILabel = {
        let showLbl = UILabel(frame: CGRect(x: 0, y: 88, width: TTScreenWidth, height: 50))
        showLbl.textAlignment = NSTextAlignment.center
        showLbl.text = "0"
        showLbl.backgroundColor = UIColor.orange
        
        return showLbl
    }()

  
    lazy var beginBtn : UIButton = {
        let beginBtn = UIButton(frame: CGRect(x: 0, y: 200, width: TTScreenWidth * 0.5, height: 50))
        beginBtn.backgroundColor = UIColor.brown
        beginBtn.setTitle("开始", for: UIControl.State.normal)
        beginBtn.setTitle("结束", for: UIControl.State.selected)

        return beginBtn
    }()
    
    lazy var pauseBtn : UIButton = {
        let pauseBtn = UIButton(frame: CGRect(x: self.beginBtn.frame.origin.x + self.beginBtn.frame.size.width, y: 200, width: TTScreenWidth * 0.5, height: self.beginBtn.frame.size.height))
        pauseBtn.backgroundColor = UIColor.red
        pauseBtn.setTitle("暂停", for: UIControl.State.normal)
        pauseBtn.setTitle("继续", for: UIControl.State.selected)

        return pauseBtn
    }()
    
    lazy var timeLbl : UILabel = {
        let timeLbl = UILabel()
        //timeLbl.backgroundColor = UIColor.red
        timeLbl.text = "跳跳"
        timeLbl.frame = CGRect.init(x: 50, y: 50, width: 100, height: 100)
        
        return timeLbl
    }()

}

