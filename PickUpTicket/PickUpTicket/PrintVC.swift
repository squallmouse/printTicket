//
//  PrintVC.swift
//  PickUpTicket
//
//  Created by 袁昊 on 16/8/1.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit
import AVFoundation

class PrintVC: UIViewController,scandelegate {

    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var numberLab: UILabel!

    @IBOutlet weak var rightThreeBtnHight: NSLayoutConstraint!
    @IBOutlet weak var confromBtn: UIButton!
    
    var cameraType:AVCaptureDevicePosition!;
//    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        print("\(UIScreen.mainScreen().bounds.size.height)");

        if UIScreen.mainScreen().bounds.size.height == 320{
            self.rightThreeBtnHight.constant = 30;
        }

       

    }


//  MARK:-  按钮们
    @IBAction func numberBtnClickDown(sender: AnyObject) {

        let btn = sender as! UIButton;
        print("\(btn.tag-1800)");

        self.numberLab.text = NSString(format: "%@%@", self.numberLab.text!,String(btn.tag-1800)) as String;

        if self.numberLab.text?.characters.count > 0 {
            self.confromBtn.setTitle("确认", forState: .Normal);
        }else{
            self.confromBtn.setTitle("输入取票码后取票", forState: .Normal);
        }
    }

    @IBAction func clearAllNumber(sender: AnyObject) {
        print("clear all");
        self.numberLab.text = "";
        if self.numberLab.text?.characters.count > 0 {
            self.confromBtn.setTitle("确认", forState: .Normal);
        }else{
            self.confromBtn.setTitle("输入取票码后取票", forState: .Normal);
        }
    }

    @IBAction func deleteBtnClickDown(sender: AnyObject) {
        print("delete ");
        if self.numberLab.text?.characters.count > 0 {
            self.numberLab.text = self.numberLab.text?.substringToIndex(self.numberLab.text!.endIndex.advancedBy(-1));

        }
        if self.numberLab.text?.characters.count > 0 {
            
            self.confromBtn.setTitle("确认", forState: .Normal);
        }else{
            self.confromBtn.setTitle("输入取票码后取票", forState: .Normal);
        }
    }

    @IBAction func conformBtnClcikDown(sender: AnyObject) {
        print("打印出码");

    }


    @IBAction func erweima(sender: AnyObject) {
        print("二维码");
        let scanvc = ScanVC();
        scanvc.cameraType = self.cameraType;
        scanvc.delegate = self;

        self .presentViewController(scanvc, animated: true, completion: nil);
    }

//  MARK:-  scan 的代理
/**
 扫描结果的代理

 - parameter str: 读取的二维码的内容
 */
    func scanresult(str: String?) {
        print("scanResult = \(str)");
//        let alert = UIAlertView(title: "结果", message: str!, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "OK" );
//        alert.show();

//
//       let manager = ReceiptManager(host: "192.168.31.207", port: 9100, timeout: 10);
//        manager.basicSetting();
//        manager.writeData_title(str, scale: scale_1, type: MiddleAlignment);
////        开始打印
//        manager.printReceipt();
//
    }

//  MARK:-  other
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
