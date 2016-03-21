//
//  AppDelegate.h
//  CoolRun
//
//  Created by Caroline.H on 3/16/16.
//  Copyright © 2016 Caroline.H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPFramework.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) XMPPStream *xmppStream;
@end

