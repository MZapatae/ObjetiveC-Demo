//
//  AppDelegate.m
//  Demo ObjetiveC
//
//  Created by Miguel Zapata on 12-05-16.
//  Copyright © 2016 Miguel A. Zapata. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [REFS startSession:20152015089 withLaunchOptions:launchOptions useLocation:YES useNotifications:YES testMode:YES];
    [SETS startSession:20152015089 useLocation:YES testMode:YES];
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
    NSLog(@"Token Push: %@", deviceToken);
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

@end
