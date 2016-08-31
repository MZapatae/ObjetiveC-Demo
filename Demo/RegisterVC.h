//
//  RegisterVC.h
//  Demo ObjetiveC
//
//  Created by Miguel Zapata on 31-08-16.
//  Copyright © 2016 Miguel A. Zapata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "RefsViewController.h"


@interface RegisterVC : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textNombre;
@property (strong, nonatomic) IBOutlet UITextField *textApellido;
@property (strong, nonatomic) IBOutlet UITextField *textSexo;
@property (strong, nonatomic) IBOutlet UITextField *textEmail;
@property (strong, nonatomic) IBOutlet UITextField *textFechaNacimiento;

@property (nonatomic, retain) UIPickerView *genderPicker;
@property (nonatomic, retain) UIDatePicker *datePicker;

@property MBProgressHUD *hud ;

@property NSMutableArray *gender;
@property NSString *selectedGender;

@end

