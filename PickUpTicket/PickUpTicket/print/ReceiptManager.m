//
//  ReceiptManager.m
//  Ticket
//
//  Created by 袁昊 on 16/7/29.
//  Copyright © 2016年 squallmouse. All rights reserved.
//

#import "ReceiptManager.h"

@implementation ReceiptManager

- (instancetype)initWithHost:(NSString *)host port:(UInt16)port timeout:(NSTimeInterval)timeout{
    if (self = [super init]) {
        [self.asynaSocket socketConnectToPrint:host port:port timeout:timeout];

    }
    return self;
}

- (void)connectWithHost:(NSString *)host port:(UInt16)port timeout:(NSTimeInterval)timeout{
    [self.asynaSocket socketConnectToPrint:host port:port timeout:timeout];
}

- (SocketManager*)asynaSocket {
    if (!_asynaSocket) {
        _asynaSocket = [[SocketManager alloc]init];
    }
    return _asynaSocket;
}

- (PrintManager*)printerManager {
    if (! _printerManager) {
        _printerManager = [[PrintManager alloc]init];
    }
    return _printerManager;
}


//基础设置
- (void)basicSetting{
//    打印机初始化
    [self.printerManager printInitialize];
//  设置成标准模式
    [self.printerManager printSetStanderModel];
//    设置横向 纵向 移动单位
    [self.printerManager printDotDistanceW:DotSpace h:DotSpace];
//  设置行间距
    [self.printerManager printDefaultLineSpace];
//    设置字体
    [self.printerManager printSelectFont:standardFont];
     NSLog(@"----  %d ----",[self.asynaSocket socketIsConnect]);
}

//清空缓存数据
- (void)clearData{
    self.printerManager.sendData.length = 0;
}

//写入单行文字
- (void)writeData_title:(NSString *)title Scale:(kCharScale)scale Type:(kAlignmentType)type{
    [_printerManager printCharSize:scale];
    [_printerManager printAlignmentType:type];
    [_printerManager printAddText:title];
    [_printerManager printAndGotoNextLine];
}

//写入多行文字
- (void)writeData_items:(NSArray *)items{
    [self.printerManager printCharSize:scale_1];
    [_printerManager printAlignmentType:LeftAlignment];
    for (NSString *item in items) {
        [_printerManager printAddText:item];
        [_printerManager printAndGotoNextLine];
    }
}

//打印图片
- (void)writeData_image:(UIImage *)image alignment:(kAlignmentType)alignment maxWidth:(CGFloat)maxWidth{

    [self.printerManager printAlignmentType:alignment];

    CGFloat width = image.size.width;
    if (width > maxWidth) {
        CGFloat height = image.size.height;
        CGFloat maxHeight = maxWidth *height / width;
        image = [self createCurrentImage:image width:maxWidth height:maxHeight];
    }
    [self.printerManager printBitmapModel:image];
    [self.printerManager printAndGotoNextLine];

}

// 缩放图片
- (UIImage *)createCurrentImage:(UIImage *)inImage width:(CGFloat)width height:(CGFloat)height {
    CGSize size = CGSizeMake(width, height);
    UIGraphicsBeginImageContext(size);
    [inImage drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}



//条目,菜单,有间隔,如:
//  炸鸡排     2      12.50      25.00
- (void)writeData_content:(NSArray *)items {
    [self.printerManager printCharSize:scale_1];
    [_printerManager printAlignmentType:LeftAlignment];
    for (NSDictionary *dict in items) {
        [self writeData_spaceItem:dict];
    }
}
- (void)writeData_spaceItem:(NSDictionary *)item {
    [_printerManager printAddText:[item objectForKey:@"key01"]];
    [_printerManager printAbsolutePosition:350];
    [_printerManager printAddText:[item objectForKey:@"key02"]];
    [_printerManager printAbsolutePosition:500];
    [_printerManager printAddText:[item objectForKey:@"key03"]];
    [_printerManager printAbsolutePosition:640];
    [_printerManager printAddText:[item objectForKey:@"key04"]];
    [_printerManager printAndGotoNextLine];
}
//打印分割线
- (void)writeData_line {
    [self.printerManager printAlignmentType:MiddleAlignment];
    [self.printerManager printAddText:@"------------------------------------------"];
    [self.printerManager printAndGotoNextLine];
}
//打开钱箱
- (void)openCashDrawer {
    [self.printerManager printOpenCashDrawer];
}
//打印小票
- (void)printReceipt {
    for (int i = 0; i < 3; i++) {
        [_printerManager printAndGotoNextLine];
    }
    [self.printerManager printCutPaper:feedPaperHalfCut Num:12];
    [_asynaSocket socketWriteData:[self.printerManager sendData]];
}




@end
