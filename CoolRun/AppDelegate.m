//
//  AppDelegate.m
//  CoolRun
//
//  Created by Caroline.H on 3/16/16.
//  Copyright © 2016 Caroline.H. All rights reserved.
//

#import "AppDelegate.h"
#import "CRUserInfo.h"
@interface AppDelegate () <XMPPStreamDelegate>

- (void) setupXMPPStream;
- (void) connectToServer;
- (void) sendPassword;
- (void) sendOnline;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void) setupXMPPStream {
    self.xmppStream = [[XMPPStream alloc] init];
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
}
- (void) connectToServer {
    [self.xmppStream disconnect];
    if (self.xmppStream == nil) {
        [self setupXMPPStream];
    }
    self.xmppStream.hostName = CRXMPPHOSTNAME;
    self.xmppStream.hostPort = CRXMPPPORT;
    NSString *userName = nil;
    userName = [CRUserInfo sharedCRUserInfo].userName;
    NSString *jidStr = [NSString stringWithFormat:@"%@@%@",userName,CRXMPPDOMAIN];
    XMPPJID *myJid = [XMPPJID jidWithString:jidStr];
    self.xmppStream.myJID = myJid;
    NSError *error = nil;
    [self.xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error];
    if (error) {
        NSLog(@"连接失败！");
        NSLog(@"%@",error);
    }
}
- (void) sendPassword {
    NSError *error = nil;
    NSString *userPasswd = nil;
    userPasswd = [CRUserInfo sharedCRUserInfo].userPasswd;
    [self.xmppStream authenticateWithPassword:userPasswd error:&error];
    if (error) {
        NSLog(@"连接失败！");
        NSLog(@"%@",error);
    }
}
- (void) sendOnline {
    XMPPPresence *presence = [XMPPPresence presence];
    [self.xmppStream sendElement:presence];
}

#pragma mark  XMPPStreamDelegate
- (void)xmppStreamDidConnect:(XMPPStream *)sender {
    [self sendPassword];
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error {
    if (error) {
        NSLog(@"%@",error);
    }
}
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender {
    [self sendOnline];
}
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error {
    NSLog(@"%@",error);
}


- (void)userLogin {
    //[self setupXMPPStream];
    [self connectToServer];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
