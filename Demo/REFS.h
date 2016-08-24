//
//  REFS.h
//  SETS + REFS
//
//  Created by Javier Balboa on 20/06/13.
//  Copyright (c) 2013 Seeketing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "SETS.h"

@interface REFS : NSObject <UIAlertViewDelegate>
+(void)Start_Session:(long long)App_ID withLaunchOptions:(NSDictionary*)launchOptions bUseLocation:(BOOL)UseLocation bNotifications:(BOOL)UseNotifications testMode:(BOOL)testMode __attribute__((deprecated));

+(void)startSession:(long long)appID withLaunchOptions:(NSDictionary*)launchOptions useLocation:(BOOL)location useNotifications:(BOOL)notifications testMode:(BOOL)testMode;
+(void)applicationDidReceiveRemoteNotification:(NSDictionary*)userInfo withApplicationState:(UIApplication*)application;
+(void)notificationReceivedWithId:(long long)idNotif withApplicationState:(UIApplication*)application andNotification:(UILocalNotification *)notification;
+(void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken;
+(NSArray*)windowElements;
+(void)elementSelected:(long long)notifyId;
+(void)showExternalBrowser:(long long)notifyId;
+(void)endSession;
+(void)resumeSession;
+(void)showLogs:(BOOL)show;
//Phonegap help
//TODO remove from this version +(void)setDefaultWebView:(UIWebView*)theWebView;
@end