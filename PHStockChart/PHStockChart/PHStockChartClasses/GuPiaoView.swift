//
//  GuPiaoView.swift
//  PHStockChart
//
//  Created by Peter on 5/11/16.
//  Copyright © 2016 Peter. All rights reserved.
//

import UIKit

/**
 选择绘制图表的样式
 
 - PHChartStyleFenShiTu: 绘制分时图
 - PHChartStyleLaZhuTu:  绘制蜡烛图
 */
  enum PHChartstyle:Int {
    case PHChartStyleFenShiTu = 1
    case PHChartStyleLaZhuTu
}



/**
 - PHLaZhuTuSubstyleVOL:  交易量样式
 - PHLaZhuTuSubstyleMACD: MACD样式
 - PHLaZhuTuSubstyleKDJ:  KDJ样式  K ,D (0 - 100) J可以大于100，也可以小于0。
 - PHLaZhuTuSubstyleRSI:  RSI样式,值为（0 - 100）之间
 - PHLaZhuTuSubstyleBIAS: BIAS样式,BIAS = (PRICE - DAY?AVERAGE)/AVERAGE * 100, DAY6,12,24.
 - PHLaZhuTuSubstyleDMA:  DMA样式,DMA = AVERAGE10 - AVERAGE50 , AMA = AVERAGE10 .
 - PHLaZhuTuSubstyleOBV:  OBV样式,由OBV值和线两部分组成
 - PHLaZhuTuSubstyleROC:  ROC样式,一般有两条线组成，ROC =（tcprice - 12db_price)/12db_price *100
 - PHLaZhuTuSubstyleMTM:  MTM样式,MTM = (c + cn * 100) - 100
 - PHLaZhuTuSubstyleCR:   CR样式, CR = P1 / P2 * 100
 - PHLaZhuTuSubstyleDMI:  DMI样式, 由PDI,MDI,ADX,ADXR四条线组成
 - PHLaZhuTuSubstyleBRAR: BRAR样式,情绪指标,由BR线和AR线组成
 - PHLaZhuTuSubstyleVR:   VR样式,成交变异率
 - PHLaZhuTuSubstyleTRIX: TRIX样式
 - PHLaZhuTuSubstyleEMV:  EMV样式
 - PHLaZhuTuSubstyleWR:   WR样式
 - PHLaZhuTuSubstyleCCI:  CCI样式,三根值为100，0，-100的虚线和一根实线组成
 - PHLaZhuTuSubstylePSY:  PSY样式
 - PHLaZhuTuSubstyleDPO:  DPO样式
 - PHLaZhuTuSubstyleBOLL: BOLL样式
 - PHLaZhuTuSubstyleASI:  ASI样式
 - PHLaZhuTuSubstyleSAR:  SAR样式
 */
enum PHLaZhuTuSubstyle:Int {
    case PHLaZhuTuSubstyleVOL = 1
    case PHLaZhuTuSubstyleMACD
    case PHLaZhuTuSubstyleKDJ
    case PHLaZhuTuSubstyleRSI
    case PHLaZhuTuSubstyleBIAS
    case PHLaZhuTuSubstyleDMA
    case PHLaZhuTuSubstyleOBV
    case PHLaZhuTuSubstyleROC
    case PHLaZhuTuSubstyleMTM
    case PHLaZhuTuSubstyleCR
    case PHLaZhuTuSubstyleDMI
    case PHLaZhuTuSubstyleBRAR
    case PHLaZhuTuSubstyleVR
    case PHLaZhuTuSubstyleTRIX
    case PHLaZhuTuSubstyleEMV
    case PHLaZhuTuSubstyleWR
    case PHLaZhuTuSubstyleCCI
    case PHLaZhuTuSubstylePSY
    case PHLaZhuTuSubstyleDPO
    case PHLaZhuTuSubstyleBOLL
    case PHLaZhuTuSubstyleASI
    case PHLaZhuTuSubstyleSAR
}



class GuPiaoView: UIView {
    
// MARK: 样式设置
    
    /// 图表样式
    var style:PHChartstyle
    /// 蜡烛图子视图属性
    var subStyle:PHLaZhuTuSubstyle = .PHLaZhuTuSubstyleVOL
    
// MARK: 宏变量
   
    var VIEW_SIZE:CGSize = CGSizeZero
    var padding:CGFloat = 5
    var buttompadding:CGFloat = 20
    var squareH:CGFloat = 0
    var squareW:CGFloat = 0
    var squareH1:CGFloat = 0

// MARK: 分时图属性
    
    var daZhexData = NSArray()
    var xiaoZhexData = NSArray()
    var zhuData = NSArray()
    
    var fenShiVol = NSArray()
    var fenShiDaZhe = NSArray()
    var fenShiXiaoZhe = NSArray()
    
    var zuoShou:CGFloat = 0
    
    var zuigaoL = UILabel()
    var zuidiL = UILabel()
    var jyzl = UILabel()
    var zuigaoB = UILabel()
    var zuidiB = UILabel()
    var shijian1 = UILabel()
    var shijian2 = UILabel()
    var shijian3 = UILabel()
    var shijian4 = UILabel()
    var shijian5 = UILabel()
    
// MARK: 蜡烛图属性
    
    var laZhuTuTransArray = NSArray()
    var volArray = NSArray()
    var macdArray = NSArray()
    var kdjArray = NSArray()
    var rsiArray = NSArray()
    var biasArray = NSArray()
    var dmaArray = NSArray()
    var obvArray = NSArray()
    var rocArray = NSArray()
    var mtmArray = NSArray()
    var crArray = NSArray()
    var dmiArray = NSArray()
    var brarArray = NSArray()
    var vrArray = NSArray()
    var trixArray = NSArray()
    var emvArray = NSArray()
    var wrArray = NSArray()
    var cciArray = NSArray()
    var bollArray = NSArray()
    var psyArray = NSArray()
    var dpoArray = NSArray()
    var asiArray = NSArray()

// MARK: 其它属性
    
    var isShiZiXianShown:Bool = false
    var isZoomMode:Bool = false
    var  shiZiLayer = ShiZiLayer(x: 0, y: 0)!
    
// MARK: 初始化方法
    
    init?(withframe frame:CGRect, chartStyle chartstyle: PHChartstyle ) {
        
        style = chartstyle

        super.init(frame: frame)
}
 
    
// MARK: 重绘方法
   
