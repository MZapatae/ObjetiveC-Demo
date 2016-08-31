//
//  MainVC.h
//  Demo ObjetiveC
//
//  Created by Miguel Zapata on 08-08-16.
//  Copyright © 2016 Miguel A. Zapata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "RefsViewController.h"


@interface MainVC : UIViewController
@property (strong, nonatomic) UITextField *textNombre;
@property (strong, nonatomic) UITextField *textApellido;
@property (strong, nonatomic) UITextField *textSexo;
@property (strong, nonatomic) UITextField *textEmail;
@property (strong, nonatomic) UITextField *textFechaNacimiento;

@property (nonatomic, retain) UIPickerView *genderPicker;
@property (nonatomic, retain) UIDatePicker *datePicker;

@property MBProgressHUD *hud ;

@property NSMutableArray *gender;
@property NSString *seelctedGender;

@end

