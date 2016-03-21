//
//  CRXMPPTool.h
//  CoolRun
//
//  Created by Caroline.H on 3/22/16.
//  Copyright © 2016 Caroline.H. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "XMPPFramework.h"
typedef enum {
    CRXMPPResultTypeLoginSuccess,
    CRXMPPResultTypeLoginFaild,
    CRXMPPResultTypeNetError
}CRXMPPResultType;

typedef void(^CRXMPPResultBlock)(CRXMPPResultType type);

@interface CRXMPPTool : NSObject
singleton_interface(CRXMPPTool)

@property (strong,nonatomic) XMPPStream *xmppStream;
- (void) userLogin:(CRXMPPResultBlock) block;

- (void) setupXMPPStream;
- (void) connectToServer;
- (void) sendPassword;
- (void) sendOnline;

@end