    /**
     重绘方法
     
     - parameter rect: 尺寸的大小
     */
    override func drawRect(rect: CGRect) {
       
        if(style == .PHChartStyleFenShiTu){
            
            self.setFangKuang()
            self.setBiaoQian()
            self.setVol1()
            self.setFenShiTu()
        }
        else
        {
            self.setFangKuang2()
            self.setLaZhuTu()
            
            switch(subStyle){
            case .PHLaZhuTuSubstyleVOL:
                self.setVol2()
            case  .PHLaZhuTuSubstyleMACD:
                self.setMACD()
            case .PHLaZhuTuSubstyleKDJ:
                self.setKDJ()
            case .PHLaZhuTuSubstyleRSI:
                self.setRSI()
            case .PHLaZhuTuSubstyleBIAS:
                self.setBIAS()
            case .PHLaZhuTuSubstyleDMA:
                self.setDMA()
            case .PHLaZhuTuSubstyleOBV:
                self.setOBV()
            case .PHLaZhuTuSubstyleROC:
                self.setROC()
            case .PHLaZhuTuSubstyleMTM:
                self.setMTM()
            case .PHLaZhuTuSubstyleCR:
                self.setCR()
            case .PHLaZhuTuSubstyleDMI:
                self.setDMI()
            case .PHLaZhuTuSubstyleBRAR:
                self.setBRAR()
            case .PHLaZhuTuSubstyleVR:
                self.setVR()
            case .PHLaZhuTuSubstyleTRIX:
                self.setTRIX()
            case .PHLaZhuTuSubstyleEMV:
                self.setEMV()
            case .PHLaZhuTuSubstyleWR:
                self.setWR()
            case .PHLaZhuTuSubstyleCCI:
                self.setCCI()
            case .PHLaZhuTuSubstylePSY:
                self.setPSY()
            case .PHLaZhuTuSubstyleDPO:
                self.setDPO()
            case .PHLaZhuTuSubstyleBOLL:
                self.setBOLL()
            case .PHLaZhuTuSubstyleASI:
                self.setASI()
            default:
                self.setSAR()
        }
    }
}

    
// MARK: 分时图初始化方法
   
    /**
     设置分时图标签
     */
    func setLabel() {
        
        VIEW_SIZE = self.bounds.size
        squareH = (VIEW_SIZE.height - 2 * padding - buttompadding) / 6
        squareW = (VIEW_SIZE.width - 2 * padding) / 4
        squareH1 =  (VIEW_SIZE.height - 3 * padding - buttompadding) / 5
        
        let color:UIColor = self.setColor(166, g: 166, b: 166, a: 1)
        //left
        zuigaoL.font = UIFont.systemFontOfSize(8.0)
        zuigaoL.textColor = color
        zuidiL.font = UIFont.systemFontOfSize(8.0)
        zuidiL.textColor = color
        
        jyzl.font = UIFont.systemFontOfSize(8.0)
        jyzl.textColor = color
        //right
        zuigaoB.textAlignment = NSTextAlignment.Right
        zuigaoB.font = UIFont.systemFontOfSize(8.0)
        zuigaoB.textColor = color
        zuidiB.textAlignment = NSTextAlignment.Right;
        zuidiB.font = UIFont.systemFontOfSize(8.0)
        zuidiB.textColor = color
        //shijian
        shijian1.text = "09.30"
        shijian1.textAlignment = NSTextAlignment.Left;
        shijian1.font = UIFont.systemFontOfSize(7.0)
        shijian1.textColor = color
        
        shijian2.text = "10.30"
        shijian2.textAlignment = NSTextAlignment.Center
        shijian2.font = UIFont.systemFontOfSize(7.0)
        shijian2.textColor = color
        
        shijian3.text = "11.30/13:00"
        shijian3.textAlignment = NSTextAlignment.Center
        shijian3.font = UIFont.systemFontOfSize(7.0)
        shijian3.textColor = color
        
        shijian4.text = "14:00"
        shijian4.textAlignment = NSTextAlignment.Center
        shijian4.font = UIFont.systemFontOfSize(7.0)
        shijian4.textColor = color
        
        shijian5.text = "15:00"
        shijian5.textAlignment = NSTextAlignment.Right
        shijian5.font = UIFont.systemFontOfSize(7.0)
        shijian5.textColor = color
        
        self.layer.addSublayer(shiZiLayer)
        shiZiLayer.hidden = true
        shiZiLayer.shiZiXian = .PHShiZiStyleFenShiTu
   
        self.addSubview(zuigaoL)
        self.addSubview(zuidiL)
        self.addSubview(zuigaoB)
        self.addSubview(zuidiB)
        self.addSubview(jyzl)
        self.addSubview(shijian1)
        self.addSubview(shijian2)
        self.addSubview(shijian3)
        self.addSubview(shijian4)
        self.addSubview(shijian5)
}
    

    /**
     设置分时图昨收和总量数据
     
     - parameter zuoshouv:  昨收
     - parameter zongliang: 总量
     */
    func setZuoShouAndZongLiang(zuoshouv:CGFloat,zongliang:NSString) {
        zuoShou = zuoshouv
        jyzl.text = zongliang as String
}
    
    /**
     设置分时图数组
     
     - parameter dazhe:   大折线数组
     - parameter xiaozhe: 小折线数组
     */
    func setFenShiDaZheAndXiaoZheArray(dazhe:NSArray,xiaozhe:NSArray) {
        daZhexData = dazhe
        xiaoZhexData = xiaozhe
}
    
    
    /**
     设置分时柱图数组
     
     - parameter zhutu: 柱图数组
     */
    func setFenShiZhuTuArray(zhutu:NSArray) {
        zhuData = zhutu
        self.transferFenShiData()
}
    
    func transferFenShiData() {
        // find biggest offsetvalue
        var maxOffSetValue:CGFloat = 0
        for element in daZhexData {
            let  absolutevalue = self.getAbosoluteValue( element as! CGFloat - zuoShou)
            if (maxOffSetValue < absolutevalue) { maxOffSetValue = absolutevalue }
        }
        for  element  in xiaoZhexData {
            let  absolutevalue = self.getAbosoluteValue( element as! CGFloat - zuoShou)
            if (maxOffSetValue < absolutevalue){ maxOffSetValue = absolutevalue }
        }
        let high = zuoShou + maxOffSetValue
        let low  = zuoShou - maxOffSetValue
        // set fenshidazhexian array
        let dazhe = NSMutableArray()
        for element in daZhexData  {
            let temptfloat = (element as! CGFloat - low)/(2 * maxOffSetValue);
            dazhe.addObject(temptfloat)
        }
        fenShiDaZhe = dazhe
        // set fenshixiaozhexian array
        let xiaozhe = NSMutableArray()
        for element in  xiaoZhexData {
            let temptfloat = (element as! CGFloat - low)/(2 * maxOffSetValue);
            xiaozhe.addObject(temptfloat)
        }
        fenShiXiaoZhe = xiaozhe
        //转换分时图成交量数据
        let temptarra = NSMutableArray()
        var _max_NUM = zhuData[0][1] as! CGFloat
        
        for  element in  zhuData {
            let number = element[1] as! CGFloat
            if (_max_NUM < number){ _max_NUM = number }
            }
        
        for element in  zhuData  {
    
            let tempt = NSMutableArray()
            let temptNumber1 = element[0] as! CGFloat
            let temptNumber2 = element[1] as! CGFloat / _max_NUM
            tempt.addObject(temptNumber1)
            tempt.addObject(temptNumber2)
            temptarra.addObject(tempt)
        }
            fenShiVol = temptarra
        //setlabel
         zuigaoL.text = String(format: "%.1f",high)
         zuigaoB.text = String(format: "%.2f%%",maxOffSetValue * 100 / zuoShou)
         zuidiL.text  = String(format: "%.1f",low)
         zuidiB.text  = String(format: "-%.2f%%",maxOffSetValue * 100 / zuoShou)
}
  
    
// MARK: 蜡烛图初始化方法
    
