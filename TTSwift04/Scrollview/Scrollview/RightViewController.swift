//
//  RightViewController.swift
//  Scrollview
//
//  Created by Tiaotiao on 2020/2/22.
//  Copyright © 2020 Tiaotiao. All rights reserved.
//

import UIKit

class RightViewController: UIViewController {
    @IBOutlet weak var bgImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bgImgView.image = UIImage.init(named: "right_img")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
