//
//  ViewController.swift
//  PickUpTicket
//
//  Created by 袁昊 on 16/8/1.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var cameraType:AVCaptureDevicePosition!;


    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true);
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        self.cameraType = AVCaptureDevicePosition.Back;
        
    }


    @IBAction func segmentBtnClickDown(sender: AnyObject, forEvent event: UIEvent) {

        let temp = sender as! UISegmentedControl;
        print(" ----\(temp.selectedSegmentIndex)");
        
        if temp.selectedSegmentIndex == 0 {
            self.cameraType = AVCaptureDevicePosition.Back;
        }else{
            self.cameraType = AVCaptureDevicePosition.Front;
        }

    }



    @IBAction func conformBtnClickDown(sender: AnyObject) {


        self.performSegueWithIdentifier("gotoPrintVC", sender: self);

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gotoPrintVC" {
            let vc:PrintVC = segue.destinationViewController as! PrintVC;
            vc.cameraType = self.cameraType;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