    /**
     设置蜡烛图数组
     
     - parameter lztarray: 蜡烛图数组
     */
    func setLZTarray(lztarray:NSArray) {
        
        VIEW_SIZE = self.bounds.size
        squareH = (VIEW_SIZE.height - 2 * padding - buttompadding) / 6
        squareW = (VIEW_SIZE.width - 2 * padding) / 4
        squareH1 =  (VIEW_SIZE.height - 3 * padding - buttompadding) / 5
        
        shiZiLayer.hidden = true
        shiZiLayer.shiZiXian = .PHShiZiStyleLaZhuTu

        var _max_NUM =  lztarray[0][0] as! CGFloat
        var _min_NUM =  lztarray[0][0] as! CGFloat
        
        for element in  lztarray {
            for  i in 0 ..< 7 {
               let num = element[i] as! CGFloat
                if (_max_NUM < num){ _max_NUM = num }
                if (_min_NUM > num){ _min_NUM = num }
            }
        }
        _max_NUM -= _min_NUM
        
        let temptarra = NSMutableArray()
        for element in  lztarray {
            let tempt = NSMutableArray()
            for  i in 0 ..< 7 {
               let temptNumber = (element[i] as! CGFloat - _min_NUM) / _max_NUM
                tempt.addObject(temptNumber)
            }
            temptarra.addObject(tempt)
       }
        laZhuTuTransArray = temptarra
  }
    
    
    /**
     蜡烛图成交量
     
     - parameter volarray: 成交量
     */
    func setVol(volarray:NSArray) {
        
        let temptarra = NSMutableArray()
        var _max_NUM = volarray[0][1] as! CGFloat
        
            for element in  volarray {
            let value1 = element[0] as! CGFloat
            let value2 = element[1] as! CGFloat
                if (_max_NUM < value1){ _max_NUM = value1 }
                if (_max_NUM < value2){ _max_NUM = value2 }
        }
    
        for element in  volarray {
            let tempt = NSMutableArray();
            let temptNumber1 = element[0] as! CGFloat
            let temptNumber2 = element[0] as! CGFloat  / _max_NUM
            tempt.addObject(temptNumber1)
            tempt.addObject(temptNumber2)
            temptarra.addObject(tempt)
        }
        volArray = temptarra
}
    
    /**
     蜡烛图MACD
     
     - parameter macdarray: MACD
     */
    func setMACD(macdarray:NSArray) {
        var _max_NUM:CGFloat = 0
        for element in macdarray {
            let ema12 = element[0] as! CGFloat
            let ema26 = element[1] as! CGFloat
            let dif = ema12 - ema26
            
            if (_max_NUM < self.getAbosoluteValue(ema12)){ _max_NUM = self.getAbosoluteValue(ema12)}
            if (_max_NUM < self.getAbosoluteValue(ema26)){ _max_NUM = self.getAbosoluteValue(ema26)}
            if (_max_NUM < self.getAbosoluteValue(dif)){ _max_NUM = self.getAbosoluteValue(dif)}
        }
        let temptarra = NSMutableArray()
        for element in macdarray {
            let temptarray = NSMutableArray()
            let ema12 = (element[0] as! CGFloat) / (_max_NUM * 1.1)
            let ema26 = (element[1] as! CGFloat) / (_max_NUM * 1.1)
            let delta = (ema12 - ema26) * 2
            temptarray.addObject(ema12)
            temptarray.addObject(ema26)
            temptarray.addObject(delta)
            temptarra.addObject(temptarray)
        }
         macdArray = temptarra
}

    
    /**
     蜡烛图KDJ
     
     - parameter kdjarray: KDJ
     */
    func setKDJ(kdjarray:NSArray) {
        
        kdjArray = self.getLineArray(kdjarray)
}
    
    /**
     蜡烛图RSI
     
     - parameter rsiarray: RSI
     */
    func setRSI(rsiarray:NSArray) {
        
        rsiArray = self.getLineArray(rsiarray)
}
    
    /**
     蜡烛图BIAS
     
     - parameter biasarray: BIAS
     */
    func setBIAS(biasarray:NSArray) {
        
        biasArray = self.getLineArray(biasarray)
}
    
    
    /**
     蜡烛图DMA
     
     - parameter dmaarray: DMA
     */
    func setDMA(dmaarray:NSArray) {
        
        dmaArray = self.getLineArray(dmaarray)
}
    
    
    /**
     蜡烛图OBV
     
     - parameter obvarray: OBV
     */
    func setOBV(obvarray:NSArray) {
        
        obvArray = self.getLineArray(obvarray)
}
    
    
    
    /**
     蜡烛图ROC
     
     - parameter rocarray: ROC
     */
    func setROC(rocarray:NSArray) {
        
        rocArray = self.getLineArray(rocarray)
}
    
    
    
    /**
     蜡烛图MTM
     
     - parameter mtmarray: MTM
     */
    func setMTM(mtmarray:NSArray) {
        
        var  _MAX_NUM = mtmarray[0][0] as! CGFloat
        var  _MIN_NUM = mtmarray[0][0] as! CGFloat
        
        for element in mtmarray {
            let MTM1value = element[0] as! CGFloat
            let MTM2value = element[1] as! CGFloat
            if (_MAX_NUM < MTM1value ){ _MAX_NUM = MTM1value }
            if (_MAX_NUM < MTM2value ){ _MAX_NUM = MTM2value }
            if (_MIN_NUM > MTM1value ){ _MIN_NUM = MTM1value }
            if (_MIN_NUM > MTM2value ){ _MIN_NUM = MTM2value }
       }
        let  delta = _MAX_NUM - _MIN_NUM
        let temptarra = NSMutableArray()
        for element in mtmarray {
            let  temptarray = NSMutableArray()
            let mtm1newvalue = (element[0] as! CGFloat - _MIN_NUM) / delta
            let mtm2newvalue = (element[1] as! CGFloat - _MIN_NUM) / delta
            temptarray.addObject(mtm1newvalue)
            temptarray.addObject(mtm2newvalue)
            temptarra.addObject(temptarray)
        }
        mtmArray = temptarra
}
    
    
    /**
     蜡烛图CRA
     
     - parameter crarray: CRA
     */
    func setCR(crarray:NSArray) {
        
        crArray = self.getLineArray(crarray)
    }
    
    
    /**
     蜡烛图DMI
     
     - parameter dmiarray: DMI
     */
    func setDMI(dmiarray:NSArray) {
        
        dmiArray = self.getLineArray(dmiarray)
    }
    
