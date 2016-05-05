//
//  LauncherViewController.swift
//  ExDisplay
//
//  Created by elsie on 16/4/20.
//  Copyright © 2016年 AppStudio. All rights reserved.
//

import Foundation
import UIKit
import ExAuto

class LauncherViewController: UIViewController,ExDisplayControlProtocol {
    
    var secondScreenView : UIView?
    var defaultFocusView : UIView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        secondScreenView = self.view
        ExControlCenter.sharedInstance()!.displayControlDelegate = self
        ExControlCenter.sharedInstance()!.setFocusForView(defaultFocusView)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initView() {
        self.view = UIView(frame:CGRectZero)
        
        let backImg = UIImage(named: "homeLauncherBg")
        let backImgView = UIImageView(image: backImg)
        backImgView.frame = UIScreen.screens()[1].bounds
        self.view.addSubview(backImgView)
        
    }
    

    //MARK: - ExDisplayControlProtocol
    func confirm(){
        
        let curView : UIView? = ExControlCenter.sharedInstance()!.focusView
        let viewTag : Int = curView!.tag
        switch viewTag {
        case 0:
            break
            
        default:
            break
            
        }
    }
    func back(){
        
    }
    func voiceChange(voiceAmountScale:Float){
        
    }
    func showMenu(){
        
    }
    func hideMenu(){
        
    }
    func showSiri(){
        
    }
    func hideSiri(){
        
    }
}