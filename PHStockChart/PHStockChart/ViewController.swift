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
        
        
        gupiaoV = GuPiaoView(withframe: CGRect(x: 0, y: 60, width: 300, height: 200), chartStyle: PHChartstyle.phChartStyleFenShiTu)!
        gupiaoV?.style = .phChartStyleLaZhuTu
        gupiaoV?.isShiZiXianShown = true
        gupiaoV?.isZoomMode = false
        
        gupiaoV?.subStyle = .phLaZhuTuSubstyleVOL
        gupiaoV?.backgroundColor = UIColor.white
        isFullScreen = false

        if gupiaoV?.style == .phChartStyleFenShiTu {
           self.settudata()
        }
        else
        {
         self.settingData()
        }
        
        self.view.addSubview(gupiaoV!)
        
        let label:UILabel = UILabel.init(frame: CGRect(x: 60, y: 300, width: 200, height: 100))
        label.text = "DOUBLE TAP VIEW TO DISPLAY FULLSCREEN AND RECOVOER,双击视图可以全屏显示或恢复"
        label.numberOfLines = 4;
        label.font = UIFont(name: "system", size: 14)
        let gestureRecog = UITapGestureRecognizer(target: self, action:#selector(ViewController.tapScreen))
        gestureRecog.numberOfTapsRequired = 2
        gupiaoV?.addGestureRecognizer(gestureRecog)
        self.view.addSubview(label)
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
        UIView.animate(withDuration: 2.0, animations: { 
            self.gupiaoV?.transform = CGAffineTransform(rotationAngle: 0)
            self.gupiaoV!.frame = CGRect(x: 0, y: 60, width: 300, height: 200)
        }) 
                gupiaoV!.setNeedsDisplay()
}
    
    
    
    override var prefersStatusBarHidden : Bool {
        return isFullScreen ? true : false
    }
    
    
    
    func click() {
       
        let pi:CGFloat = 3.1415
        isFullScreen = true
        self.setNeedsStatusBarAppearanceUpdate()
        
    
        
        UIView.animate(withDuration: 2.0, animations: {
            
            var tempt = self.gupiaoV!.center
            tempt.x = self.view.frame.size.width / 2
            tempt.y = self.view.frame.size.height / 2
            
            var tem = self.gupiaoV!.bounds
            tem.size.width = self.view.frame.size.height
            tem.size.height = self.view.frame.size.width
            
            self.gupiaoV?.center = tempt
             self.gupiaoV?.bounds = tem

            self.gupiaoV?.transform = CGAffineTransform(rotationAngle: pi/2)
            
        }) 
        gupiaoV!.setNeedsDisplay()
}
    

    
    func settudata() {
        gupiaoV?.setLabel()
        gupiaoV?.setZuoShouAndZongLiang(3220, zongliang: "97.3万")
        
        let path1 = Bundle.main.path(forResource: "dazhexian", ofType: "plist")
        let array1 = NSArray(contentsOfFile: path1!)
        let path3 = Bundle.main.path(forResource: "zhutu", ofType: "plist")
        let array3 = NSArray(contentsOfFile: path3!)

        
        let arr = NSMutableArray()
        for element  in array1! {
            let numtempt =  element as! CGFloat - 40
            arr.add(numtempt)
        }
        let array2 = arr
        
        gupiaoV?.setFenShiDaZheAndXiaoZheArray(array1!, xiaozhe: array2 ,zhutu:array3!)

}
    
    
    func settingData() {
        let path1 = Bundle.main.path(forResource: "lazhutu1", ofType: "plist")
        let array1 = NSArray(contentsOfFile: path1!)
        let path2 = Bundle.main.path(forResource: "vol", ofType: "plist")
        let array2 = NSArray(contentsOfFile: path2!)
        let path3 = Bundle.main.path(forResource: "macd", ofType: "plist")
        let array3 = NSArray(contentsOfFile: path3!)
        
        gupiaoV?.setLZTarray(array1!)
        gupiaoV?.setVol(array2!)
        gupiaoV?.setMACD(array3!)
    }

}



