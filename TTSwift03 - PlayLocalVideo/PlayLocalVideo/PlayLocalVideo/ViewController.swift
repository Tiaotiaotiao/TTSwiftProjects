//
//  ViewController.swift
//  PlayLocalVideo
//
//  Created by Tiaotiao on 2019/11/11.
//  Copyright © 2019 Tiaotiao. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

let VideoCellIdentity = "VideoCell"


class ViewController: UIViewController {
    var avPlayerVC: AVPlayerViewController?
    var avPlayer: AVPlayer?
    
    // MARK: - Lifecycle (deinit init viewDidLoad memoryWarning...)
    
    deinit {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.initBase()
        self.initSubView()
    }
    
    func initBase() {
        //self.view.backgroundColor = .gray;

    }
    
    func initSubView() {
        self.view.addSubview(videoTb)
    
        avPlayerVC = AVPlayerViewController()
        avPlayer = AVPlayer()
    }
    
    // MARK: - Public
    
    // MARK: - Event Respone
    
    func showAvPlayerVC() {
        let path = Bundle.main.path(forResource: "Jay Chou 周杰倫【不能說的祕密 Secret】-Official Music Video", ofType: "mp4")
        avPlayer = AVPlayer(url: URL(fileURLWithPath: path!))
        avPlayerVC!.player = avPlayer

        self.present(avPlayerVC!, animated: true) {
            self.avPlayerVC!.player?.play()
        }
    }
    
    // MARK: - Delegate
    
    // MARK: - Private

    // MARK: - Lazy
    
    lazy var videoTb: UITableView = {
        let videoTb = UITableView.init(frame: CGRect(x: 0, y: 88, width: CPTWIDTH - 0, height: CPTHEIGHT - 88), style: .plain)
        videoTb.dataSource = self
        videoTb.delegate = self
        videoTb.backgroundColor = .gray
        videoTb.register(VideoCell.classForCoder(), forCellReuseIdentifier: VideoCellIdentity)
        
        return videoTb;
    }()

    lazy var dataArray: [Video] = {
        var dataArray = Array<Video>.init()
        
        for i in 1...6 {
            let video = Video(shotImgName: String(format: "videoScreenshot%02d", i), title: "测试标题\(i)", source: "测试来源\(i)")
            dataArray.append(video)
        }
        
        return dataArray
    }()

    
    // MARK: - Supperclass
    
    // MARK: - NSObject
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return VideoCellH
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
        
        cell.playClickBlock = { (button) in
            print("点击了播放")
            self.showAvPlayerVC()
        }
        
        if indexPath.row < dataArray.count {
            cell.updateData(video: dataArray[indexPath.row])
        }
        
        return cell;
    }
    
}


