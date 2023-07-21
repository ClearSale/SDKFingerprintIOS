//
//  CSBehavior.h
//  CSBehavior
//
//  Created by William Awaji on 22/12/19.
//  Copyright © 2019 ClearSale. All rights reserved.
//

#import <UIKit/UIKit.h>

@import CoreLocation;

FOUNDATION_EXPORT double CSBehaviorVersionNumber;
FOUNDATION_EXPORT const unsigned char CSBehaviorVersionString[];

@interface CSBehavior : NSObject

@property (nonatomic, strong) NSString* app;

@property (nonatomic, strong) NSNumber* requestTimeout;

@property (nonatomic, strong) NSString* sessionId;

+ (CSBehavior *)getInstance:(NSString *)toApp;

- (NSString *)generateSessionId;

- (void)collectDeviceInformation:(NSString *)toSessionId;

@end
