//
//  CRXMPPTool.m
//  CoolRun
//
//  Created by Caroline.H on 3/22/16.
//  Copyright © 2016 Caroline.H. All rights reserved.
//

#import "CRXMPPTool.h"
#import "CRUserInfo.h"
@interface CRXMPPTool () <XMPPStreamDelegate>{
    CRXMPPResultBlock _resultBlock;
}

- (void) setupXMPPStream;
- (void) connectToServer;
- (void) sendPassword;
- (void) sendOnline;
@end
@implementation CRXMPPTool
singleton_implementation(CRXMPPTool)


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
        _resultBlock(CRXMPPResultTypeNetError);
        NSLog(@"%@",error);
    }
}
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender {
    _resultBlock(CRXMPPResultTypeLoginSuccess);
    [self sendOnline];
}
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error {
    _resultBlock(CRXMPPResultTypeLoginFaild);
    NSLog(@"%@",error);
}


- (void)userLogin:(CRXMPPResultBlock) block{
    //[self setupXMPPStream];
    _resultBlock = block;
    [self connectToServer];
}
@end
