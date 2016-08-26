//
//  MainVC.m
//  Demo ObjetiveC
//
//  Created by Miguel Zapata on 08-08-16.
//  Copyright © 2016 Miguel A. Zapata. All rights reserved.
//

#import "MainVC.h"

@interface MainVC ()

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction) notisButton:(id)sender {
    RefsViewController *refs = [[RefsViewController alloc]init];
    [self presentViewController:refs animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