    /**
     蜡烛图BRAR
     
     - parameter brararray: BRAR
     */
    func setBRAR(brararray:NSArray) {
        
        var _MAX_NUM = brararray[0][0] as! CGFloat
        var _MIN_NUM = brararray[0][0] as! CGFloat
        
        for element in brararray {
            let brar1value = element[0] as! CGFloat
            let brar2value = element[1] as! CGFloat
            if (_MAX_NUM < brar1value ){ _MAX_NUM = brar1value }
            if (_MAX_NUM < brar2value ){ _MAX_NUM = brar2value }
            if (_MIN_NUM > brar1value ){ _MIN_NUM = brar1value }
            if (_MIN_NUM > brar2value ){ _MIN_NUM = brar2value }
        }
        let delta = _MAX_NUM - _MIN_NUM
        let temptarra = NSMutableArray()
        for element in brararray {
            let temptarray = NSMutableArray()
            let brar1newvalue = (element[0] as! CGFloat - _MIN_NUM) / delta
            let brar2newvalue = (element[1] as! CGFloat - _MIN_NUM) / delta
            temptarray.addObject(brar1newvalue)
            temptarray.addObject(brar2newvalue)
            temptarra.addObject(temptarray)
        }
        brarArray = temptarra
}
    
    
    /**
     蜡烛图VR
     
     - parameter vrarray: VR
     */
    func setVR(vrarray:NSArray) {
        
        vrArray = self.getLineArray(vrarray)
}
    
    
    /**
     蜡烛图TRIX
     
     - parameter trixarray: TRIX
     */
    func setTRIX(trixarray:NSArray) {
        
        trixArray = self.getLineArray(trixarray)
}
    
    
    /**
     蜡烛图EMV
     
     - parameter emvarray: EMV
     */
    func setEMV(emvarray:NSArray) {
        
        emvArray = self.getLineArray(emvarray)
}
    
    
    
    /**
     蜡烛图WR
     
     - parameter wrarray: WR
     */
    func setWR(wrarray:NSArray) {
        
        wrArray = self.getLineArray(wrarray)
}
    
    
    
    /**
     蜡烛图PSY
     
     - parameter psyarray: PSY
     */
    func setPSY(psyarray:NSArray) {
        
        psyArray = self.getLineArray(psyarray)
}
    
    
    /**
     DPO
     
     - parameter dpoarray: DPO
     */
    func setDPO(dpoarray:NSArray) {
        
        dpoArray = self.getLineArray(dpoarray)
}
    
    /**
     蜡烛图ASI
     
     - parameter asiarray: ASI
     */
    func setASI(asiarray:NSArray) {
        
        asiArray = self.getLineArray(asiarray)
}
    
    
// MARK: 分时图绘图
    
    func setFangKuang() {
        
        let  ctxSK =  UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(ctxSK, padding, padding);
        CGContextAddLineToPoint(ctxSK, VIEW_SIZE.width - padding, padding)
        CGContextAddLineToPoint(ctxSK, VIEW_SIZE.width - padding, padding + 4*squareH)
        CGContextAddLineToPoint(ctxSK, padding, padding + 4*squareH);
        CGContextClosePath(ctxSK)
        CGContextSetLineWidth(ctxSK, 1)
        self.setColor(239, g: 243, b: 244, a: 1).set()
        CGContextStrokePath(ctxSK)
        
        let  ctxxK =  UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(ctxxK, padding, 2*padding + 4*squareH)
        CGContextAddLineToPoint(ctxxK, VIEW_SIZE.width - padding, 2 * padding + 4*squareH)
        CGContextAddLineToPoint(ctxxK, VIEW_SIZE.width - padding, VIEW_SIZE.height - buttompadding);
        CGContextAddLineToPoint(ctxxK, padding, VIEW_SIZE.height - buttompadding)
        CGContextClosePath(ctxxK)
        CGContextSetLineWidth(ctxxK, 1)
        self.setColor(239, g: 243, b: 244, a: 1).set()
        CGContextStrokePath(ctxxK)
        //1coloum
        let ctxc11 =  UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(ctxc11, padding + squareW, padding)
        CGContextAddLineToPoint(ctxc11, padding + squareW, padding + 4*squareH)
        CGContextSetLineWidth(ctxc11, 1)
        self.setColor(239, g: 243, b: 244, a: 1).set()
        CGContextStrokePath(ctxc11)
        
        let  ctxc12 =  UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(ctxc12, padding + 2*squareW, padding)
        CGContextAddLineToPoint(ctxc12, padding + 2*squareW, padding + 4*squareH)
        CGContextSetLineWidth(ctxc12, 1)
        self.setColor(239, g: 243, b: 244, a: 1).set()
        CGContextStrokePath(ctxc12)
        
        let  ctxc13 =  UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(ctxc13, padding + 3*squareW, padding)
        CGContextAddLineToPoint(ctxc13, padding + 3*squareW, padding + 4*squareH)
        CGContextSetLineWidth(ctxc13, 1)
        self.setColor(239, g: 243, b: 244, a: 1).set()
        CGContextStrokePath(ctxc13);
        //1row
        let  ctxr11 =  UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(ctxr11, padding, padding + squareH * 1 )
        CGContextAddLineToPoint(ctxr11,VIEW_SIZE.width - padding, padding + squareH * 1 )
        CGContextSetLineWidth(ctxr11, 1)
        self.setColor(239, g: 243, b: 244, a: 1).set()
        CGContextStrokePath(ctxr11)
        
        let  ctxr13 =  UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(ctxr13, padding, padding + squareH * 3 )
        CGContextAddLineToPoint(ctxr13,VIEW_SIZE.width - padding, padding + squareH * 3 )
        CGContextSetLineWidth(ctxr13, 1)
        self.setColor(239, g: 243, b: 244, a: 1).set()
        CGContextStrokePath(ctxr13)
        //2colum
        let  ctxc21 =  UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(ctxc21, padding + squareW, 2 * padding + 4 * squareH)
        CGContextAddLineToPoint(ctxc21, padding + squareW, VIEW_SIZE.height - buttompadding)
        CGContextSetLineWidth(ctxc21, 1)
        self.setColor(239, g: 243, b: 244, a: 1).set()
        CGContextStrokePath(ctxc21)
        
        let  ctxc22 =  UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(ctxc22, padding + 2*squareW, 2 * padding + 4 * squareH)
        CGContextAddLineToPoint(ctxc22, padding + 2*squareW, VIEW_SIZE.height - buttompadding)
        CGContextSetLineWidth(ctxc22, 1)
        self.setColor(239, g: 243, b: 244, a: 1).set()
        CGContextStrokePath(ctxc22)
        
        let ctxc23 =  UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(ctxc23, padding + 3*squareW, 2 * padding + 4 * squareH)
        CGContextAddLineToPoint(ctxc23, padding + 3*squareW, VIEW_SIZE.height - buttompadding)
        CGContextSetLineWidth(ctxc23, 1)
        self.setColor(239, g: 243, b: 244, a: 1).set()
        CGContextStrokePath(ctxc23)
        //2row
        let  ctxr21 =  UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(ctxr21, padding, 2 * padding + squareH * 5 )
        CGContextAddLineToPoint(ctxr21,VIEW_SIZE.width - padding, 2 * padding + squareH * 5 )
        CGContextSetLineWidth(ctxr21, 1)
        self.setColor(239, g: 243, b: 244, a: 1).set()
        CGContextStrokePath(ctxr21)
}
 
    
    
    
// 标签和时间
    
