//
//  ViewController.swift
//  PHStockChart
//
//  Created by Peter on 5/11/16.
//  Copyright © 2016 Peter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let button = UIButton()
    var gupiaoV:GuPiaoView?
    
    var isFullScreen = false

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        gupiaoV = GuPiaoView(withframe: CGRectMake(50, 50, 300, 300), chartStyle: PHChartstyle.PHChartStyleFenShiTu)!
        gupiaoV?.style = .PHChartStyleFenShiTu
        gupiaoV?.isShiZiXianShown = true
        gupiaoV?.isZoomMode = false
        
        gupiaoV?.subStyle = PHLaZhuTuSubstyle.PHLaZhuTuSubstyleVOL
        gupiaoV?.backgroundColor = UIColor.whiteColor()
        isFullScreen = false
        
        
        self.settudata()
        self.settingData()
        
        
        
        
}


    
    func tapScreen() {
        if (isFullScreen == true) {
            self.clickRecover()
        }
        else
        {
            
            self.click()
        }

    }
    
    
    
    func clickRecover() {
        isFullScreen = false
        
        self.setNeedsStatusBarAppearanceUpdate()
        UIView.animateWithDuration(2.0) { 
            self.gupiaoV?.transform = CGAffineTransformMakeRotation(0)
            self.gupiaoV!.frame = CGRectMake(0, 80, self.view.frame.size.width, 300)
        }
                gupiaoV!.setNeedsDisplay()
}
    
    
    
    override func prefersStatusBarHidden() -> Bool {
        return isFullScreen ? true : false
    }
    
    
    
    func click() {
       
        let pi:CGFloat = 3.1415
        isFullScreen = true
        self.setNeedsStatusBarAppearanceUpdate()
        
        
        UIView.animateWithDuration(2.0) {
            
            var tempt = self.gupiaoV!.center
            tempt.x = self.view.frame.size.width / 2
            tempt.y = self.view.frame.size.height / 2
            
            var tem = self.gupiaoV!.bounds
            tem.size.width = self.view.frame.size.height
            tem.size.height = self.view.frame.size.width
            
            self.gupiaoV?.center = tempt
             self.gupiaoV?.bounds = tem

            self.gupiaoV?.transform = CGAffineTransformMakeRotation(pi/2)
            
        }

        
        gupiaoV!.setNeedsDisplay()

    }
    
    
    
    func settudata() {
        gupiaoV?.setLabel()
        gupiaoV?.setZuoShouAndZongLiang(3220, zongliang: "97.3万")
        
        let path1 = NSBundle.mainBundle().pathForResource("dazhexian", ofType: "plist")
        let array1 = NSArray(contentsOfFile: path1!)
        let path3 = NSBundle.mainBundle().pathForResource("zhutu", ofType: "plist")
        let array3 = NSArray(contentsOfFile: path3!)

        
        let arr = NSMutableArray()
        for element  in array1! {
            let numtempt =  element as! CGFloat - 40
            arr.addObject(numtempt)
        }
        let array2 = arr
        
        gupiaoV?.setFenShiDaZheAndXiaoZheArray(array1!, xiaozhe: array2)
        gupiaoV?.setFenShiZhuTuArray(array3!)

}
    
    
    func settingData() {
        let path1 = NSBundle.mainBundle().pathForResource("lazhutu1", ofType: "plist")
        let array1 = NSArray(contentsOfFile: path1!)
        let path2 = NSBundle.mainBundle().pathForResource("vol", ofType: "plist")
        let array2 = NSArray(contentsOfFile: path2!)
        let path3 = NSBundle.mainBundle().pathForResource("macd", ofType: "plist")
        let array3 = NSArray(contentsOfFile: path3!)
        
        gupiaoV?.setLZTarray(array1!)
        gupiaoV?.setVol(array2!)
        gupiaoV?.setMACD(array3!)
    }

}



