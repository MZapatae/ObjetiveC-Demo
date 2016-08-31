//
//  AppDelegate.m
//  Demo ObjetiveC
//
//  Created by Miguel Zapata on 12-05-16.
//  Copyright © 2016 Miguel A. Zapata. All rights reserved.
//

#import "AppDelegate.h"
#import <sys/utsname.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [REFS startSession:20152015089 withLaunchOptions:launchOptions useLocation:YES useNotifications:YES testMode:YES];
    [SETS startSession:20152015089 useLocation:YES testMode:YES];
    
    [self registerDeviceData];
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)]){
        // iOS 8 Notifications
        [[UIApplication sharedApplication]
         registerUserNotificationSettings:[UIUserNotificationSettings
                                           settingsForTypes: (UIUserNotificationTypeSound |
                                                              UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                           categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [REFS applicationDidReceiveRemoteNotification:userInfo
                             withApplicationState:application];
    
    NSLog(@"Received Remote Notification");
    NSLog(@"Remote notification: %@",[userInfo description]);
    
    NSArray *dataArray = [[NSArray alloc] initWithArray:[userInfo objectForKey:@"data"]];
    NSDictionary *data = [[NSDictionary alloc] initWithDictionary:[dataArray objectAtIndex:0]];
    NSDictionary *params = [[NSDictionary alloc] initWithDictionary:[userInfo objectForKey:@"params"]];
    
    NSString *refsId = [data objectForKey:@"id"];
    NSString *refsNotyId = [data objectForKey:@"noty_id"];
    NSString *refsTitle = [params objectForKey:@"ntps_title"];
    NSString *refsMessage = [params objectForKey:@"ntps_msg"];

    NSLog(@"Seeketing Received Id: %@", refsId);
    NSLog(@"Seeketing Received Noty Id: %@", refsNotyId);
    NSLog(@"Seeketing Received Title: %@", refsTitle);
    NSLog(@"Seeketing Received Message: %@", refsMessage);

    /*
     
        NSString *badge = [apsInfo objectForKey:@"badge"];
        NSString *alert = [apsInfo objectForKey:@"alert"];
        NSString *sound = [apsInfo objectForKey:@"sound"];
        NSString *title = [notificationInfo objectForKey:@"titulo"];
        NSString *body = [notificationInfo objectForKey:@"body"];
        int pushType = [[notificationInfo objectForKey:@"tipo_push"] intValue];
        
        NSLog(@"Received Push Badge: %@", badge);
        NSLog(@"Received Push Alert: %@", alert);
        NSLog(@"Received Push Sound: %@", sound);
        
        NSLog(@"Received Push Title: %@", title);
        NSLog(@"Received Push Body: %@", body);
        NSLog(@"Received Push Push Type: %d", pushType);
        
        UIApplicationState state = [[UIApplication sharedApplication] applicationState];
        if (state == UIApplicationStateBackground || state == UIApplicationStateInactive)
        {
            application.applicationIconBadgeNumber = [[apsInfo objectForKey:@"badge"] integerValue];
            [[NSUserDefaults standardUserDefaults] setInteger:pushType forKey:@"pushTypeReceived"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"pushNotification" object:nil userInfo:userInfo];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: title
                                                                message: body  delegate:self
                                                      cancelButtonTitle:@"Cerrar"
                                                      otherButtonTitles:nil, nil];
            alertView.tag = 10 ;
            [alertView show];
        }*/

    
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [REFS notificationReceivedWithId:[[notification.userInfo objectForKey:@"noty_id"] longLongValue]
                withApplicationState:application
                     andNotification:notification];
    
    NSLog(@"Received Local Notification");

}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *tokenPush = [[[[deviceToken description]
                             stringByReplacingOccurrencesOfString:@"<" withString:@""]
                             stringByReplacingOccurrencesOfString:@">" withString:@""]
                             stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [[NSUserDefaults standardUserDefaults] setObject:tokenPush forKey:@"tokenPush"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"Update Token Push: %@", tokenPush);
    
    [REFS didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [REFS endSession];
    [SETS endSession];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [REFS resumeSession];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)registerDeviceData {
    UIDevice *device = [UIDevice currentDevice];
    NSUUID *identifierForVendor;
    identifierForVendor = [UIDevice currentDevice].identifierForVendor;
    NSString *nameApp = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    NSString *versionApp = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *deviceId = [identifierForVendor UUIDString];
    NSString *nameDevice = device.name;
    NSString *modelDevice = [self platformType:self.deviceModel];
    NSString *iOSversionDevice = device.systemVersion;
    NSString *tokenPush = @"NO-TOKEN-PUSH";
    
    [[NSUserDefaults standardUserDefaults] setObject:deviceId forKey:@"deviceId"];
    [[NSUserDefaults standardUserDefaults] setObject:nameApp forKey:@"nameApp"];
    [[NSUserDefaults standardUserDefaults] setObject:versionApp forKey:@"versionApp"];
    [[NSUserDefaults standardUserDefaults] setObject:nameDevice forKey:@"nameDevice"];
    [[NSUserDefaults standardUserDefaults] setObject:modelDevice forKey:@"modelDevice"];
    [[NSUserDefaults standardUserDefaults] setObject:iOSversionDevice forKey:@"iOSversionDevice"];
    [[NSUserDefaults standardUserDefaults] setObject:tokenPush forKey:@"tokenPush"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"Device Id: %@", deviceId);
    NSLog(@"Name App: %@", nameApp);
    NSLog(@"Version App: %@", versionApp);
    NSLog(@"Name Device: %@", nameDevice);
    NSLog(@"Model Device: %@", modelDevice);
    NSLog(@"iOS Version: %@", iOSversionDevice);
    NSLog(@"Token Push: %@", tokenPush);
}

- (NSString *) platformType:(NSString *)platform {
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([platform isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    return platform;
}

- (NSString *) deviceModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

@end
