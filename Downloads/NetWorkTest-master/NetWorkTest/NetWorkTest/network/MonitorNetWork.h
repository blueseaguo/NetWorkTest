//
//  MonitorNetWork.h
//  NetWorkTest
//
//  Created by 郭 佳佳 on 13-6-8.
//  Copyright (c) 2013年 郭 佳佳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonitorNetWork : NSObject


+ (MonitorNetWork *)sharedNetWork;
-(void)StartMonitorNetWork;
@end
