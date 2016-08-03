//
//  Utils.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/5.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import Foundation


let s_width = UIScreen .mainScreen().bounds.size.width;

let s_height = UIScreen .mainScreen().bounds.size.height;


class Utils: NSObject {

//    MARK: - 创建一个HUD
//   class func creatHUD() -> MBProgressHUD {
//        let window = ((UIApplication.sharedApplication().windows) as NSArray).lastObject as! UIWindow ;
//        let hud = MBProgressHUD.init(window: window);
//        hud.detailsLabelFont = UIFont.systemFontOfSize(16);
//        window.addSubview(hud);
//        hud.userInteractionEnabled = false;
//        hud.show(true);
//        hud.removeFromSuperViewOnHide = true;
//        return hud;
//    }

//    MARK: - 
    
    class func getOwnID() -> String{
        let user = NSUserDefaults.standardUserDefaults();
      let  userID =  user.valueForKey("userID") as? String;
        if (userID == nil) {
            return "0";
        }else{
            return userID! ;
        }
        
    }
//  MARK:-  NSDate 转换成时间串
   class func dateConversionToString(date:NSDate?) -> String {
        let da1 = NSDateFormatter();
        da1.dateFormat = "yyyy-MM-dd";
        return da1.stringFromDate(date!);
    }
//  MARK:-  把null换成""
//
    class func changeNullToEmptyStr(value:AnyObject?)->String
    {
        if value is NSNull {
            return ""
        }else{
            return value as! String;
        }
        
    }
    
    
    func change(parmeters:AnyObject?) -> String? {
        //        为空就返回
        if (parmeters == nil) {
            return "";
        }
        //
        var returnStr:String = "?";
        
        if (parmeters is String) {
            
            return parmeters as? String;
            
        }else if (parmeters is NSDictionary){
            
            let dic = parmeters as! NSDictionary;
            
            for i in 0 ..< dic.allKeys.count {
                returnStr = returnStr + (dic.allKeys[i] as! String)  + "=" + (dic.objectForKey(dic.allKeys[i] as! String) as? String)!
                if (i != dic.allKeys.count - 1)  {
                    returnStr += "&";
                }
            }
            return returnStr;
        }
        
        
        return "";
   
    }
//  MARK:-  中文转码
//
    class  func urlStrConversion(urlStr urlStr:String!) -> String {

//   let data = urlStr.dataUsingEncoding(NSUTF8StringEncoding)
//    return String(data: data!, encoding: NSUTF8StringEncoding)!;
        print("中文转码");
//
        return urlStr.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!;
        
    }

    
//  MARK:-  html 
//    class func HTMLWithDic(dic:NSDictionary, useingTemplate templateName:String)->NSString{
//        let templatePath = NSBundle.mainBundle().pathForResource(templateName, ofType: "html", inDirectory: "html");
//        do{
//            let template = try NSString.init(contentsOfFile: templatePath!, encoding: NSUTF8StringEncoding);
//            
//        
////            GRMustache
//            return "";
//        }catch{
//            print("html失败了！！！！！！")
//            return "";
//        }
//        
//    }
//    

//  MARK:-  图片链接转换
    class func SBImgChange(imgstr:String?)->String!{
        if imgstr == nil {
            return ""
        }else{
            var utfStr = imgstr!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet());
            
            if(!(utfStr! as NSString).hasPrefix("/")){
                utfStr = "/" + utfStr! ;
            }
            return utfStr;
        }
    }
    
//  MARK:-  距离转换
    
//   class func distanceConversion(distanceStr:String!) -> String! {
//        let Coordinate = distanceStr.componentsSeparatedByString(",") as NSArray;
//        let lati = Coordinate[1].doubleValue;
//        let long = Coordinate[0].doubleValue;
//        
//        let coordinate1 = CLLocationCoordinate2D(latitude: lati, longitude: long )
//        
//        let userLocation =   ((UIApplication.sharedApplication().delegate)as! AppDelegate).userLocation;
//    
//        if userLocation != nil {
//            let latitude = NSString(format: "%f", (userLocation?.location.coordinate.latitude)!);
//            
//            let longitude = NSString(format: "%f", (userLocation?.location.coordinate.longitude)!);
//            let coordinate2 = CLLocationCoordinate2D(latitude:Double(latitude as String)!, longitude: Double(longitude as String)! );
//            let  point1:BMKMapPoint = BMKMapPointForCoordinate(coordinate1);
//            let  point2:BMKMapPoint = BMKMapPointForCoordinate(coordinate2);
//            
//            let distance = BMKMetersBetweenMapPoints(point1,point2);
//            let juli = distance / 1000.0;
//            let zuihou = NSString(format: "%.1f", juli) as String;
//            
//            return zuihou;
//            
//        }else{
//            return "";
//        }
//    
//    }

//  MARK:-  获取缓存的大小
  
    class func getCacheSize() -> String{
        // 取出cache文件夹路径

        let cachePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
        // 打印路径,需要测试的可以往这个路径下放东西
        print(cachePath)
        // 取出文件夹下所有文件数组
        let files = NSFileManager.defaultManager().subpathsAtPath(cachePath!)
        // 用于统计文件夹内所有文件大小
        var big = Int();
        
        // 快速枚举取出所有文件名
        for p in files!{
            // 把文件名拼接到路径中
            let path = cachePath!.stringByAppendingFormat("/\(p)")
            // 取出文件属性
            let floder = try! NSFileManager.defaultManager().attributesOfItemAtPath(path)
            // 用元组取出文件大小属性
            for (abc,bcd) in floder {
                // 只去出文件大小进行拼接
                if abc == NSFileSize{
                    big += bcd.integerValue
                }
            }
        }
        let message = NSString(format: "%.2fM", Float(big) / Float(1024*1024));
        return message as String;
        
    }
    
//  MARK:-  清理缓存
    
    class func clearCache(){
        let cachePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
        // 打印路径,需要测试的可以往这个路径下放东西
        print(cachePath)
        // 取出文件夹下所有文件数组
        let files = NSFileManager.defaultManager().subpathsAtPath(cachePath!)
        
        for p in files!{
            // 拼接路径
            let path = cachePath!.stringByAppendingFormat("/\(p)")
            // 判断是否可以删除
            if(NSFileManager.defaultManager().fileExistsAtPath(path)){
                // 删除
                do{
                    try NSFileManager.defaultManager().removeItemAtPath(path)
                }catch{

                }
            }
        }
    }
//  MARK:-  用户是否开启了推送
    class func isRegiestNoti()->Bool{
        let setting = UIApplication.sharedApplication().currentUserNotificationSettings();
        if setting?.types != .None {
            return true;
        }else{
            return false;
        }
        
    }

//  MARK:-  打开微信

   class func openWechat() -> UIAlertController {

    let alertvc = UIAlertController(title: "提示", message: "请您关注官方微信公众号（京西拾零采撷门头沟）选购", preferredStyle: .Alert);

    if (UIApplication.sharedApplication().canOpenURL(NSURL.init(string: "wechat://")!)) {
//安装了微信
        let sure = UIAlertAction(title: "确定", style: .Default) { (alert) in
                UIApplication.sharedApplication().openURL(NSURL.init(string: "wechat://")!)
        }
         alertvc.addAction(sure);
    }else{
//        没有安装微信
        alertvc.message = "请安装微信关注公众号选购！";
    }

       let cancle = UIAlertAction(title: "取消", style: .Cancel) { (alert) in
        print("取消咯");
    }

    alertvc.addAction(cancle);

    return alertvc;

    }

}
