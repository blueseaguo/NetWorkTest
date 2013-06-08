//
//  MonitorNetWork.m
//  NetWorkTest
//
//  Created by 郭 佳佳 on 13-6-8.
//  Copyright (c) 2013年 郭 佳佳. All rights reserved.
//

#import "MonitorNetWork.h"
#import "Reachability.h"
#import <MBProgressHUD.h>
@interface MonitorNetWork ()

@property (nonatomic,retain)Reachability *hostReach;
@end

@implementation MonitorNetWork

- (void)dealloc
{
    self.hostReach = nil;
    [super dealloc];
}
+ (MonitorNetWork *)sharedNetWork
{
    static MonitorNetWork *sharedNetWork = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNetWork = [[MonitorNetWork alloc] init];
    });
    
    return sharedNetWork;
}


-(void)StartMonitorNetWork
{
    self.hostReach = [[Reachability reachabilityWithHostName:@"www.baidu.com"] retain];
    [self.hostReach startNotifier];
}

- (id)init
{
    if (self=[super init])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachabilityChanged:)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
    }
    return self;
}

- (void)reachabilityChanged:(NSNotification *)note
{
    
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    switch (status) {
        case NotReachable:
             [self showTextOnly:@"网络断开"];
            break;
        case ReachableViaWiFi:
            NSLog(@"ReachableViaWiFi");
            [self showTextOnly:@"ReachableViaWiFi"];
            break;
        case  ReachableViaWWAN:
            NSLog(@"ReachableViaWWAN");
            [self showTextOnly:@"ReachableViaWWAN"];
            break;
        default:
            break;
    }
}


- (void)showTextOnly:(NSString *)sender
{
	
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
	
	// Configure for text only and offset down
	hud.mode = MBProgressHUDModeText;
	hud.animationType = MBProgressHUDAnimationFade;
	hud.labelText = sender;
	hud.margin = 10.f;
    //	hud.yOffset = 150.f;
	hud.removeFromSuperViewOnHide = YES;
	
	[hud hide:YES afterDelay:3];
}


@end
