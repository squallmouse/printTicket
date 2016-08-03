//
//  ScanVC.swift
//  QRCodeLandscape
//
//  Created by 袁昊 on 16/8/2.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit

import AVFoundation

typealias QRCodeBlock = (String?)->Void;

protocol scandelegate {
    func scanresult(str:String?);
}

class ScanVC: UIViewController,AVCaptureMetadataOutputObjectsDelegate {


    var session:AVCaptureSession!;
    var cameraType:AVCaptureDevicePosition!;
    var qrcodeBlock = QRCodeBlock?();
    var delegate : scandelegate?;
    var output : AVCaptureMetadataOutput!;

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor();
//扫描初始化
        self.scanInit();
//        UI 设置
        self.setScanRegion();
    }

//  MARK:-  二维码

/**
 初始化
 */
    func scanInit() -> Void {
//        获取摄像设备
        let deviceArr = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo);
        print("\(deviceArr)");

        for temp  in deviceArr {
            let item = temp as! AVCaptureDevice;
//        选取后置摄像头
            if item.position == self.cameraType {

                do{
//                  创建输入
                    let input = try AVCaptureDeviceInput(device: item);
//                  创建输出
                     output = AVCaptureMetadataOutput();

//                  设置代理，在主线程里刷新
                    output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue());

//                    初始化链接对象
                    session = AVCaptureSession();
//                    采集率的质量
                    session.sessionPreset = AVCaptureSessionPresetHigh;
//                    添加输入和输出
                    session.addInput(input);
                    session.addOutput(output);
//                    设置支持的编码格式
//                    let typeArr = output.availableMetadataObjectTypes;
//                    print("本设备所支持的编码格式 = \(typeArr)");
                    output.metadataObjectTypes = [AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeQRCode];

                    let layer = AVCaptureVideoPreviewLayer(session: session);
                    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
                    layer.connection.videoOrientation = .LandscapeLeft;
                    layer.frame = self.view.bounds;
                    self.view.layer.insertSublayer(layer, atIndex: 0);
                    session.startRunning();
                }catch{

                }
            }

        }

    }

//  扫描结果的代理
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {

        if metadataObjects.count > 0 {
            session.stopRunning();
            let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject;
            print("\(metadataObject.stringValue)");
            self.qrcodeBlock?(metadataObject.stringValue);
            self.delegate?.scanresult(metadataObject.stringValue);
            self.dismissViewControllerAnimated(true, completion: nil);
        }
        
    }
//  MARK:-  设置取景框

    func setScanRegion() -> Void {

        let overlayImageView = UIImageView(image: UIImage(named: "overlaygraphic.png"));
        overlayImageView.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(overlayImageView);

        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: .CenterY, relatedBy: .Equal, toItem: overlayImageView, attribute: .CenterY, multiplier: 1.0, constant: 0));
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: .CenterX, relatedBy: .Equal, toItem: overlayImageView, attribute: .CenterX, multiplier: 1.0, constant: 0));

        let screenHeight = UIScreen.mainScreen().bounds.size.height;
        let screenWidth = UIScreen.mainScreen().bounds.size.width;

        output.rectOfInterest = CGRectMake(
            (screenWidth - 260) / 2 / screenWidth,
            (screenHeight  - 200) / 2 / screenHeight,
            260 / screenWidth,
            200 / screenHeight);
//        output.rectOfInterest = CGRectMake(
//            0,0.5,1,0.5);


//        返回按钮

        let btn = UIButton(type: .System);
        btn.setTitle("返回", forState: .Normal);
        btn.frame = CGRectMake(0, screenHeight-40, 100, 40);
        self.view.addSubview(btn);
        btn.titleLabel?.font = UIFont.boldSystemFontOfSize(20);
        btn.backgroundColor = UIColor.blackColor();
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal);
        btn.addTarget(self, action: #selector(backBtnClickDown), forControlEvents: .TouchUpInside);
    }

    func backBtnClickDown() -> Void {
        self.dismissViewControllerAnimated(true, completion: nil);
    }

    
//  MARK:-  Other

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
