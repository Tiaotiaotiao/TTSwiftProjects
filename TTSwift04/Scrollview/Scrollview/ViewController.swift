//
//  ViewController.swift
//  Scrollview
//
//  Created by Tiaotiao on 2020/2/21.
//  Copyright © 2020 Tiaotiao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var bgScrollView: UIScrollView!
        
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
        bgScrollView.frame = self.view.bounds
        bgScrollView.showsVerticalScrollIndicator = false
        bgScrollView.showsHorizontalScrollIndicator = false
        bgScrollView.contentSize = CGSize.init(width: TTWIDTH * 3, height: 0)
        bgScrollView.addSubview(firstImgView)
        bgScrollView.addSubview(cameraVC.view)
        bgScrollView.addSubview(rightVC.view)
        
        bgScrollView.contentOffset = CGPoint(x: TTWIDTH, y: 0)
    }
    
    // MARK: - Public
    
    // MARK: - Event Respone
        
    // MARK: - Delegate
    
    // MARK: - Private
    
    // MARK: - Lazy

    lazy var firstImgView: UIImageView = {
        let firstView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: TTWIDTH - 0, height: TTHEIGHT))
        firstView.image = UIImage.init(named: "left_img")
       
        return firstView;
    }()
    
    lazy var cameraVC: CameraViewController = {
        let cameraVC = CameraViewController.init(nibName: "CameraViewController", bundle: nil)
        cameraVC.view.frame = CGRect(x: TTWIDTH, y: 0, width: TTWIDTH - 0, height: TTHEIGHT)
        
        return cameraVC
    }()

    lazy var rightVC: RightViewController = {
        let rightVC = RightViewController.init(nibName: "RightViewController", bundle: nil)
        rightVC.view.frame = CGRect(x: TTWIDTH * 2, y: 0, width: TTWIDTH - 0, height: TTHEIGHT)

        return rightVC
    }()
    
    // MARK: - Supperclass
    
    // MARK: - NSObject
}
