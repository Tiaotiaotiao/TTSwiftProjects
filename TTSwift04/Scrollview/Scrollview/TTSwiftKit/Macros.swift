//
//  Macros.swift
//  TTSwift03 - PlayLocalVideo
//
//  Created by Tiaotiao on 2019/11/10.
//  Copyright © 2019 Tiaotiao. All rights reserved.
//

import UIKit
import Foundation

let TTWIDTH: CGFloat = UIScreen.main.bounds.size.width
let TTHEIGHT: CGFloat = UIScreen.main.bounds.size.height

class Macros: NSObject {
    
    class func tt_rootWindow() -> UIWindow? {
        var window: UIWindow? = nil
        if #available(iOS 13.0, *) {
            // 取最后一个
            window = UIApplication.shared.windows.last;
            return window
        } else {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let mainWindow = appDelegate?.window
            return mainWindow
        }
    }
    
    class func tt_keyWindow() -> UIWindow? {
        var window: UIWindow? = nil
        
        if #available(iOS 13.0, *) {
            for windowScene: UIWindowScene in ((UIApplication.shared.connectedScenes as? Set<UIWindowScene>)!) {
                if windowScene.activationState == .foregroundActive {
                    window = windowScene.windows.last
                    break
                }
            }
            return window
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    class func tt_isPhoneX() -> Bool {
        guard #available(iOS 11.0, *) else {
            return false
        }
        
        let mainWindow = self.tt_rootWindow()
        guard mainWindow?.safeAreaInsets.top ?? 0.0 > 0.0 else {
            return false
        }
        
        return true
    }
    
    class func tt_naviStatusHeight() -> CGFloat {
        let isPhoneX: Bool = self.tt_isPhoneX()
        
        guard isPhoneX else {
            return 44.0
        }
        
        return 20.0
    }

    class func tt_naviHeight() -> CGFloat {
        let isPhoneX: Bool = self.tt_isPhoneX()
        
        guard isPhoneX else {
            return 44.0
        }
        
        return 88.0
    }
    
    class func tt_safeBottom() -> CGFloat {
        guard #available(iOS 11.0, *) else {
            return 0.0
        }

        let mainWindow = self.tt_rootWindow()
        
        return mainWindow?.safeAreaInsets.bottom ?? 0.0
    }
    
    class func tt_safeHeight() -> CGFloat {
        let resultH = TTHEIGHT - self.tt_naviStatusHeight() - self.tt_safeBottom()
        return resultH
    }
    
    class func tt_safeContentHeight() -> CGFloat {
        let resultH = TTHEIGHT - self.tt_naviHeight() - self.tt_safeBottom()
        
        return resultH
    }
}

extension Macros {
    
}
