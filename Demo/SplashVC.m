//
//  SplashVC.m
//  Demo ObjetiveC
//
//  Created by Miguel Zapata on 31-08-16.
//  Copyright © 2016 Miguel A. Zapata. All rights reserved.
//

#import "SplashVC.h"
#import "RegisterVC.h"
#import "HomeVC.h"

@interface SplashVC ()

@end

@implementation SplashVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    BOOL isLogged = [[NSUserDefaults standardUserDefaults] boolForKey:@"isUserLoggedIn"];
    isLogged ? [self loadHomeScreen] : [self loadRegisterScreen];
}

- (void)loadHomeScreen {
    HomeVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)loadRegisterScreen {
    RegisterVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterVC"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
