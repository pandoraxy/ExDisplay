//
//  SecondScreenLauncher.swift
//  ExDisplay
//
//  Created by elsie on 16/4/28.
//  Copyright © 2016年 AppStudio. All rights reserved.
//

import Foundation
import UIKit

class SecondScreenLauncher {
    
    var secondWindow : UIWindow?
    
    
    func initSecondScreen() -> Bool {
        if UIScreen.screens().count > 1 {
            let secondScreen : UIScreen? = UIScreen.screens()[1]
            
            self.secondWindow = UIWindow(frame: secondScreen!.bounds)
            self.secondWindow!.backgroundColor = UIColor.whiteColor()
            self.secondWindow!.screen = secondScreen!
            self.secondWindow!.hidden = false
            
            let carViewController = LauncherViewController()
            let naviController = UINavigationController(rootViewController: carViewController)
//            naviController.navigationBarHidden = true;
            
            self.secondWindow?.rootViewController = naviController
            self.secondWindow?.makeKeyAndVisible()
            
            return true
        }
        return false
    }
    
    @objc func handleScreenDidConnectNotification(note:NSNotification) {
        let newScreen = note.object as! UIScreen
        
        if self.secondWindow == nil {
            self.secondWindow = UIWindow(frame: newScreen.bounds)
            self.secondWindow!.screen = newScreen;
            self.secondWindow!.backgroundColor = UIColor.whiteColor()
            self.secondWindow!.hidden = false
            
            let carViewController = LauncherViewController()
            let naviController = UINavigationController(rootViewController: carViewController)
            naviController.navigationBarHidden = true;
            
            self.secondWindow?.rootViewController = naviController
            self.secondWindow?.makeKeyAndVisible()
            
//            setupScreenConnectionNotificationHandlers()
        }
    }
    
    @objc func handleScreenDidDisconnectNotification(note:NSNotification){
        if (self.secondWindow != nil) {
            self.secondWindow!.hidden = true;
            self.secondWindow = nil;
        }
    }
    
}