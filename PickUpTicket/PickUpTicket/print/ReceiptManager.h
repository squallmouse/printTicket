//
//  ReceiptManager.h
//  Ticket
//
//  Created by 袁昊 on 16/7/29.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PrintManager.h"
#import "SocketManager.h"

@interface ReceiptManager : NSObject


@property (nonatomic, strong) SocketManager *asynaSocket;
@property (nonatomic, strong) PrintManager *printerManager;


- (instancetype)initWithHost:(NSString *)host port:(UInt16)port timeout:(NSTimeInterval)timeout;
- (void)connectWithHost:(NSString *)host port:(UInt16)port timeout:(NSTimeInterval)timeout;
//基础设置
- (void)basicSetting;
//清空缓存数据
- (void)clearData;


//写入单行文字
- (void)writeData_title:(NSString *)title Scale:(kCharScale)scale Type:(kAlignmentType)type;
//写入多行文字
- (void)writeData_items:(NSArray *)items;
//打印图片
- (void)writeData_image:(UIImage *)image alignment:(kAlignmentType)alignment maxWidth:(CGFloat)maxWidth;
//条目,菜单,有间隔
- (void)writeData_content:(NSArray *)items;
//打印分割线
- (void)writeData_line;
//打开钱箱
- (void)openCashDrawer;
//打印小票
- (void)printReceipt;


@end
