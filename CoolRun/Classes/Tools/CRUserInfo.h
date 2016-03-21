//
//  CRUserInfo.h
//  CoolRun
//
//  Created by Caroline.H on 3/22/16.
//  Copyright © 2016 Caroline.H. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface CRUserInfo : NSObject
singleton_interface(CRUserInfo)
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *userPasswd;

@end
