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
    case PHShiZiStyleFenShiTu = 1
    case PHShiZiStyleLaZhuTu
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
    
    
    init?(x: CGFloat, y: CGFloat) {
        
        self.xValue = x
        self.yValue = y
        view_size = CGSizeZero
        shiZiXian = .PHShiZiStyleFenShiTu
        linewidth = 0.4
        
        super.init()
}

    
// MARK: 重绘制图形
    override func drawInContext(ctx: CGContext) {
        
        if shiZiXian == .PHShiZiStyleFenShiTu {
            
            self.styleFenShi(ctx)
        }
        else
        {
            self.styleLaZhuTu(ctx)
        }
}
    
// MARK: 重绘的具体样式
    
    func styleFenShi(ctx:CGContextRef) {
      
        view_size = self.bounds.size
        
        let linewidth = self.linewidth
        let padding:CGFloat = 5.00
        let buttonpadding:CGFloat = 20.00
        
        let squareH = (view_size.height - 2 * padding - buttonpadding) / 6
        
        //竖线
        CGContextMoveToPoint(ctx, xValue, padding + 1);
        CGContextAddLineToPoint(ctx, xValue, padding);
        CGContextSetLineWidth(ctx, linewidth);
        CGContextStrokePath(ctx);
        
        CGContextMoveToPoint(ctx, xValue, padding + 1 );
        CGContextAddLineToPoint(ctx, xValue, padding + 4 * squareH);
        CGContextStrokePath(ctx);
        
        CGContextMoveToPoint(ctx, xValue, 2 * padding + 4 * squareH);
        CGContextAddLineToPoint(ctx, xValue, view_size.height - buttonpadding);
        CGContextStrokePath(ctx);
        
        let y = padding + (1 - yValue) * 4 * squareH;
        //横线
        CGContextMoveToPoint(ctx, xValue, y);
        CGContextAddLineToPoint(ctx, padding, y);
        CGContextStrokePath(ctx);
        
        CGContextMoveToPoint(ctx, xValue, y);
        CGContextAddLineToPoint(ctx, view_size.width - padding , y);
        CGContextStrokePath(ctx);
}
    

    func styleLaZhuTu(ctx:CGContextRef) {
        
        view_size = self.bounds.size
        
        let linewidth = self.linewidth
        let padding:CGFloat = 5.00
        let buttonpadding:CGFloat = 20.00
        
        let squareH = (view_size.height - 3 * padding - buttonpadding) / 5
        
        //竖线
        CGContextMoveToPoint(ctx, xValue, padding + 1);
        CGContextAddLineToPoint(ctx, xValue, padding);
        CGContextSetLineWidth(ctx, linewidth);
        CGContextStrokePath(ctx);
        
        CGContextMoveToPoint(ctx, xValue, padding + 1 );
        CGContextAddLineToPoint(ctx, xValue, padding + 4 * squareH);
        CGContextStrokePath(ctx);
        
        CGContextMoveToPoint(ctx, xValue, 2 * padding + buttonpadding + 4 * squareH);
        CGContextAddLineToPoint(ctx, xValue, view_size.height - padding);
        CGContextStrokePath(ctx);
        
        let y = padding + (1 - yValue) * 4 * squareH;
        //横线
        CGContextMoveToPoint(ctx, xValue, y);
        CGContextAddLineToPoint(ctx, padding, y);
        CGContextStrokePath(ctx);
        
        CGContextMoveToPoint(ctx, xValue, y);
        CGContextAddLineToPoint(ctx, view_size.width - padding , y);
        CGContextStrokePath(ctx);
}
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
    
    

    
}


