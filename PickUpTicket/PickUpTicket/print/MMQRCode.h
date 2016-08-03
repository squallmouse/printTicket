//
//  MMQRCode.h
//  Ticket
//
//  Created by 袁昊 on 16/7/29.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MMQRCode : NSObject

+ (UIImage *)qrCodeWithString:(NSString *)string logoName:(NSString *)name size:(CGFloat)width;

@end
