//
//  ShiZiLayer.swift
//  PHStockChart
//
//  Created by Peter on 5/11/16.
//  Copyright © 2016 Peter. All rights reserved.
//

import UIKit

/**
 十字线的类型
 
 - PHShiZiStyleFenShiTu: 分时图十字线
 - PHShiZiStyleLaZhuTu:  蜡烛图十字线
 */
   enum PHShiZiStyle:Int  {
    case phShiZiStyleFenShiTu = 1
    case phShiZiStyleLaZhuTu
}


class ShiZiLayer: CALayer {


    var view_size:CGSize
    /// 十字线的X值
    var xValue:CGFloat
    /// 十字线的Y值
    var yValue:CGFloat
    /// 十字线类型
    var shiZiXian:PHShiZiStyle
    
   /// 十字线的宽度
    var linewidth:CGFloat
    
    
    init?(x: CGFloat, y: CGFloat, layer:Any) {
        
        self.xValue = x
        self.yValue = y
        view_size = CGSize.zero
        shiZiXian = .phShiZiStyleFenShiTu
        linewidth = 0.4
        super.init(layer: layer)
}


    
// MARK: 重绘制图形
    override func draw(in ctx: CGContext) {
        if ((xValue==0)||(yValue==0)) {
            return
        }
        if shiZiXian == .phShiZiStyleFenShiTu {
            
            self.styleFenShi(ctx)
        }
        else
        {
            self.styleLaZhuTu(ctx)
        }
}
    
// MARK: 重绘的具体样式
    
    func styleFenShi(_ ctx:CGContext) {
      
        view_size = self.bounds.size
        
        let linewidth = self.linewidth
        let padding:CGFloat = 5.00
        let buttonpadding:CGFloat = 20.00
        
        let squareH = (view_size.height - 2 * padding - buttonpadding) / 6
        
        //竖线
        ctx.move(to: CGPoint(x: xValue, y: padding + 1));
        ctx.addLine(to: CGPoint(x: xValue, y: padding));
        ctx.setLineWidth(linewidth);
        ctx.strokePath();
        
        ctx.move(to: CGPoint(x: xValue, y: padding + 1));
        ctx.addLine(to: CGPoint(x: xValue, y: padding + 4 * squareH));
        ctx.strokePath();
        
        ctx.move(to: CGPoint(x: xValue, y: 2 * padding + 4 * squareH));
        ctx.addLine(to: CGPoint(x: xValue, y: view_size.height - buttonpadding));
        ctx.strokePath();
        
        let y = padding + (1 - yValue) * 4 * squareH;
        //横线
        ctx.move(to: CGPoint(x: xValue, y: y));
        ctx.addLine(to: CGPoint(x: padding, y: y));
        ctx.strokePath();
        
        ctx.move(to: CGPoint(x: xValue, y: y));
        ctx.addLine(to: CGPoint(x: view_size.width - padding, y: y));
        ctx.strokePath();
}
    

    func styleLaZhuTu(_ ctx:CGContext) {
        
        view_size = self.bounds.size
        
        let linewidth = self.linewidth
        let padding:CGFloat = 5.00
        let buttonpadding:CGFloat = 20.00
        
        let squareH = (view_size.height - 3 * padding - buttonpadding) / 5
        
        //竖线
        ctx.move(to: CGPoint(x: xValue, y: padding + 1));
        ctx.addLine(to: CGPoint(x: xValue, y: padding));
        ctx.setLineWidth(linewidth);
        ctx.strokePath();
        
        ctx.move(to: CGPoint(x: xValue, y: padding + 1));
        ctx.addLine(to: CGPoint(x: xValue, y: padding + 4 * squareH));
        ctx.strokePath();
        
        ctx.move(to: CGPoint(x: xValue, y: 2 * padding + buttonpadding + 4 * squareH));
        ctx.addLine(to: CGPoint(x: xValue, y: view_size.height - padding));
        ctx.strokePath();
        
        let y = padding + (1 - yValue) * 4 * squareH;
        //横线
        ctx.move(to: CGPoint(x: xValue, y: y));
        ctx.addLine(to: CGPoint(x: padding, y: y));
        ctx.strokePath();
        
        ctx.move(to: CGPoint(x: xValue, y: y));
        ctx.addLine(to: CGPoint(x: view_size.width - padding, y: y));
        ctx.strokePath();
}
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
   
    
    
    func setShiZiLayerStyle(_ style:PHShiZiStyle) {
      shiZiXian = style
    }

}