     func setBiaoQian() {
        //left
        zuigaoL.frame = CGRectMake(padding + 1, padding + 1, 50, 15)
        zuidiL.frame =  CGRectMake(padding + 1, padding + 4 * squareH - 15, 50, 15)
        jyzl.frame =  CGRectMake(padding + 1, 2 * padding + 4 * squareH , 50, 15)
        //right
        zuigaoB.frame =  CGRectMake( VIEW_SIZE.width - padding - 51, padding + 1, 50, 15)
        zuidiB.frame = CGRectMake(VIEW_SIZE.width - padding - 51, padding + 4 * squareH - 15, 50, 15)
        //shijian
        shijian1.frame = CGRectMake( padding , VIEW_SIZE.height - 20, 50, 15)
        shijian2.frame = CGRectMake( padding + squareW - 25 , VIEW_SIZE.height - 20, 50, 15)
        shijian3.frame = CGRectMake( padding + 2 * squareW - 25 , VIEW_SIZE.height - 20, 50, 15)
        shijian4.frame = CGRectMake( padding + 3 * squareW - 25 , VIEW_SIZE.height - 20, 50, 15)
        shijian5.frame = CGRectMake( VIEW_SIZE.width - 56 , VIEW_SIZE.height - 20, 50, 15)
    
            if (self.isShiZiXianShown == true) {
            shiZiLayer.frame = CGRectMake(0, 0, VIEW_SIZE.width, VIEW_SIZE.height)
            shiZiLayer.setNeedsDisplay()
    }
}
    
    
    
    func setFenShiTu() {
        //zhexiantianchong
        let  dazhexianY =  UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(dazhexianY, padding, padding + 4 * squareH)
        let count1 =  fenShiDaZhe.count
        for  i in 0 ..< count1 {
            let percentage = fenShiDaZhe[i] as! CGFloat
            let x = padding +  squareW / 60 * CGFloat(i)
            let y = padding + 4 * squareH * (1 - percentage)
            CGContextAddLineToPoint(dazhexianY, x, y)
        }
        let lastPointX = padding + CGFloat(count1) * squareW / 60
        CGContextAddLineToPoint(dazhexianY, lastPointX, padding + 4 * squareH)
        self.setColor(229, g: 241, b: 250, a: 1).set()
        CGContextSetLineJoin(dazhexianY, .Round)
        CGContextClosePath(dazhexianY)
        CGContextFillPath(dazhexianY)
        //dazhexian
        let  dazhexian =  UIGraphicsGetCurrentContext()
        for i in 0 ..< count1 {
           let percentage = fenShiDaZhe[i] as! CGFloat
            let x = padding +  squareW / 60 * CGFloat(i)
            let y = padding + 4 * squareH * (1 - percentage)
            
            if (i == 0) {
                CGContextMoveToPoint(dazhexian, x , y )
            }
            else
            {
                CGContextAddLineToPoint(dazhexian, x, y)
            }
        }
        self.setColor(152, g: 168, b: 191, a: 1).set()
        CGContextSetLineJoin(dazhexian, .Round)
        CGContextStrokePath(dazhexian)
        //xiaozhexian
        let xiaozhexian =  UIGraphicsGetCurrentContext()
        let count2 = fenShiXiaoZhe.count
        for i in 0 ..< count2  {
            let percentage = fenShiXiaoZhe[i] as! CGFloat
            let x = padding +  squareW / 60 * CGFloat(i)
            let y = padding + 4 * squareH * (1 - percentage)
            if (i == 0) {
                CGContextMoveToPoint(xiaozhexian, x , y )
            }
            else
            {
                CGContextAddLineToPoint(xiaozhexian, x, y)
            }
        }
        self.setColor(252, g: 197, b: 152, a: 1).set()
        CGContextSetLineJoin(xiaozhexian, .Round)
        CGContextStrokePath(xiaozhexian);
        //虚线
        let lengths:[CGFloat] = [4,4]
        let ctxr12 =  UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(ctxr12, padding, padding + squareH * 2 )
        CGContextAddLineToPoint(ctxr12,VIEW_SIZE.width - padding, padding + squareH * 2 )
        CGContextSetLineDash(ctxr12, 5.0, lengths , Int((lengths[0] + lengths[1]) / lengths[0]))
        CGContextSetLineWidth(ctxr12, 1)
        self.setColor(143, g: 243, b: 249, a: 1).set()
        CGContextStrokePath(ctxr12)
}
    
    
//柱状图
    func setVol1() {
        let count  = fenShiVol.count
        for  i in 0 ..< count {
            let redorblue = fenShiVol[i][0] as! CGFloat
            let percentage = fenShiVol[i][1] as! CGFloat
            self.zhutu1Index(i, redOrBlue: Bool(redorblue) , percentage: percentage)
        }
}
    
    
    
    
    func zhutu1Index(index:Int , redOrBlue:Bool, percentage:CGFloat) {
       
        let startPointX = padding  + squareW / 60 * CGFloat(index)
        let startPointY = VIEW_SIZE.height - buttompadding
        let endPointX = padding  + squareW / 60 * CGFloat(index)
        let endPointY = VIEW_SIZE.height  - buttompadding -  2 * squareH  * percentage
        
        let ctx =  UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(ctx, startPointX, startPointY)
        CGContextAddLineToPoint(ctx, endPointX, endPointY)
        self.setColor(236, g: 86 , b: 85 , a: 1).set()
        CGContextStrokePath(ctx)
}
   
    
    
// MARK: 绘制蜡烛图
    
