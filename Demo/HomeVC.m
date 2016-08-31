//
//  HomeVC.m
//  Demo ObjetiveC
//
//  Created by Miguel Zapata on 31-08-16.
//  Copyright © 2016 Miguel A. Zapata. All rights reserved.
//

#import "HomeVC.h"
#import "RegisterVC.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)logoutAction:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isUserLoggedIn"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userTokenId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    RegisterVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterVC"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
