//
//  VideoCell.swift
//  TTSwift03 - PlayLocalVideo
//
//  Created by Tiaotiao on 2019/11/8.
//  Copyright © 2019 Tiaotiao. All rights reserved.
//

import UIKit

let VideoCellH: CGFloat = 220.0;

typealias PlayClickBlock = (_ button: AnyObject) ->Void

// 定义Video的结构体，属性初始化后不能被改变，因为结构体时值类型。
// 在你每次定义一个新类或者结构体的时候，实际上你是定义了一个新的 Swift 类型。
// 因此请使用UpperCamelCase这种方式来命名
struct Video {
    let shotImgName: String
    let title: String
    let source: String
}

class VideoCell: UITableViewCell {
    var videoScreenshotImgView: UIImageView?
    var videoTitleLbl: UILabel?
    var videoSourceLbl: UILabel?
    //var videoPlayBtn: UIButton?

    var playClickBlock: PlayClickBlock?
    
    
    // MARK: - Lifecycle (deinit init viewDidLoad memoryWarning...)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initSubView()
    }
    
    func initSubView() {
        videoScreenshotImgView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: CPTWIDTH, height: VideoCellH))
        
        videoTitleLbl = UILabel.init(frame: CGRect(x: 0, y: VideoCellH * 0.7, width: CPTWIDTH, height: 20.0))
        videoTitleLbl!.text = "--"
        videoTitleLbl!.textAlignment = .center
        videoTitleLbl?.textColor = .white
        videoTitleLbl?.font = UIFont.systemFont(ofSize: 15.0)

        videoSourceLbl = UILabel.init(frame: CGRect(x: 0.0, y: videoTitleLbl!.frame.origin.y + videoTitleLbl!.frame.size.height + 0, width: CPTWIDTH, height: 20.0))
        videoSourceLbl!.text = "--"
        videoSourceLbl!.textAlignment = .center
        videoSourceLbl?.textColor = .white
        videoSourceLbl?.font = UIFont.systemFont(ofSize: 12.0)
        
        self.addSubview(videoScreenshotImgView!)
        self.addSubview(videoTitleLbl!)
        self.addSubview(videoSourceLbl!)
        self.addSubview(videoPlayBtn)
    }
    
    // MARK: - Public
    
    func updateData(video: Video) {
        self.videoScreenshotImgView?.image = UIImage(named: video.shotImgName)
        self.videoTitleLbl?.text = video.title
        self.videoSourceLbl?.text = video.source
    }
    
    // MARK: - Event Respone
    @objc func videoPlayBtnClick(_ sendder: AnyObject) {
        if playClickBlock != nil {
            //print("点击了播放")
            playClickBlock!(sendder)
        }
    }
    
    // MARK: - Delegate
    
    // MARK: - Private
    
    // MARK: - Lazy
    
    lazy var videoPlayBtn: UIButton = {
        let w: CGFloat = 60.0;
        let videoPlayBtn = UIButton.init(type: .custom)
        videoPlayBtn.frame = CGRect(x: (CPTWIDTH - w) * 0.5, y: (VideoCellH - w) * 0.5, width: w, height: w)
        videoPlayBtn.setImage(UIImage(named: "playBtn"), for: .normal)
        videoPlayBtn.addTarget(self, action: #selector(videoPlayBtnClick(_:)), for: .touchUpInside)
        return videoPlayBtn;
    }()
    
    // MARK: - Supperclass
    
    // MARK: - NSObject
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
