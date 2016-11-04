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
    case phChartStyleFenShiTu = 1
    case phChartStyleLaZhuTu
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
    case phLaZhuTuSubstyleVOL = 1
    case phLaZhuTuSubstyleMACD
    case phLaZhuTuSubstyleKDJ
    case phLaZhuTuSubstyleRSI
    case phLaZhuTuSubstyleBIAS
    case phLaZhuTuSubstyleDMA
    case phLaZhuTuSubstyleOBV
    case phLaZhuTuSubstyleROC
    case phLaZhuTuSubstyleMTM
    case phLaZhuTuSubstyleCR
    case phLaZhuTuSubstyleDMI
    case phLaZhuTuSubstyleBRAR
    case phLaZhuTuSubstyleVR
    case phLaZhuTuSubstyleTRIX
    case phLaZhuTuSubstyleEMV
    case phLaZhuTuSubstyleWR
    case phLaZhuTuSubstyleCCI
    case phLaZhuTuSubstylePSY
    case phLaZhuTuSubstyleDPO
    case phLaZhuTuSubstyleBOLL
    case phLaZhuTuSubstyleASI
    case phLaZhuTuSubstyleSAR
}



class GuPiaoView: UIView {
    
// MARK: 样式设置
    
    /// 图表样式
    var style:PHChartstyle
    /// 蜡烛图子视图属性
    var subStyle:PHLaZhuTuSubstyle = .phLaZhuTuSubstyleVOL
    
// MARK: 宏变量
    
    var VIEW_SIZE:CGSize = CGSize.zero
    var padding:CGFloat = 5
    var buttompadding:CGFloat = 20
    var squareH:CGFloat = 0
    var squareW:CGFloat = 0
    var squareH1:CGFloat = 0

// MARK: 分时图属性
    
    var daZhexData = Array<AnyObject>()
    var xiaoZhexData = Array<AnyObject>()
    var zhuData = Array<AnyObject>()
    
    var fenShiVol = Array<Array<AnyObject>>()
    var fenShiDaZhe = Array<AnyObject>()
    var fenShiXiaoZhe = Array<AnyObject>()
    
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
    var volArray = Array<Array<AnyObject>>()
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
    var  shiZiLayer = ShiZiLayer(x: 0, y: 0 ,layer:0)!
    
// MARK: 初始化方法
    
    init?(withframe frame:CGRect, chartStyle chartstyle: PHChartstyle ) {
        
        style = chartstyle
        shiZiLayer.isHidden = true;
        super.init(frame: frame)
}
 
    
// MARK: 重绘方法
   
