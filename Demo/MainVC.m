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
    
    self.gender = [[NSMutableArray alloc] init];
    [self.gender addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"1", @"codigo" , @"Masculino" , @"nombre" , nil ]];
    [self.gender addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"2", @"codigo" , @"Femenino"  , @"nombre" , nil ]];
    
    
}











- (IBAction) notisButton:(id)sender {
    RefsViewController *refs = [[RefsViewController alloc]init];
    [self presentViewController:refs animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