    func setFangKuang2() {
        let  ctxSK =  UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(ctxSK, padding, padding)
        CGContextAddLineToPoint(ctxSK, VIEW_SIZE.width - padding, padding)
        CGContextAddLineToPoint(ctxSK, VIEW_SIZE.width - padding, padding + 4*squareH1)
        CGContextAddLineToPoint(ctxSK, padding, padding + 4*squareH1)
        CGContextClosePath(ctxSK)
        CGContextSetLineWidth(ctxSK, 1)
        self.setColor(239, g: 243 , b: 244 , a: 1).set()
        CGContextStrokePath(ctxSK)
        
       let ctxxK =  UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(ctxxK, padding, 2*padding + buttompadding + 4*squareH1)
        CGContextAddLineToPoint(ctxxK, VIEW_SIZE.width - padding, 2*padding + buttompadding + 4*squareH1)
        CGContextAddLineToPoint(ctxxK, VIEW_SIZE.width - padding, VIEW_SIZE.height - padding)
        CGContextAddLineToPoint(ctxxK, padding, VIEW_SIZE.height - padding)
        CGContextClosePath(ctxxK)
        CGContextSetLineWidth(ctxxK, 1)
        self.setColor(239, g: 243 , b: 244 , a: 1).set()
        CGContextStrokePath(ctxxK)
        
        let lengths:[CGFloat] = [4,4]
        let ctxr11 =  UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(ctxr11, padding, padding + squareH1 * 1 )
        CGContextAddLineToPoint(ctxr11,VIEW_SIZE.width - padding, padding + squareH1 * 1 )
        CGContextSetLineDash(ctxr11, 5.0, lengths , Int((lengths[0] + lengths[1]) / lengths[0]))
        CGContextSetLineWidth(ctxr11, 1)
        self.setColor(239, g: 243 , b: 244 , a: 1).set()

        CGContextStrokePath(ctxr11)
    
        let ctxr12 =  UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(ctxr12, padding, padding + squareH1 * 2 )
        CGContextAddLineToPoint(ctxr12,VIEW_SIZE.width - padding, padding + squareH1 * 2 )
        CGContextSetLineWidth(ctxr12, 1)
        self.setColor(239, g: 243 , b: 244 , a: 1).set()
        CGContextStrokePath(ctxr12)
        
        let ctxr13 =  UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(ctxr13, padding, padding + squareH1 * 3 )
        CGContextAddLineToPoint(ctxr13,VIEW_SIZE.width - padding, padding + squareH1 * 3 )
        CGContextSetLineWidth(ctxr13, 1)
        self.setColor(239, g: 243 , b: 244 , a: 1).set()
        CGContextStrokePath(ctxr13)
        
        if( isZoomMode == false) {
            //ROW HIDE
            let  ctxrH1 =  UIGraphicsGetCurrentContext()
            CGContextMoveToPoint(ctxrH1, padding, padding + squareH1 / 2 * 1 )
            CGContextAddLineToPoint(ctxrH1,VIEW_SIZE.width - padding, padding + squareH1 / 2 * 1 )
            CGContextSetLineWidth(ctxrH1, 1)
            self.setColor(239, g: 243 , b: 244 , a: 1).set()
            CGContextStrokePath(ctxrH1)
            
            let ctxrH2 =  UIGraphicsGetCurrentContext()
            CGContextMoveToPoint(ctxrH2, padding, padding + squareH1 / 2 * 3 )
            CGContextAddLineToPoint(ctxrH2,VIEW_SIZE.width - padding, padding + squareH1 / 2 * 3 )
            CGContextSetLineWidth(ctxrH2, 1)
            self.setColor(239, g: 243 , b: 244 , a: 1).set()
            CGContextStrokePath(ctxrH2)
            
            let ctxrH3 =  UIGraphicsGetCurrentContext()
            CGContextMoveToPoint(ctxrH3, padding, padding + squareH1 / 2 * 5 )
            CGContextAddLineToPoint(ctxrH3,VIEW_SIZE.width - padding, padding + squareH1 / 2 * 5 )
            CGContextSetLineWidth(ctxrH3, 1)
            self.setColor(239, g: 243 , b: 244 , a: 1).set()
            CGContextStrokePath(ctxrH3)
            
            let ctxrH4 =  UIGraphicsGetCurrentContext()
            CGContextMoveToPoint(ctxrH4, padding, padding + squareH1 / 2 * 7 )
            CGContextAddLineToPoint(ctxrH4,VIEW_SIZE.width - padding, padding + squareH1 / 2 * 7 )
            CGContextSetLineWidth(ctxrH4, 1)
            self.setColor(239, g: 243 , b: 244 , a: 1).set()
            CGContextStrokePath(ctxrH4)
            //2row
            let ctxrH5 =  UIGraphicsGetCurrentContext()
            CGContextMoveToPoint(ctxrH5, padding, VIEW_SIZE.height - padding - squareH1 / 2 )
            CGContextAddLineToPoint(ctxrH5,VIEW_SIZE.width - padding, VIEW_SIZE.height - padding - squareH1 / 2 )
            CGContextSetLineWidth(ctxrH5, 1)
            self.setColor(239, g: 243 , b: 244 , a: 1).set()
            CGContextStrokePath(ctxrH5)
        }
        if (isShiZiXianShown == true) {
            shiZiLayer.frame = CGRectMake(0, 0, VIEW_SIZE.width, VIEW_SIZE.height)
            shiZiLayer.setNeedsDisplay()
        }
}
    
    
    //绘制蜡烛图和M5 M10 和 M20线
    func setLaZhuTu() {
        let lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324
        let lazhuCXwidth = lazhuUnitDot * 3
        let count = laZhuTuTransArray.count
        
        let lengths:[CGFloat] = [0,0]
        let ctx =  UIGraphicsGetCurrentContext()
        CGContextSetLineDash(ctx, 5.0, lengths, 0)
        //蜡烛图
        for  i  in 0 ..< count {
            let high  = laZhuTuTransArray[i][0] as! CGFloat
            let low   = laZhuTuTransArray[i][1] as! CGFloat
            let open  = laZhuTuTransArray[i][2] as! CGFloat
            let close = laZhuTuTransArray[i][3] as! CGFloat
            if ( close > open) {
                self.setColor(252, g: 64 , b: 69 , a: 1).set()
            }else
            {
                self.setColor(56, g: 171 , b: 36 , a: 1).set()
            }
            CGContextMoveToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot , padding + ( 1 - high) * 4 * squareH1 )
            CGContextAddLineToPoint(ctx,padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, padding + ( 1 - low) * 4 * squareH1  )
            CGContextSetLineWidth(ctx, lazhuUnitDot)
            CGContextStrokePath(ctx)
            
            CGContextMoveToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, padding + ( 1 - open) * 4 * squareH1  )
            CGContextAddLineToPoint(ctx,padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, padding + ( 1 - close) * 4 * squareH1 )
            CGContextSetLineWidth(ctx, lazhuCXwidth)
            CGContextStrokePath(ctx)
        }
        //M5线
        CGContextSetLineWidth(ctx, lazhuUnitDot)
        CGContextSetLineJoin(ctx, .Round)
        
        let m5lineStart = laZhuTuTransArray[0][4] as! CGFloat
        let m10lineStart = laZhuTuTransArray[0][5] as! CGFloat
        let m20lineStart  = laZhuTuTransArray[0][6] as! CGFloat
        
        CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, padding + ( 1 - m5lineStart) * 4 * squareH1)
        for i  in 0 ..< count {
            let m5line = laZhuTuTransArray[i][4] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, padding + ( 1 - m5line) * 4 * squareH1)
        }
        self.setColor(67, g: 188 , b: 252 , a: 1).set()
        CGContextSetLineWidth(ctx, 0.5)
        CGContextStrokePath(ctx)
        //M10线
        CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, padding + ( 1 - m10lineStart) * 4 * squareH1)
        for i  in 0 ..< count  {
            let m10line = laZhuTuTransArray[i][5] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, padding + ( 1 - m10line) * 4 * squareH1)
        }
        self.setColor(236, g: 194 , b: 81 , a: 1).set()
        CGContextSetLineWidth(ctx, 0.5)
        CGContextStrokePath(ctx)
        //M20线
        CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, padding + ( 1 - m20lineStart) * 4 * squareH1);
        for i  in 0 ..< count {
            let m20line  = laZhuTuTransArray[i][6] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, padding + ( 1 - m20line) * 4 * squareH1)
        }
        self.setColor(224, g: 106 , b: 237 , a: 1).set()
        CGContextSetLineWidth(ctx, 0.5)
        CGContextStrokePath(ctx)
}
  
    
    //绘制成交量
    func setVol2() {
        let count  = volArray.count
        for  i in 0 ..< count {
            let redorblue = volArray[i][0] as! CGFloat
            let percentage = volArray[i][1] as! CGFloat
            self.zhutu2Index(i, redOrBlue: Bool(redorblue) , percentage: percentage)
        }
}
    
    
    
    
    func zhutu2Index(index:Int , redOrBlue:Bool, percentage:CGFloat) {
        
        let lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324
        let lazhuCXwidth = lazhuUnitDot * 3
        
        let startPointX = padding + (3 + 4 * CGFloat(index)) * lazhuUnitDot
        let startPointY = VIEW_SIZE.height - padding
        let endPointX = padding + (3 + 4 * CGFloat(index)) * lazhuUnitDot
        let endPointY = VIEW_SIZE.height  - padding -  squareH1  * percentage
        
        let ctx =  UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(ctx, startPointX, startPointY)
        CGContextAddLineToPoint(ctx, endPointX, endPointY)
        self.setColor(236, g: 86 , b: 85 , a: 1).set()
        CGContextSetLineWidth(ctx, lazhuCXwidth)
        CGContextStrokePath(ctx)
}
    
    
    
    //绘制MACD
    func setMACD() {
        let lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324
        let startpointy = VIEW_SIZE.height - padding - squareH1 / 2
        
        let count  = macdArray.count
        let ctx =  UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(ctx, 1)
        CGContextSetLineJoin(ctx, .Round)
        //EMA12线
        CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - ( macdArray[0][0]  as!CGFloat ) * squareH1 / 2)
        for i in 0 ..< count {
            let ema12value = macdArray[i][0] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, startpointy - squareH1 / 2 * ema12value)
        }
        self.setColor(97, g: 177 , b: 209 , a: 1).set()
        CGContextStrokePath(ctx)
        //EMA26线
        CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - ( macdArray[0][1]  as!CGFloat ) * squareH1/2)
        
        for i in 0 ..< count {
            let ema26value = macdArray[i][1] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, startpointy - squareH1 / 2 * ema26value)
        }
        self.setColor(220, g: 200 , b: 106 , a: 1).set()
        CGContextStrokePath(ctx);
        //阴阳线
        for i in 0 ..< count {
            CGContextMoveToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, startpointy)
            let difnumber = macdArray[i][2] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, startpointy - squareH1 / 2 * difnumber)
            if (difnumber < 0) {
                self.setColor(81, g: 182 , b: 64 , a: 1).set()
            }
            else
            {
                self.setColor(253, g: 73 , b: 83 , a: 1).set()
            }
            CGContextStrokePath(ctx)
        }
}
    
    //绘制KDJ
    func setKDJ() {
        let lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324;
        let startpointy = VIEW_SIZE.height - padding
        
        let count  = kdjArray.count
        let  ctx =  UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(ctx, 1)
        CGContextSetLineJoin(ctx, .Round)
        //k
        CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - (kdjArray[0][0] as! CGFloat ) * squareH1 )
        for i in 0 ..< count {
            let kvalue = kdjArray[i][0] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, startpointy - squareH1 * kvalue)
        }
        self.setColor(213, g: 145 , b: 225 , a: 1).set()
        CGContextStrokePath(ctx)
        //d
        CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - (kdjArray[0][1] as! CGFloat) * squareH1 )
        for i in 0 ..< count {
            let dvalue = kdjArray[i][1] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, startpointy - squareH1 * dvalue)
        }
        self.setColor(83, g: 170 , b: 210 , a: 1).set()
        CGContextStrokePath(ctx)
        //j
        CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - (kdjArray[0][2] as! CGFloat) * squareH1 )
        for i in 0 ..< count {
            let jvalue = kdjArray[i][2] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, startpointy - squareH1 * jvalue )
        }
        self.setColor(218, g: 198 , b: 214 , a: 1).set()
        CGContextStrokePath(ctx)
}
  
    
    //绘制RSI
    func setRSI() {
        let lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324
        let startpointy = VIEW_SIZE.height - padding
        
        let count  = rsiArray.count
        let ctx =  UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(ctx, 1)
        CGContextSetLineJoin(ctx, .Round)
        //rsi1
        CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - (rsiArray[0][0] as! CGFloat) * squareH1)
        for i in 0 ..< count {
            let rsi1value = rsiArray[i][0] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, startpointy - squareH1 * rsi1value )
        }
        self.setColor(213, g: 145 , b: 225 , a: 1).set()
        CGContextStrokePath(ctx)
        //rsi2
        CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - (rsiArray[0][1] as! CGFloat) * squareH1 )
        for i in 0 ..< count {
            let rsi2value = rsiArray[i][1] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, startpointy - squareH1 * rsi2value )
        }
        self.setColor(83, g: 170 , b: 210 , a: 1).set()
        CGContextStrokePath(ctx)
        //rsi3
        CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - (rsiArray[0][2] as! CGFloat) * squareH1)
        for i in 0 ..< count {
            let rsi3value = rsiArray[i][2] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, startpointy - squareH1 * rsi3value )
        }
        self.setColor(218, g: 198 , b: 214 , a: 1).set()
        CGContextStrokePath(ctx)
}

    
    
    //绘制BIAS
    func setBIAS() {
        let lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324
        let startpointy = VIEW_SIZE.height - padding
        
        let count  = biasArray.count
        let ctx =  UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(ctx, 1)
        CGContextSetLineJoin(ctx, .Round)
        //bias1
        CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - (biasArray[0][0] as! CGFloat) * squareH1 )
        for i in 0 ..< count {
            let bias1value = biasArray[i][0] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, startpointy - squareH1 * bias1value )
        }
        self.setColor(213, g: 145 , b: 225 , a: 1).set()
        CGContextStrokePath(ctx)
        //bias2
        CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - (biasArray[0][1] as! CGFloat) * squareH1 )
        for i in 0 ..< count {
            let bias2value = biasArray[i][1] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, startpointy - squareH1 * bias2value )
        }
        self.setColor(83, g: 170 , b: 210 , a: 1).set()
        CGContextStrokePath(ctx)
        //bias3
        CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - (biasArray[0][2] as! CGFloat) * squareH1 )
        for i in 0 ..< count {
            let bias3value = biasArray[i][2] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, startpointy - squareH1 * bias3value )
        }
        self.setColor(218, g: 198 , b: 214 , a: 1).set()
        CGContextStrokePath(ctx)
}
    
    
    //绘制DMA
    func setDMA() {
        self.drawTwoLine(dmaArray)
}
    
    
    //绘制OBV
    
    func setOBV() {
        self.drawTwoLine(obvArray)
}
    

    
    //绘制ROC
    func setROC() {
        self.drawTwoLine(rocArray)
}
    
    
    
    //绘制MTM
    func setMTM() {
        self.drawTwoLine(mtmArray)
}
    
 
    
    //绘制CR
    func setCR() {
        let lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324
        let startpointy = VIEW_SIZE.height - padding
        
        let count = crArray.count
        let ctx =  UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(ctx, 1)
        CGContextSetLineJoin(ctx, .Round)
        //cr1
        CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - (crArray[0][0] as! CGFloat) * squareH1 );
        for  i in 0 ..< count {
            let cr1value = crArray[i][0] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, startpointy - squareH1 * cr1value )
        }
        self.setColor(213, g: 145 , b: 225 , a: 1).set()
        CGContextStrokePath(ctx)
        //cr2
        CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - (crArray[0][1] as! CGFloat) * squareH1)
        for  i in 0 ..< count {
            let cr2value = crArray[i][1] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, startpointy - squareH1 * cr2value)
        }
        self.setColor(83, g: 170 , b: 210 , a: 1).set()
        CGContextStrokePath(ctx)
        //cr3
        CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - (crArray[0][3] as! CGFloat) * squareH1 )
        for  i in 0 ..< count {
            let cr3value = crArray[i][3] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, startpointy - squareH1 * cr3value)
        }
        self.setColor(218, g: 198 , b: 214 , a: 1).set()
        CGContextStrokePath(ctx)
}
    
    
    //绘制DMI
    func setDMI() {
        let lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324
        let startpointy = VIEW_SIZE.height - padding
        
        let count  = dmiArray.count
        let ctx =  UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(ctx, 1)
        CGContextSetLineJoin(ctx, .Round)
        //dmi1
        CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - (dmiArray[0][0] as! CGFloat) * squareH1)
        for i in 0 ..< count {
            let dmi1value = dmiArray[i][0] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, startpointy - squareH1 * dmi1value );
        }
        self.setColor(213, g: 145 , b: 225 , a: 1).set()
        CGContextStrokePath(ctx)
        //dmi2
        CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - (dmiArray[0][1] as! CGFloat) * squareH1)
        for i in 0 ..< count  {
            let dmi2value = dmiArray[i][1] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, startpointy - squareH1 * dmi2value )
        }
        self.setColor(83, g: 170 , b: 210 , a: 1).set()
        CGContextStrokePath(ctx)
        //dmi3
        CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - (dmiArray[0][2] as! CGFloat) * squareH1)
        for i in 0 ..< count  {
            let dmi3value = dmiArray[i][2] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, startpointy - squareH1 * dmi3value)
        }
        self.setColor(218, g: 198 , b: 214 , a: 1).set()
        CGContextStrokePath(ctx)
        //dmi4
        CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - (dmiArray[0][3] as! CGFloat) * squareH1)
        for i in 0 ..< count  {
            let dmi4value = dmiArray[i][3] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, startpointy - squareH1 * dmi4value )
        }
        self.setColor(245, g: 73 , b: 108 , a: 1).set()
        CGContextStrokePath(ctx)
}
    
 
    
    //绘制BRAR
    func setBRAR() {
        self.drawTwoLine(brarArray)
}

    
    //绘制VR
    func setVR() {
        self.drawTwoLine(vrArray)
}
    
    
    
    //绘制TRIX
    func setTRIX() {
        self.drawTwoLine(trixArray)
}
    
   
    //绘制EMV
    func setEMV() {
        self.drawTwoLine(emvArray)
}
    
    
    
    //绘制WR
    func setWR() {
        self.drawTwoLine(wrArray)
}
    
   
    
    //绘制CCI
    func setCCI() {
       
}
    
    
    
    //绘制PSY
    func setPSY() {
        self.drawTwoLine(psyArray)
}
    
    
    
    //绘制DPO
    func setDPO() {
        self.drawTwoLine(dpoArray)
}
    
    
    
    
    //绘制BOLL
    func setBOLL() {
       
}
    
    
    
    //绘制ASI
    func setASI() {
        self.drawTwoLine(asiArray)
}
    
    
    
    //绘制SAR
    func setSAR() {
        
}
    
    

    // MARK: 触摸事件
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        print("Touch moves")
        
    if isShiZiXianShown == true {
            let touch = (touches as NSSet).anyObject()!
            let current = touch.locationInView(self)
    
        if( style ==  .PHChartStyleFenShiTu ) {
            
            var xvalue = (current.x - 5)/(VIEW_SIZE.width - 10) * 240
            if ( xvalue < 0) {
                xvalue = 0
            }
            else if ( Int(xvalue) >  fenShiDaZhe.count - 1)
            {
                xvalue =  CGFloat(fenShiDaZhe.count - 1)
            }
            let data = fenShiDaZhe[Int(xvalue)]
            
            shiZiLayer.xValue = current.x
            shiZiLayer.yValue = data as! CGFloat
            shiZiLayer.setNeedsDisplay()
        }
        else
        {
            var xvalue = (current.x - 5)/(VIEW_SIZE.width - 10) * 80
            if ( xvalue < 0) {
                xvalue = 0
            }
            else if (Int(xvalue) > laZhuTuTransArray.count - 1)
            {
                xvalue =  CGFloat(laZhuTuTransArray.count - 1)
            }
            let data = laZhuTuTransArray[Int(xvalue)][3]
            
            shiZiLayer.xValue = current.x
            shiZiLayer.yValue = data as! CGFloat
            shiZiLayer.setNeedsDisplay()
        }
    }
}
    

    
    
    
// MARK: utilities
    
    func setColor(r:CGFloat , g:CGFloat , b:CGFloat , a:Float) -> UIColor {
        
        return  UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: r)
}
    
    
    func drawTwoLine(array:NSArray) {
        let lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324
        let startpointy = VIEW_SIZE.height - padding
        
        let count  = array.count
        let ctx =  UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(ctx, 1)
        CGContextSetLineJoin(ctx, .Round)
        //line1
        CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - (array[0][0] as! CGFloat) * squareH1)
        
        for i in 0 ..< count {
            let line1value = array[i][0] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, startpointy - squareH1 * line1value )
        }
        
        self.setColor(250, g: 202 , b: 65 , a: 1).set()
        CGContextStrokePath(ctx)
        //line2
        CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - (array[0][1] as! CGFloat) * squareH1)
        
        for i in 0 ..< count {
            let line2value = array[i][1] as! CGFloat
            CGContextAddLineToPoint(ctx, padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, startpointy - squareH1 * line2value )
        }
        
        self.setColor(83, g: 170 , b: 210 , a: 1).set()
        CGContextStrokePath(ctx)
}
    
    
    func getAbosoluteValue(inputvalue:CGFloat) -> CGFloat {
        
        if(inputvalue < 0) {
            
             return -inputvalue;
        }
        return inputvalue;
}
    
  
    
    
    func getLineArray(array:NSArray) -> NSArray {
        var  _MAX_NUM = array[0][0] as! CGFloat
        var  _MIN_NUM = array[0][0] as! CGFloat
        
        for element in array {
            let line1value = element[0] as! CGFloat
            let line2value = element[1] as! CGFloat
            
            if (_MAX_NUM < line1value ){ _MAX_NUM = line1value }
            if (_MAX_NUM < line2value ){ _MAX_NUM = line2value }
            
            if (_MIN_NUM > line1value ){ _MIN_NUM = line1value }
            if (_MIN_NUM > line2value ){ _MIN_NUM = line2value }
            if (element.count == 3) {
                let line3value = element[2] as! CGFloat
                if (_MAX_NUM < line3value ){ _MAX_NUM = line3value }
                if (_MIN_NUM > line3value ){ _MIN_NUM = line3value }
                if (element.count == 4) {
                    let line4value = element[3] as! CGFloat
                    if (_MAX_NUM < line4value ){ _MAX_NUM = line4value }
                    if (_MIN_NUM > line4value ){ _MIN_NUM = line4value }
                }
            }
        }
        let delta = _MAX_NUM - _MIN_NUM;
        let temptarra = NSMutableArray()
        for element in array {
            let temptarray = NSMutableArray()
            let vr1newvalue = (element[0] as! CGFloat - _MIN_NUM) / delta
            let vr2newvalue = (element[1] as! CGFloat - _MIN_NUM) / delta
            temptarray.addObject(vr1newvalue)
            temptarray.addObject(vr2newvalue)
            
            if (element.count == 3) {
                let vr3newvalue = (element[2] as! CGFloat - _MIN_NUM) / delta
                temptarray.addObject(vr3newvalue)
                if (element.count == 4) {
                    let vr4newvalue = (element[4] as! CGFloat - _MIN_NUM) / delta
                    temptarray.addObject(vr4newvalue)
                }
            }
            temptarra.addObject(temptarray)
        }
        return temptarra;
}
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}