    /**
     重绘方法
     
     - parameter rect: 尺寸的大小
     */
    override func draw(_ rect: CGRect) {
        if(style == .phChartStyleFenShiTu){
            
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
            case .phLaZhuTuSubstyleVOL:
                self.setVol2()
            case  .phLaZhuTuSubstyleMACD:
                self.setMACD()
            case .phLaZhuTuSubstyleKDJ:
                self.setKDJ()
            case .phLaZhuTuSubstyleRSI:
                self.setRSI()
            case .phLaZhuTuSubstyleBIAS:
                self.setBIAS()
            case .phLaZhuTuSubstyleDMA:
                self.setDMA()
            case .phLaZhuTuSubstyleOBV:
                self.setOBV()
            case .phLaZhuTuSubstyleROC:
                self.setROC()
            case .phLaZhuTuSubstyleMTM:
                self.setMTM()
            case .phLaZhuTuSubstyleCR:
                self.setCR()
            case .phLaZhuTuSubstyleDMI:
                self.setDMI()
            case .phLaZhuTuSubstyleBRAR:
                self.setBRAR()
            case .phLaZhuTuSubstyleVR:
                self.setVR()
            case .phLaZhuTuSubstyleTRIX:
                self.setTRIX()
            case .phLaZhuTuSubstyleEMV:
                self.setEMV()
            case .phLaZhuTuSubstyleWR:
                self.setWR()
            case .phLaZhuTuSubstyleCCI:
                self.setCCI()
            case .phLaZhuTuSubstylePSY:
                self.setPSY()
            case .phLaZhuTuSubstyleDPO:
                self.setDPO()
            case .phLaZhuTuSubstyleBOLL:
                self.setBOLL()
            case .phLaZhuTuSubstyleASI:
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
        zuigaoL.font = UIFont.systemFont(ofSize: 8.0)
        zuigaoL.textColor = color
        zuidiL.font = UIFont.systemFont(ofSize: 8.0)
        zuidiL.textColor = color
        
        jyzl.font = UIFont.systemFont(ofSize: 8.0)
        jyzl.textColor = color
        //right
        zuigaoB.textAlignment = NSTextAlignment.right
        zuigaoB.font = UIFont.systemFont(ofSize: 8.0)
        zuigaoB.textColor = color
        zuidiB.textAlignment = NSTextAlignment.right;
        zuidiB.font = UIFont.systemFont(ofSize: 8.0)
        zuidiB.textColor = color
        //shijian
        shijian1.text = "09.30"
        shijian1.textAlignment = NSTextAlignment.left;
        shijian1.font = UIFont.systemFont(ofSize: 7.0)
        shijian1.textColor = color
        
        shijian2.text = "10.30"
        shijian2.textAlignment = NSTextAlignment.center
        shijian2.font = UIFont.systemFont(ofSize: 7.0)
        shijian2.textColor = color
        
        shijian3.text = "11.30/13:00"
        shijian3.textAlignment = NSTextAlignment.center
        shijian3.font = UIFont.systemFont(ofSize: 7.0)
        shijian3.textColor = color
        
        shijian4.text = "14:00"
        shijian4.textAlignment = NSTextAlignment.center
        shijian4.font = UIFont.systemFont(ofSize: 7.0)
        shijian4.textColor = color
        
        shijian5.text = "15:00"
        shijian5.textAlignment = NSTextAlignment.right
        shijian5.font = UIFont.systemFont(ofSize: 7.0)
        shijian5.textColor = color
        
        
        if (isShiZiXianShown) {
        shiZiLayer.isHidden = true
        shiZiLayer = ShiZiLayer(x: 0, y: 0, layer: 0)!;
        shiZiLayer.frame = CGRect(x: 0, y: 0, width: VIEW_SIZE.width, height: VIEW_SIZE.height)
        shiZiLayer.shiZiXian = .phShiZiStyleFenShiTu
    }
   
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
    func setZuoShouAndZongLiang(_ zuoshouv:CGFloat,zongliang:NSString) {
        zuoShou = zuoshouv
        jyzl.text = zongliang as String
}
    
    /**
     设置分时图数组
     
     - parameter dazhe:   大折线数组
     - parameter xiaozhe: 小折线数组
     */
    func setFenShiDaZheAndXiaoZheArray(_ dazhe:NSArray,xiaozhe:NSArray, zhutu:NSArray) {
        daZhexData = dazhe as Array<AnyObject>
        xiaoZhexData = xiaozhe as Array<AnyObject>
        zhuData = zhutu as Array<AnyObject>
        transferFenShiData()
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
        var dazhe = Array<AnyObject>()
        for element in daZhexData  {
            let temptfloat = (element as! CGFloat - low)/(2 * maxOffSetValue);
            dazhe.append(temptfloat as AnyObject)
        }
        fenShiDaZhe = dazhe
        // set fenshixiaozhexian array
        var xiaozhe = Array<AnyObject>()
        for element in  xiaoZhexData {
            let temptfloat = (element as! CGFloat - low)/(2 * maxOffSetValue);
            xiaozhe.append(temptfloat as AnyObject)
        }
        fenShiXiaoZhe = xiaozhe
        //转换分时图成交量数据
        
        
        var _max_NUM = zhuData[0][1] as! CGFloat
        
        for  element in  zhuData {
            let Element = element as!NSArray
            let number = Element[1] as! CGFloat
            if (_max_NUM < number){ _max_NUM = number }
            }
        
        
        var temptarra = Array<Array<AnyObject>>()
        
        for element in  zhuData  {
            var tempt = Array<AnyObject>()
            let temptNumber1 = element[0] as! CGFloat
            let temptNumber2 = element[1] as! CGFloat / _max_NUM
            tempt.append(temptNumber1 as AnyObject)
            tempt.append(temptNumber2 as AnyObject)
            temptarra.append(tempt)
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
    func setLZTarray(_ lztarray:NSArray) {
        
        VIEW_SIZE = self.bounds.size
        squareH = (VIEW_SIZE.height - 2 * padding - buttompadding) / 6
        squareW = (VIEW_SIZE.width - 2 * padding) / 4
        squareH1 =  (VIEW_SIZE.height - 3 * padding - buttompadding) / 5
        
        shiZiLayer.isHidden = true
        shiZiLayer.shiZiXian = .phShiZiStyleLaZhuTu
        self.layer.addSublayer(shiZiLayer)
        
        
        let laztArray = lztarray as![NSArray]
        var _max_NUM =  laztArray[0][0] as! CGFloat
        var _min_NUM =  laztArray[0][0] as! CGFloat
        
        for element in  lztarray {
            for  i in 0 ..< 7 {
               let Element=element as! NSArray
               let num = Element[i] as! CGFloat
                if (_max_NUM < num){ _max_NUM = num }
                if (_min_NUM > num){ _min_NUM = num }
            }
        }
        _max_NUM -= _min_NUM
        
        let temptarra = NSMutableArray()
        for element in  lztarray {
            let tempt = NSMutableArray()
            for  i in 0 ..< 7 {
               let Element=element as! NSArray
               let temptNumber = (Element[i] as! CGFloat - _min_NUM) / _max_NUM
                tempt.add(temptNumber)
            }
            temptarra.add(tempt)
       }
        laZhuTuTransArray = temptarra
  }
    
    
    /**
     蜡烛图成交量
     
     - parameter volarray: 成交量
     */
    func setVol(_ volarray:NSArray) {
        
        var temptarra = Array<Array<AnyObject>>()
        let volArrayT = volarray as Array<AnyObject>
        var _max_NUM = volArrayT[0][1] as! CGFloat
            for element in  volarray {
            let Element = element as! NSArray
            let value1 = Element[0] as! CGFloat
            let value2 = Element[1] as! CGFloat
                if (_max_NUM < value1){ _max_NUM = value1 }
                if (_max_NUM < value2){ _max_NUM = value2 }
        }
    
        for element in  volArrayT {
            
            
            var tempt = Array<AnyObject>()
            let temptNumber1 = element[0] as! CGFloat
            let temptNumber2 = element[1] as! CGFloat / _max_NUM
            tempt.append(temptNumber1 as AnyObject)
            tempt.append(temptNumber2 as AnyObject)
            temptarra.append(tempt)
        }
        volArray = temptarra
}
    
    /**
     蜡烛图MACD
     
     - parameter macdarray: MACD
     */
    func setMACD(_ macdarray:NSArray) {
        var _max_NUM:CGFloat = 0
        for element in macdarray {
            let Element = element as! NSArray
            let ema12 = Element[0] as! CGFloat
            let ema26 = Element[1] as! CGFloat
            let dif = ema12 - ema26
            
            if (_max_NUM < self.getAbosoluteValue(ema12)){ _max_NUM = self.getAbosoluteValue(ema12)}
            if (_max_NUM < self.getAbosoluteValue(ema26)){ _max_NUM = self.getAbosoluteValue(ema26)}
            if (_max_NUM < self.getAbosoluteValue(dif)){ _max_NUM = self.getAbosoluteValue(dif)}
        }
        let temptarra = NSMutableArray()
        for element in macdarray {
            let temptarray = NSMutableArray()
            let Element = element as! NSArray
            let ema12 = (Element[0] as! CGFloat) / (_max_NUM * 1.1)
            let ema26 = (Element[1] as! CGFloat) / (_max_NUM * 1.1)
            let delta = (ema12 - ema26) * 2
            temptarray.add(ema12)
            temptarray.add(ema26)
            temptarray.add(delta)
            temptarra.add(temptarray)
        }
         macdArray = temptarra
}

    
    /**
     蜡烛图KDJ
     
     - parameter kdjarray: KDJ
     */
    func setKDJ(_ kdjarray:NSArray) {
        
        kdjArray = self.getLineArray(kdjarray)
}
    
    /**
     蜡烛图RSI
     
     - parameter rsiarray: RSI
     */
    func setRSI(_ rsiarray:NSArray) {
        
        rsiArray = self.getLineArray(rsiarray)
}
    
    /**
     蜡烛图BIAS
     
     - parameter biasarray: BIAS
     */
    func setBIAS(_ biasarray:NSArray) {
        
        biasArray = self.getLineArray(biasarray)
}
    
    
    /**
     蜡烛图DMA
     
     - parameter dmaarray: DMA
     */
    func setDMA(_ dmaarray:NSArray) {
        
        dmaArray = self.getLineArray(dmaarray)
}
    
    
    /**
     蜡烛图OBV
     
     - parameter obvarray: OBV
     */
    func setOBV(_ obvarray:NSArray) {
        
        obvArray = self.getLineArray(obvarray)
}
    
    
    
    /**
     蜡烛图ROC
     
     - parameter rocarray: ROC
     */
    func setROC(_ rocarray:NSArray) {
        
        rocArray = self.getLineArray(rocarray)
}
    
    
    
    /**
     蜡烛图MTM
     
     - parameter mtmarray: MTM
     */
    func setMTM(_ mtmarray:NSArray) {
        
        let mtmaarrayT = mtmarray as![NSArray]
        var  _MAX_NUM = mtmaarrayT[0][0] as! CGFloat
        var  _MIN_NUM = mtmaarrayT[0][0] as! CGFloat
        
        for element in mtmarray {
            let Element = element as! NSArray
            let MTM1value = Element[0] as! CGFloat
            let MTM2value = Element[1] as! CGFloat
            if (_MAX_NUM < MTM1value ){ _MAX_NUM = MTM1value }
            if (_MAX_NUM < MTM2value ){ _MAX_NUM = MTM2value }
            if (_MIN_NUM > MTM1value ){ _MIN_NUM = MTM1value }
            if (_MIN_NUM > MTM2value ){ _MIN_NUM = MTM2value }
       }
        let  delta = _MAX_NUM - _MIN_NUM
        let temptarra = NSMutableArray()
        for element in mtmarray {
            let  temptarray = NSMutableArray()
            let Element = element as! NSArray
            let mtm1newvalue = (Element[0] as! CGFloat - _MIN_NUM) / delta
            let mtm2newvalue = (Element[1] as! CGFloat - _MIN_NUM) / delta
            temptarray.add(mtm1newvalue)
            temptarray.add(mtm2newvalue)
            temptarra.add(temptarray)
        }
        mtmArray = temptarra
}
    
    
    /**
     蜡烛图CRA
     
     - parameter crarray: CRA
     */
    func setCR(_ crarray:NSArray) {
        
        crArray = self.getLineArray(crarray)
    }
    
    
    /**
     蜡烛图DMI
     
     - parameter dmiarray: DMI
     */
    func setDMI(_ dmiarray:NSArray) {
        
        dmiArray = self.getLineArray(dmiarray)
    }
    
    /**
     蜡烛图BRAR
     
     - parameter brararray: BRAR
     */
    func setBRAR(_ brararray:NSArray) {
        
        let brararrayT = brararray as![NSArray]
        var _MAX_NUM = brararrayT[0][0] as! CGFloat
        var _MIN_NUM = brararrayT[0][0] as! CGFloat
        
        for element in brararray {
            let Element = element as!NSArray
            let brar1value = Element[0] as! CGFloat
            let brar2value = Element[1] as! CGFloat
            if (_MAX_NUM < brar1value ){ _MAX_NUM = brar1value }
            if (_MAX_NUM < brar2value ){ _MAX_NUM = brar2value }
            if (_MIN_NUM > brar1value ){ _MIN_NUM = brar1value }
            if (_MIN_NUM > brar2value ){ _MIN_NUM = brar2value }
        }
        let delta = _MAX_NUM - _MIN_NUM
        let temptarra = NSMutableArray()
        for element in brararray {
            let temptarray = NSMutableArray()
            let Element = element as!NSArray
            let brar1newvalue = (Element[0] as! CGFloat - _MIN_NUM) / delta
            let brar2newvalue = (Element[1] as! CGFloat - _MIN_NUM) / delta
            temptarray.add(brar1newvalue)
            temptarray.add(brar2newvalue)
            temptarra.add(temptarray)
        }
        brarArray = temptarra
}
    
    
    /**
     蜡烛图VR
     
     - parameter vrarray: VR
     */
    func setVR(_ vrarray:NSArray) {
        
        vrArray = self.getLineArray(vrarray)
}
    
    
    /**
     蜡烛图TRIX
     
     - parameter trixarray: TRIX
     */
    func setTRIX(_ trixarray:NSArray) {
        
        trixArray = self.getLineArray(trixarray)
}
    
    
    /**
     蜡烛图EMV
     
     - parameter emvarray: EMV
     */
    func setEMV(_ emvarray:NSArray) {
        
        emvArray = self.getLineArray(emvarray)
}
    
    
    
    /**
     蜡烛图WR
     
     - parameter wrarray: WR
     */
    func setWR(_ wrarray:NSArray) {
        
        wrArray = self.getLineArray(wrarray)
}
    
    
    
    /**
     蜡烛图PSY
     
     - parameter psyarray: PSY
     */
    func setPSY(_ psyarray:NSArray) {
        
        psyArray = self.getLineArray(psyarray)
}
    
    
    /**
     DPO
     
     - parameter dpoarray: DPO
     */
    func setDPO(_ dpoarray:NSArray) {
        
        dpoArray = self.getLineArray(dpoarray)
}
    
    /**
     蜡烛图ASI
     
     - parameter asiarray: ASI
     */
    func setASI(_ asiarray:NSArray) {
        
        asiArray = self.getLineArray(asiarray)
}
    
    
// MARK: 分时图绘图
    
    func setFangKuang() {
        VIEW_SIZE = self.bounds.size
        squareW = (VIEW_SIZE.width - 2 * padding) / 4
        squareH = (VIEW_SIZE.height - 2 * padding - buttompadding) / 6
        
        let  ctxSK =  UIGraphicsGetCurrentContext()
        ctxSK?.move(to: CGPoint(x: padding, y: padding));
        ctxSK?.addLine(to: CGPoint(x: VIEW_SIZE.width - padding, y: padding))
        ctxSK?.addLine(to: CGPoint(x: VIEW_SIZE.width - padding, y: padding + 4*squareH))
        ctxSK?.addLine(to: CGPoint(x: padding, y: padding + 4*squareH));
        ctxSK?.closePath()
        ctxSK?.setLineWidth(1)
        self.setColor(239, g: 243, b: 244, a: 1).set()
        ctxSK?.strokePath()
        
        let  ctxxK =  UIGraphicsGetCurrentContext();
        ctxxK?.move(to: CGPoint(x: padding, y: 2*padding + 4*squareH))
        ctxxK?.addLine(to: CGPoint(x: VIEW_SIZE.width - padding, y: 2 * padding + 4*squareH))
        ctxxK?.addLine(to: CGPoint(x: VIEW_SIZE.width - padding, y: VIEW_SIZE.height - buttompadding));
        ctxxK?.addLine(to: CGPoint(x: padding, y: VIEW_SIZE.height - buttompadding))
        ctxxK?.closePath()
        ctxxK?.setLineWidth(1)
        self.setColor(239, g: 243, b: 244, a: 1).set()
        ctxxK?.strokePath()
        //1coloum
        let ctxc11 =  UIGraphicsGetCurrentContext()
        ctxc11?.move(to: CGPoint(x: padding + squareW, y: padding))
        ctxc11?.addLine(to: CGPoint(x: padding + squareW, y: padding + 4*squareH))
        ctxc11?.setLineWidth(1)
        self.setColor(239, g: 243, b: 244, a: 1).set()
        ctxc11?.strokePath()
        
        let  ctxc12 =  UIGraphicsGetCurrentContext()
        ctxc12?.move(to: CGPoint(x: padding + 2*squareW, y: padding))
        ctxc12?.addLine(to: CGPoint(x: padding + 2*squareW, y: padding + 4*squareH))
        ctxc12?.setLineWidth(1)
        self.setColor(239, g: 243, b: 244, a: 1).set()
        ctxc12?.strokePath()
        
        let  ctxc13 =  UIGraphicsGetCurrentContext()
        ctxc13?.move(to: CGPoint(x: padding + 3*squareW, y: padding))
        ctxc13?.addLine(to: CGPoint(x: padding + 3*squareW, y: padding + 4*squareH))
        ctxc13?.setLineWidth(1)
        self.setColor(239, g: 243, b: 244, a: 1).set()
        ctxc13?.strokePath();
        //1row
        let  ctxr11 =  UIGraphicsGetCurrentContext();
        ctxr11?.move(to: CGPoint(x: padding, y: padding + squareH * 1))
        ctxr11?.addLine(to: CGPoint(x: VIEW_SIZE.width - padding, y: padding + squareH * 1))
        ctxr11?.setLineWidth(1)
        self.setColor(239, g: 243, b: 244, a: 1).set()
        ctxr11?.strokePath()
        
        let  ctxr13 =  UIGraphicsGetCurrentContext()
        ctxr13?.move(to: CGPoint(x: padding, y: padding + squareH * 3))
        ctxr13?.addLine(to: CGPoint(x: VIEW_SIZE.width - padding, y: padding + squareH * 3))
        ctxr13?.setLineWidth(1)
        self.setColor(239, g: 243, b: 244, a: 1).set()
        ctxr13?.strokePath()
        //2colum
        let  ctxc21 =  UIGraphicsGetCurrentContext()
        ctxc21?.move(to: CGPoint(x: padding + squareW, y: 2 * padding + 4 * squareH))
        ctxc21?.addLine(to: CGPoint(x: padding + squareW, y: VIEW_SIZE.height - buttompadding))
        ctxc21?.setLineWidth(1)
        self.setColor(239, g: 243, b: 244, a: 1).set()
        ctxc21?.strokePath()
        
        let  ctxc22 =  UIGraphicsGetCurrentContext()
        ctxc22?.move(to: CGPoint(x: padding + 2*squareW, y: 2 * padding + 4 * squareH))
        ctxc22?.addLine(to: CGPoint(x: padding + 2*squareW, y: VIEW_SIZE.height - buttompadding))
        ctxc22?.setLineWidth(1)
        self.setColor(239, g: 243, b: 244, a: 1).set()
        ctxc22?.strokePath()
        
        let ctxc23 =  UIGraphicsGetCurrentContext()
        ctxc23?.move(to: CGPoint(x: padding + 3*squareW, y: 2 * padding + 4 * squareH))
        ctxc23?.addLine(to: CGPoint(x: padding + 3*squareW, y: VIEW_SIZE.height - buttompadding))
        ctxc23?.setLineWidth(1)
        self.setColor(239, g: 243, b: 244, a: 1).set()
        ctxc23?.strokePath()
        //2row
        let  ctxr21 =  UIGraphicsGetCurrentContext()
        ctxr21?.move(to: CGPoint(x: padding, y: 2 * padding + squareH * 5))
        ctxr21?.addLine(to: CGPoint(x: VIEW_SIZE.width - padding, y: 2 * padding + squareH * 5))
        ctxr21?.setLineWidth(1)
        self.setColor(239, g: 243, b: 244, a: 1).set()
        ctxr21?.strokePath()
}
 
    
    
    
// 标签和时间
    
     func setBiaoQian() {
        zuigaoL.frame = CGRect(x: padding + 1, y: padding + 1, width: 50, height: 15)
        zuidiL.frame =  CGRect(x: padding + 1, y: padding + 4 * squareH - 15, width: 50, height: 15)
        jyzl.frame =  CGRect(x: padding + 1, y: 2 * padding + 4 * squareH , width: 50, height: 15)
        //right
        zuigaoB.frame =  CGRect( x: VIEW_SIZE.width - padding - 51, y: padding + 1, width: 50, height: 15)
        zuidiB.frame = CGRect(x: VIEW_SIZE.width - padding - 51, y: padding + 4 * squareH - 15, width: 50, height: 15)
        //shijian
        shijian1.frame = CGRect( x: padding , y: VIEW_SIZE.height - 20, width: 50, height: 15)
        shijian2.frame = CGRect( x: padding + squareW - 25 , y: VIEW_SIZE.height - 20, width: 50, height: 15)
        shijian3.frame = CGRect( x: padding + 2 * squareW - 25 , y: VIEW_SIZE.height - 20, width: 50, height: 15)
        shijian4.frame = CGRect( x: padding + 3 * squareW - 25 , y: VIEW_SIZE.height - 20, width: 50, height: 15)
        shijian5.frame = CGRect( x: VIEW_SIZE.width - 56 , y: VIEW_SIZE.height - 20, width: 50, height: 15)
    
            if (self.isShiZiXianShown == true) {
            shiZiLayer.removeFromSuperlayer()
            shiZiLayer = ShiZiLayer(x: 0, y: 0, layer: 0)!
            self.layer .addSublayer(shiZiLayer)
            shiZiLayer.frame = CGRect(x: 0, y: 0, width: VIEW_SIZE.width , height: VIEW_SIZE.height )
            shiZiLayer.setNeedsDisplay()
    }
}
    
    
    
    func setFenShiTu() {

        let  dazhexianY =  UIGraphicsGetCurrentContext()
        dazhexianY?.move(to: CGPoint(x: padding, y: padding + 4 * squareH))
        let count1 =  fenShiDaZhe.count
        for  i in 0 ..< count1 {
            let percentage = fenShiDaZhe[i] as! CGFloat
            let x = padding +  squareW / 60 * CGFloat(i)
            let y = padding + 4 * squareH * (1 - percentage)
            dazhexianY?.addLine(to: CGPoint(x: x, y: y))
        }
        let lastPointX = padding + CGFloat(count1) * squareW / 60
        dazhexianY?.addLine(to: CGPoint(x: lastPointX, y: padding + 4 * squareH))
        self.setColor(229, g: 241, b: 250, a: 1).set()
        dazhexianY?.setLineJoin(.round)
        dazhexianY?.closePath()
        dazhexianY?.fillPath()
        //dazhexian
        let  dazhexian =  UIGraphicsGetCurrentContext()
        for i in 0 ..< count1 {
           let percentage = fenShiDaZhe[i] as! CGFloat
            let x = padding +  squareW / 60 * CGFloat(i)
            let y = padding + 4 * squareH * (1 - percentage)
            
            if (i == 0) {
                dazhexian?.move(to: CGPoint(x: x, y: y))
            }
            else
            {
                dazhexian?.addLine(to: CGPoint(x: x, y: y))
            }
        }
        self.setColor(152, g: 168, b: 191, a: 1).set()
        dazhexian?.setLineJoin(.round)
        dazhexian?.strokePath()
        //xiaozhexian
        let xiaozhexian =  UIGraphicsGetCurrentContext()
        let count2 = fenShiXiaoZhe.count
        for i in 0 ..< count2  {
            let percentage = fenShiXiaoZhe[i] as! CGFloat
            let x = padding +  squareW / 60 * CGFloat(i)
            let y = padding + 4 * squareH * (1 - percentage)
            if (i == 0) {
                xiaozhexian?.move(to: CGPoint(x: x, y: y))
            }
            else
            {
                xiaozhexian?.addLine(to: CGPoint(x: x, y: y))
            }
        }
        self.setColor(252, g: 197, b: 152, a: 1).set()
        xiaozhexian?.setLineJoin(.round)
        xiaozhexian?.strokePath();
        //虚线
        let lengths:[CGFloat] = [4,4]
        let ctxr12 =  UIGraphicsGetCurrentContext()
        ctxr12?.move(to: CGPoint(x: padding, y: padding + squareH * 2))
        ctxr12?.addLine(to: CGPoint(x: VIEW_SIZE.width - padding, y: padding + squareH * 2))

        ctxr12?.setLineDash(phase: 5.0, lengths: lengths)
        ctxr12?.setLineWidth(1)
        self.setColor(143, g: 243, b: 249, a: 1).set()
        ctxr12?.strokePath()
}
    
    
//柱状图
    func setVol1() {
        let count  = fenShiVol.count
        for  i in 0 ..< count {
            let arra = fenShiVol[i];
            let redorblue = arra[0] as! CGFloat
            let percentage = arra[1] as! CGFloat

            self.zhutu1Index(i, redOrBlue: (redorblue != 0), percentage: CGFloat(Float(percentage)))
         }
    }
    
    
    
    func zhutu1Index(_ index:Int , redOrBlue:Bool, percentage:CGFloat) {
    
        let startPointX = padding  + squareW / 60 * CGFloat(index)
        let startPointY = VIEW_SIZE.height  - buttompadding
        let endPointX = padding  + squareW / 60 * CGFloat(index)
        let endPointY = VIEW_SIZE.height  - buttompadding -  2 * squareH  * percentage
        
        let ctx =  UIGraphicsGetCurrentContext()
        ctx?.move(to: CGPoint(x: startPointX, y: startPointY))
        ctx?.addLine(to: CGPoint(x: endPointX, y: endPointY))
        redOrBlue ?  self.setColor(236, g: 86 , b: 85 , a: 1).set() : self.setColor(30, g: 170 , b: 94 , a: 1).set()
        ctx?.strokePath()
}
   
    
    
// MARK: 绘制蜡烛图
    
    func setFangKuang2() {
        VIEW_SIZE = self.bounds.size
        squareW = (VIEW_SIZE.width - 2 * padding) / 4
        squareH1 = (VIEW_SIZE.height - 3 * padding - buttompadding) / 5
        let  ctxSK =  UIGraphicsGetCurrentContext()
        ctxSK?.move(to: CGPoint(x: padding, y: padding))
        ctxSK?.addLine(to: CGPoint(x: VIEW_SIZE.width - padding, y: padding))
        ctxSK?.addLine(to: CGPoint(x: VIEW_SIZE.width - padding, y: padding + 4*squareH1))
        ctxSK?.addLine(to: CGPoint(x: padding, y: padding + 4*squareH1))
        ctxSK?.closePath()
        ctxSK?.setLineWidth(1)
        self.setColor(239, g: 243 , b: 244 , a: 1).set()
        ctxSK?.strokePath()
        
       let ctxxK =  UIGraphicsGetCurrentContext()
        ctxxK?.move(to: CGPoint(x: padding, y: 2*padding + buttompadding + 4*squareH1))
        ctxxK?.addLine(to: CGPoint(x: VIEW_SIZE.width - padding, y: 2*padding + buttompadding + 4*squareH1))
        ctxxK?.addLine(to: CGPoint(x: VIEW_SIZE.width - padding, y: VIEW_SIZE.height - padding))
        ctxxK?.addLine(to: CGPoint(x: padding, y: VIEW_SIZE.height - padding))
        ctxxK?.closePath()
        ctxxK?.setLineWidth(1)
        self.setColor(239, g: 243 , b: 244 , a: 1).set()
        ctxxK?.strokePath()
        
        let lengths:[CGFloat] = [2,2]
        let ctxr11 =  UIGraphicsGetCurrentContext()
        ctxr11?.move(to: CGPoint(x: padding, y: padding + squareH1 * 1))
        ctxr11?.addLine(to: CGPoint(x: VIEW_SIZE.width - padding, y: padding + squareH1 * 1))
        ctxr11?.setLineDash(phase: 5.0, lengths: lengths)
        ctxr11?.setLineWidth(1)
        self.setColor(239, g: 243 , b: 244 , a: 1).set()

        ctxr11?.strokePath()
    
        let ctxr12 =  UIGraphicsGetCurrentContext()
        ctxr12?.move(to: CGPoint(x: padding, y: padding + squareH1 * 2))
        ctxr12?.addLine(to: CGPoint(x: VIEW_SIZE.width - padding, y: padding + squareH1 * 2))
        ctxr12?.setLineWidth(1)
        self.setColor(239, g: 243 , b: 244 , a: 1).set()
        ctxr12?.strokePath()
        
        let ctxr13 =  UIGraphicsGetCurrentContext()
        ctxr13?.move(to: CGPoint(x: padding, y: padding + squareH1 * 3))
        ctxr13?.addLine(to: CGPoint(x: VIEW_SIZE.width - padding, y: padding + squareH1 * 3))
        ctxr13?.setLineWidth(1)
        self.setColor(239, g: 243 , b: 244 , a: 1).set()
        ctxr13?.strokePath()
        
        if( isZoomMode == false) {
            //ROW HIDE
            let  ctxrH1 =  UIGraphicsGetCurrentContext()
            ctxrH1?.move(to: CGPoint(x: padding, y: padding + squareH1 / 2 * 1))
            ctxrH1?.addLine(to: CGPoint(x: VIEW_SIZE.width - padding, y: padding + squareH1 / 2 * 1))
            ctxrH1?.setLineWidth(1)
            self.setColor(239, g: 243 , b: 244 , a: 1).set()
            ctxrH1?.strokePath()
            
            let ctxrH2 =  UIGraphicsGetCurrentContext()
            ctxrH2?.move(to: CGPoint(x: padding, y: padding + squareH1 / 2 * 3))
            ctxrH2?.addLine(to: CGPoint(x: VIEW_SIZE.width - padding, y: padding + squareH1 / 2 * 3))
            ctxrH2?.setLineWidth(1)
            self.setColor(239, g: 243 , b: 244 , a: 1).set()
            ctxrH2?.strokePath()
            
            let ctxrH3 =  UIGraphicsGetCurrentContext()
            ctxrH3?.move(to: CGPoint(x: padding, y: padding + squareH1 / 2 * 5))
            ctxrH3?.addLine(to: CGPoint(x: VIEW_SIZE.width - padding, y: padding + squareH1 / 2 * 5))
            ctxrH3?.setLineWidth(1)
            self.setColor(239, g: 243 , b: 244 , a: 1).set()
            ctxrH3?.strokePath()
            
            let ctxrH4 =  UIGraphicsGetCurrentContext()
            ctxrH4?.move(to: CGPoint(x: padding, y: padding + squareH1 / 2 * 7))
            ctxrH4?.addLine(to: CGPoint(x: VIEW_SIZE.width - padding, y: padding + squareH1 / 2 * 7))
            ctxrH4?.setLineWidth(1)
            self.setColor(239, g: 243 , b: 244 , a: 1).set()
            ctxrH4?.strokePath()
            //2row
            let ctxrH5 =  UIGraphicsGetCurrentContext()
            ctxrH5?.move(to: CGPoint(x: padding, y: VIEW_SIZE.height - padding - squareH1 / 2))
            ctxrH5?.addLine(to: CGPoint(x: VIEW_SIZE.width - padding, y: VIEW_SIZE.height - padding - squareH1 / 2))
            ctxrH5?.setLineWidth(1)
            self.setColor(239, g: 243 , b: 244 , a: 1).set()
            ctxrH5?.strokePath()
        }
        if (isShiZiXianShown == true) {
            shiZiLayer.removeFromSuperlayer()
            shiZiLayer = ShiZiLayer(x: 0, y: 0, layer: 0)!
            self.layer .addSublayer(shiZiLayer)
            shiZiLayer.frame = CGRect(x: 0, y: 0, width: VIEW_SIZE.width , height: VIEW_SIZE.height )
            shiZiLayer.shiZiXian = .phShiZiStyleLaZhuTu
            shiZiLayer.frame = CGRect(x: 0, y: 0, width: VIEW_SIZE.width, height: VIEW_SIZE.height)
            shiZiLayer.setNeedsDisplay()
        }
}
    
    
    //绘制蜡烛图和M5 M10 和 M20线
    func setLaZhuTu() {
        VIEW_SIZE = self.bounds.size
        let lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324
        let lazhuCXwidth = lazhuUnitDot * 3
        let count = laZhuTuTransArray.count
        let laZhuTuTransArrayT = laZhuTuTransArray as![NSArray]
        let lengths:[CGFloat] = [1,0]
        let ctx =  UIGraphicsGetCurrentContext()
        ctx?.setLineDash(phase: 5.0, lengths: lengths)
        //蜡烛图
        for  i  in 0 ..< count {
            let high  = laZhuTuTransArrayT[i][0] as! CGFloat
            let low   = laZhuTuTransArrayT[i][1] as! CGFloat
            let open  = laZhuTuTransArrayT[i][2] as! CGFloat
            let close = laZhuTuTransArrayT[i][3] as! CGFloat
            if ( close > open) {
                self.setColor(252, g: 64 , b: 69 , a: 1).set()
            }else
            {
                self.setColor(56, g: 171 , b: 36 , a: 1).set()
            }
            ctx?.move(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: padding + ( 1 - high) * 4 * squareH1))
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: padding + ( 1 - low) * 4 * squareH1))
            ctx?.setLineWidth(lazhuUnitDot)
            ctx?.strokePath()
            
            ctx?.move(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: padding + ( 1 - open) * 4 * squareH1))
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: padding + ( 1 - close) * 4 * squareH1))
            ctx?.setLineWidth(lazhuCXwidth)
            ctx?.strokePath()
        }
        //M5线
        ctx?.setLineWidth(lazhuUnitDot)
        ctx?.setLineJoin(.round)
        
        let m5lineStart = laZhuTuTransArrayT[0][4] as! CGFloat
        let m10lineStart = laZhuTuTransArrayT[0][5] as! CGFloat
        let m20lineStart  = laZhuTuTransArrayT[0][6] as! CGFloat
        
        ctx?.move(to: CGPoint(x: padding + 3 * lazhuUnitDot, y: padding + ( 1 - m5lineStart) * 4 * squareH1))
        for i  in 0 ..< count {
            let m5line = laZhuTuTransArrayT[i][4] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: padding + ( 1 - m5line) * 4 * squareH1))
        }
        self.setColor(67, g: 188 , b: 252 , a: 1).set()
        ctx?.setLineWidth(0.5)
        ctx?.strokePath()
        //M10线
        ctx?.move(to: CGPoint(x: padding + 3 * lazhuUnitDot, y: padding + ( 1 - m10lineStart) * 4 * squareH1))
        for i  in 0 ..< count  {
            let m10line = laZhuTuTransArrayT[i][5] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: padding + ( 1 - m10line) * 4 * squareH1))
        }
        self.setColor(236, g: 194 , b: 81 , a: 1).set()
        ctx?.setLineWidth(0.5)
        ctx?.strokePath()
        //M20线
        ctx?.move(to: CGPoint(x: padding + 3 * lazhuUnitDot, y: padding + ( 1 - m20lineStart) * 4 * squareH1));
        for i  in 0 ..< count {
            let m20line  = laZhuTuTransArrayT[i][6] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: padding + ( 1 - m20line) * 4 * squareH1))
        }
        self.setColor(224, g: 106 , b: 237 , a: 1).set()
        ctx?.setLineWidth(0.5)
        ctx?.strokePath()
}
  
    
    //绘制成交量
    func setVol2() {
        let count  = volArray.count
        for  i in 0 ..< count {
            let volArrayT = volArray
            let redorblue = volArrayT[i][0]as!CGFloat
            let percentage = volArrayT[i][1]as!CGFloat
            self.zhutu2Index(i, redOrBlue: (redorblue == 1) , percentage: percentage)
        }
}
    
    
    
    
    func zhutu2Index(_ index:Int , redOrBlue:Bool, percentage:CGFloat) {
        let lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324
        let lazhuCXwidth = lazhuUnitDot * 3
        
        let startPointX = padding + (3 + 4 * CGFloat(index)) * lazhuUnitDot
        let startPointY = VIEW_SIZE.height - padding
        let endPointX = padding + (3 + 4 * CGFloat(index)) * lazhuUnitDot
        let endPointY = VIEW_SIZE.height  - padding -  squareH1  * percentage
        
        let ctx =  UIGraphicsGetCurrentContext()
        ctx?.move(to: CGPoint(x: startPointX, y: startPointY))
        ctx?.addLine(to: CGPoint(x: endPointX, y: endPointY))
        redOrBlue ?  self.setColor(236, g: 86 , b: 85 , a: 1).set() : self.setColor(30, g: 170 , b: 94 , a: 1).set()
        ctx?.setLineWidth(lazhuCXwidth)
        ctx?.strokePath()
}
    
    
    
    //绘制MACD
    func setMACD() {
        let lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324
        let startpointy = VIEW_SIZE.height - padding - squareH1 / 2
        let macdArrayT = macdArray as![NSArray]
        let count  = macdArray.count
        let ctx =  UIGraphicsGetCurrentContext()
        ctx?.setLineWidth(1)
        ctx?.setLineJoin(.round)
        //EMA12线
        ctx?.move(to: CGPoint(x: padding + 3 * lazhuUnitDot, y: startpointy - ( macdArrayT[0][0]  as!CGFloat ) * squareH1 / 2))
        for i in 0 ..< count {
            let ema12value = macdArrayT[i][0] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: startpointy - squareH1 / 2 * ema12value))
        }
        self.setColor(97, g: 177 , b: 209 , a: 1).set()
        ctx?.strokePath()
        //EMA26线
        ctx?.move(to: CGPoint(x: padding + 3 * lazhuUnitDot, y: startpointy - ( macdArrayT[0][1]  as!CGFloat ) * squareH1/2))
        
        for i in 0 ..< count {
            let ema26value = macdArrayT[i][1] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: startpointy - squareH1 / 2 * ema26value))
        }
        self.setColor(220, g: 200 , b: 106 , a: 1).set()
        ctx?.strokePath();
        //阴阳线
        for i in 0 ..< count {
            ctx?.move(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: startpointy))
            let difnumber = macdArrayT[i][2] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: startpointy - squareH1 / 2 * difnumber))
            if (difnumber < 0) {
                self.setColor(81, g: 182 , b: 64 , a: 1).set()
            }
            else
            {
                self.setColor(253, g: 73 , b: 83 , a: 1).set()
            }
            ctx?.strokePath()
        }
}
    
    //绘制KDJ
    func setKDJ() {
        let lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324;
        let startpointy = VIEW_SIZE.height - padding
        
        let kdjArrayT = kdjArray as![NSArray]
        let count  = kdjArray.count
        let  ctx =  UIGraphicsGetCurrentContext()
        ctx?.setLineWidth(1)
        ctx?.setLineJoin(.round)
        //k
        ctx?.move(to: CGPoint(x: padding + 3 * lazhuUnitDot, y: startpointy - (kdjArrayT[0][0] as! CGFloat ) * squareH1))
        for i in 0 ..< count {
            let kvalue = kdjArrayT[i][0] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: startpointy - squareH1 * kvalue))
        }
        self.setColor(213, g: 145 , b: 225 , a: 1).set()
        ctx?.strokePath()
        //d
        ctx?.move(to: CGPoint(x: padding + 3 * lazhuUnitDot, y: startpointy - (kdjArrayT[0][1] as! CGFloat) * squareH1))
        for i in 0 ..< count {
            let dvalue = kdjArrayT[i][1] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: startpointy - squareH1 * dvalue))
        }
        self.setColor(83, g: 170 , b: 210 , a: 1).set()
        ctx?.strokePath()
        //j
        ctx?.move(to: CGPoint(x: padding + 3 * lazhuUnitDot, y: startpointy - (kdjArrayT[0][2] as! CGFloat) * squareH1))
        for i in 0 ..< count {
            let jvalue = kdjArrayT[i][2] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: startpointy - squareH1 * jvalue))
        }
        self.setColor(218, g: 198 , b: 214 , a: 1).set()
        ctx?.strokePath()
}
  
    
    //绘制RSI
    func setRSI() {
        let lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324
        let startpointy = VIEW_SIZE.height - padding
        
        let rsiArrayT = rsiArray as![NSArray]
        let count  = rsiArray.count
        let ctx =  UIGraphicsGetCurrentContext()
        ctx?.setLineWidth(1)
        ctx?.setLineJoin(.round)
        //rsi1
        ctx?.move(to: CGPoint(x: padding + 3 * lazhuUnitDot, y: startpointy - (rsiArrayT[0][0] as! CGFloat) * squareH1))
        for i in 0 ..< count {
            let rsi1value = rsiArrayT[i][0] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: startpointy - squareH1 * rsi1value))
        }
        self.setColor(213, g: 145 , b: 225 , a: 1).set()
        ctx?.strokePath()
        //rsi2
        ctx?.move(to: CGPoint(x: padding + 3 * lazhuUnitDot, y: startpointy - (rsiArrayT[0][1] as! CGFloat) * squareH1))
        for i in 0 ..< count {
            let rsi2value = rsiArrayT[i][1] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: startpointy - squareH1 * rsi2value))
        }
        self.setColor(83, g: 170 , b: 210 , a: 1).set()
        ctx?.strokePath()
        //rsi3
        ctx?.move(to: CGPoint(x: padding + 3 * lazhuUnitDot, y: startpointy - (rsiArrayT[0][2] as! CGFloat) * squareH1))
        for i in 0 ..< count {
            let rsi3value = rsiArrayT[i][2] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: startpointy - squareH1 * rsi3value))
        }
        self.setColor(218, g: 198 , b: 214 , a: 1).set()
        ctx?.strokePath()
}

    
    
    //绘制BIAS
    func setBIAS() {
        let lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324
        let startpointy = VIEW_SIZE.height - padding
        
        let biasArrayT = biasArray as![NSArray]
        let count  = biasArray.count
        let ctx =  UIGraphicsGetCurrentContext()
        ctx?.setLineWidth(1)
        ctx?.setLineJoin(.round)
        //bias1
        ctx?.move(to: CGPoint(x: padding + 3 * lazhuUnitDot, y: startpointy - (biasArrayT[0][0] as! CGFloat) * squareH1))
        for i in 0 ..< count {
            let bias1value = biasArrayT[i][0] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: startpointy - squareH1 * bias1value))
        }
        self.setColor(213, g: 145 , b: 225 , a: 1).set()
        ctx?.strokePath()
        //bias2
        ctx?.move(to: CGPoint(x: padding + 3 * lazhuUnitDot, y: startpointy - (biasArrayT[0][1] as! CGFloat) * squareH1))
        for i in 0 ..< count {
            let bias2value = biasArrayT[i][1] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: startpointy - squareH1 * bias2value))
        }
        self.setColor(83, g: 170 , b: 210 , a: 1).set()
        ctx?.strokePath()
        //bias3
        ctx?.move(to: CGPoint(x: padding + 3 * lazhuUnitDot, y: startpointy - (biasArrayT[0][2] as! CGFloat) * squareH1))
        for i in 0 ..< count {
            let bias3value = biasArrayT[i][2] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: startpointy - squareH1 * bias3value))
        }
        self.setColor(218, g: 198 , b: 214 , a: 1).set()
        ctx?.strokePath()
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
        
        let crArrayT = crArray as![NSArray]
        let count = crArray.count
        let ctx =  UIGraphicsGetCurrentContext()
        ctx?.setLineWidth(1)
        ctx?.setLineJoin(.round)
        //cr1
        ctx?.move(to: CGPoint(x: padding + 3 * lazhuUnitDot, y: startpointy - (crArrayT[0][0] as! CGFloat) * squareH1));
        for  i in 0 ..< count {
            let cr1value = crArrayT[i][0] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: startpointy - squareH1 * cr1value))
        }
        self.setColor(213, g: 145 , b: 225 , a: 1).set()
        ctx?.strokePath()
        //cr2
        ctx?.move(to: CGPoint(x: padding + 3 * lazhuUnitDot, y: startpointy - (crArrayT[0][1] as! CGFloat) * squareH1))
        for  i in 0 ..< count {
            let cr2value = crArrayT[i][1] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: startpointy - squareH1 * cr2value))
        }
        self.setColor(83, g: 170 , b: 210 , a: 1).set()
        ctx?.strokePath()
        //cr3
        ctx?.move(to: CGPoint(x: padding + 3 * lazhuUnitDot, y: startpointy - (crArrayT[0][3] as! CGFloat) * squareH1))
        for  i in 0 ..< count {
            let cr3value = crArrayT[i][3] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: startpointy - squareH1 * cr3value))
        }
        self.setColor(218, g: 198 , b: 214 , a: 1).set()
        ctx?.strokePath()
}
    
    
    //绘制DMI
    func setDMI() {
        let lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324
        let startpointy = VIEW_SIZE.height - padding
        
        let dmiArrayT = dmiArray as![NSArray]
        let count  = dmiArray.count
        let ctx =  UIGraphicsGetCurrentContext()
        ctx?.setLineWidth(1)
        ctx?.setLineJoin(.round)
        //dmi1
        ctx?.move(to: CGPoint(x: padding + 3 * lazhuUnitDot, y: startpointy - (dmiArrayT[0][0] as! CGFloat) * squareH1))
        for i in 0 ..< count {
            let dmi1value = dmiArrayT[i][0] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: startpointy - squareH1 * dmi1value));
        }
        self.setColor(213, g: 145 , b: 225 , a: 1).set()
        ctx?.strokePath()
        //dmi2
        ctx?.move(to: CGPoint(x: padding + 3 * lazhuUnitDot, y: startpointy - (dmiArrayT[0][1] as! CGFloat) * squareH1))
        for i in 0 ..< count  {
            let dmi2value = dmiArrayT[i][1] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: startpointy - squareH1 * dmi2value))
        }
        self.setColor(83, g: 170 , b: 210 , a: 1).set()
        ctx?.strokePath()
        //dmi3
        ctx?.move(to: CGPoint(x: padding + 3 * lazhuUnitDot, y: startpointy - (dmiArrayT[0][2] as! CGFloat) * squareH1))
        for i in 0 ..< count  {
            let dmi3value = dmiArrayT[i][2] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: startpointy - squareH1 * dmi3value))
        }
        self.setColor(218, g: 198 , b: 214 , a: 1).set()
        ctx?.strokePath()
        //dmi4
        ctx?.move(to: CGPoint(x: padding + 3 * lazhuUnitDot, y: startpointy - (dmiArrayT[0][3] as! CGFloat) * squareH1))
        for i in 0 ..< count  {
            let dmi4value = dmiArrayT[i][3] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: startpointy - squareH1 * dmi4value))
        }
        self.setColor(245, g: 73 , b: 108 , a: 1).set()
        ctx?.strokePath()
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
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("Touch moves")
        shiZiLayer.isHidden = false;
        let laZhuTuTransArrayT = laZhuTuTransArray as![NSArray]
        
    if isShiZiXianShown == true {
            let touch = (touches as NSSet).anyObject()!
            let current = (touch as AnyObject).location(in: self)
    
        if( style ==  .phChartStyleFenShiTu ) {
            
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
            let data = laZhuTuTransArrayT[Int(xvalue)][3]
            
            shiZiLayer.xValue = current.x
            shiZiLayer.yValue = data as! CGFloat
            shiZiLayer.setNeedsDisplay()
        }
    }
}
    

    
    
    
// MARK: utilities
    
    func setColor(_ r:CGFloat , g:CGFloat , b:CGFloat , a:Float) -> UIColor {
        
        return  UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: r)
}
    
    
    func drawTwoLine(_ array:NSArray) {
        let lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324
        let startpointy = VIEW_SIZE.height - padding
        
        let arrayT = array as![NSArray]
        let count  = array.count
        let ctx =  UIGraphicsGetCurrentContext()
        ctx?.setLineWidth(1)
        ctx?.setLineJoin(.round)
        //line1
        ctx?.move(to: CGPoint(x: padding + 3 * lazhuUnitDot, y: startpointy - (arrayT[0][0] as! CGFloat) * squareH1))
        
        for i in 0 ..< count {
            let line1value = arrayT[i][0] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: startpointy - squareH1 * line1value))
        }
        
        self.setColor(250, g: 202 , b: 65 , a: 1).set()
        ctx?.strokePath()
        //line2
        ctx?.move(to: CGPoint(x: padding + 3 * lazhuUnitDot, y: startpointy - (arrayT[0][1] as! CGFloat) * squareH1))
        
        for i in 0 ..< count {
            let line2value = arrayT[i][1] as! CGFloat
            ctx?.addLine(to: CGPoint(x: padding + (3 + 4 * CGFloat(i)) * lazhuUnitDot, y: startpointy - squareH1 * line2value))
        }
        
        self.setColor(83, g: 170 , b: 210 , a: 1).set()
        ctx?.strokePath()
}
    
    
    func getAbosoluteValue(_ inputvalue:CGFloat) -> CGFloat {
        
        if(inputvalue < 0) {
            
             return -inputvalue;
        }
        return inputvalue;
}
    
  
    
    
    func getLineArray(_ array:NSArray) -> NSArray {
        
        let arrayT = array as! [NSArray]
        var  _MAX_NUM = arrayT[0][0] as! CGFloat
        var  _MIN_NUM = arrayT[0][0] as! CGFloat
        
        for element in array {
            let Element = element as!NSArray
            let line1value = Element[0] as! CGFloat
            let line2value = Element[1] as! CGFloat
            
            if (_MAX_NUM < line1value ){ _MAX_NUM = line1value }
            if (_MAX_NUM < line2value ){ _MAX_NUM = line2value }
            
            if (_MIN_NUM > line1value ){ _MIN_NUM = line1value }
            if (_MIN_NUM > line2value ){ _MIN_NUM = line2value }
            if (Element.count == 3) {
                let line3value = Element[2] as! CGFloat
                if (_MAX_NUM < line3value ){ _MAX_NUM = line3value }
                if (_MIN_NUM > line3value ){ _MIN_NUM = line3value }
                if ((element as AnyObject).count == 4) {
                    let line4value = Element[3] as! CGFloat
                    if (_MAX_NUM < line4value ){ _MAX_NUM = line4value }
                    if (_MIN_NUM > line4value ){ _MIN_NUM = line4value }
                }
            }
        }
        let delta = _MAX_NUM - _MIN_NUM;
        let temptarra = NSMutableArray()
        for element in array {
            let Element = element as!NSArray
            let temptarray = NSMutableArray()
            let vr1newvalue = (Element[0] as! CGFloat - _MIN_NUM) / delta
            let vr2newvalue = (Element[1] as! CGFloat - _MIN_NUM) / delta
            temptarray.add(vr1newvalue)
            temptarray.add(vr2newvalue)
            
            if (Element.count == 3) {
                let vr3newvalue = (Element[2] as! CGFloat - _MIN_NUM) / delta
                temptarray.add(vr3newvalue)
                if ((element as AnyObject).count == 4) {
                    let vr4newvalue = (Element[4] as! CGFloat - _MIN_NUM) / delta
                    temptarray.add(vr4newvalue)
                }
            }
            temptarra.add(temptarray)
        }
        return temptarra;
}
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}
