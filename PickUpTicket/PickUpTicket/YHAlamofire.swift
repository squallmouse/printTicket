//
//  YHAlamofire.swift
//  MenTouGou
//
//  Created by 袁昊 on 16/4/8.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit
import Alamofire


class YHAlamofire: NSObject {
//
    
    class func Get(
             urlStr url:String!,
             paramters parameters:[String : AnyObject]?,
             success:(AnyObject?) -> Void,
             OrFailure failed:(AnyObject?) -> Void) -> Void
    {
         let urlStr = Utils.urlStrConversion(urlStr: url);
        Alamofire.request(.GET, urlStr, parameters: parameters).response { (request, response, data, error) in
            do{
//                
                let str = String(data: data!, encoding: NSUTF8StringEncoding);
              let  data1 = str?.dataUsingEncoding(NSUTF8StringEncoding);                
                let res:AnyObject = try NSJSONSerialization.JSONObjectWithData(data1!, options: .MutableLeaves) ;
                success(res);
            }catch{
                if data != nil{
                let errorStr = String.init(data: data!, encoding: NSUTF8StringEncoding);
                    print("||  failed error  ||===== \(errorStr) ||||||  end");
                    failed(errorStr);
                    return;
                }
                print("error =||||\n \(error) \n|||")
                failed(error as? AnyObject);
            }
        }
    
    }
    
//    
    class func Post(urlStr url:String!, paramters parameters:[String : AnyObject]?, success:(AnyObject?) -> Void, OrFailure failed:(AnyObject?) -> Void) -> Void{
        let urlStr = Utils.urlStrConversion(urlStr: url);
        Alamofire.request(.POST, urlStr, parameters: parameters).response { (request, response, data, error) in
            do{
                let str = String(data: data!, encoding: NSUTF8StringEncoding);
                let  data1 = str?.dataUsingEncoding(NSUTF8StringEncoding);
                let res:AnyObject = try NSJSONSerialization.JSONObjectWithData(data1!, options: .MutableLeaves) ;
                success(res);
            }catch{
                failed(error as? AnyObject);
            }
        }
    }

    
//    Json请求
    class func PostJson(urlStr url:String!, paramters parameters:[String : AnyObject]?, success:(AnyObject?) -> Void, OrFailure failed:(AnyObject?) -> Void) -> Void{
        
        
        
        Alamofire.request(.POST, url, parameters: parameters, encoding:.JSON).response { (request, response, data, error) in
            do{
                let str = String(data: data!, encoding: NSUTF8StringEncoding);
                let  data1 = str?.dataUsingEncoding(NSUTF8StringEncoding);
                let res:AnyObject = try NSJSONSerialization.JSONObjectWithData(data1!, options: .MutableLeaves) ;
                success(res);
            }catch{
                if data != nil{
                    let errorStr = String.init(data: data!, encoding: NSUTF8StringEncoding);
                    print("||  failed error  ||===== \(errorStr) ||||||  end");
                    failed(errorStr);
                    return;
                }
                print("error =||||\n \(error) \n|||")
                failed(error as? AnyObject);
            }
        }
    }

    
}
