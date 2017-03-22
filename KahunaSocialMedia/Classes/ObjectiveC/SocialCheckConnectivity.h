//
//  CheckConnectivity.h
//  HospitalInspection
//
//  Created by Prasad Potale on 31/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/** 
 Check the connectivity of an app where it is connected to internet or not.
 **/

#import <Foundation/Foundation.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface SocialCheckConnectivity : NSObject

+(BOOL)hasConnectivity;
+(SocialCheckConnectivity*)sharedMySingleton;
@end
