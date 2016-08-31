//
//  RegisterVC.m
//  Demo ObjetiveC
//
//  Created by Miguel Zapata on 31-08-16.
//  Copyright © 2016 Miguel A. Zapata. All rights reserved.
//

#import "RegisterVC.h"
#import "RegisterResponse.h"
#import "HomeVC.h"


@interface RegisterVC ()
@property (strong, atomic) RegisterResponse *jsonResponse;

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupPicker:self.textSexo Index:1];
    [self setupDatePicker];

}

- (IBAction)registerUser:(id)sender {
    @try {
        if (![self validateNameWithString:self.textNombre.text]) {
            [self showAlertViewWithTitle:@"Alerta" andMessage:@"Ingrese su nombre"];
        } else if (![self validateNameWithString:self.textApellido.text]) {
            [self showAlertViewWithTitle:@"Alerta" andMessage:@"Ingrese su apellido"];
        } else if (![self validateEmailWithString:self.textEmail.text]) {
            [self showAlertViewWithTitle:@"Alerta" andMessage:@"Ingrese un email válido"];
        } else if (![self validateBornDateWithString:self.textFechaNacimiento.text]) {
            [self showAlertViewWithTitle:@"Alerta" andMessage:@"Ingrese fecha de nacimiento"];
        } else if (![self validateTextWithString:self.textSexo.text]) {
            [self showAlertViewWithTitle:@"Alerta" andMessage:@"Ingrese genero"];
        } else {
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSDictionary *params = @{@"NombreCompleto":[NSString stringWithFormat:@"%@ %@", self.textNombre.text, self.textApellido.text],
                                     @"Email": self.textEmail.text,
                                     @"FechaNacimiento": self.textFechaNacimiento.text,
                                     @"Genero": self.selectedGender,
                                     @"Nameid": [[NSUserDefaults standardUserDefaults] stringForKey:@"deviceId"],
                                     @"VersionApp": [[NSUserDefaults standardUserDefaults] stringForKey:@"versionApp"],
                                     @"TokenPush": [[NSUserDefaults standardUserDefaults] stringForKey:@"tokenPush"],
                                     @"ModeloDispositivo": [[NSUserDefaults standardUserDefaults] stringForKey:@"modelDevice"],
                                     @"VersionOS": [[NSUserDefaults standardUserDefaults] stringForKey:@"iOSversionDevice"],
                                     @"Fabricante": @"Apple",
                                     @"TipoOS": @"IOS",
                                    };
            NSLog(@"Register Params: %@", params);
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                [manager POST:@"http://asdf" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSLog(@"JSON: %@", responseObject);
                    self.jsonResponse = [[RegisterResponse alloc] initWithDictionary:responseObject error:nil];
                    if ([self.jsonResponse.session_response estado] == 0) {
                                                
                        // Save Data
                        [[NSUserDefaults standardUserDefaults] setObject:self.jsonResponse.TokenId forKey:@"userTokenId"];
                        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isUserLoggedIn"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                        HomeVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
                        [self presentViewController:vc animated:YES completion:nil];
                    }
                    if ([self.jsonResponse.session_response estado] == 301){
                        [self showAlertViewWithTitle:@"Alerta" andMessage:[self.jsonResponse.session_response mensaje]];
                    }
                    if ([self.jsonResponse.session_response estado] == 302){
                        [self showAlertViewWithTitle:@"Alerta" andMessage:[self.jsonResponse.session_response mensaje]];
                    }
                    if ([self.jsonResponse.session_response estado] == 303){
                        [self showAlertViewWithTitle:@"Alerta" andMessage:[self.jsonResponse.session_response mensaje]];
                    }
                    if ([self.jsonResponse.session_response estado] == 304){
                        [self showAlertViewWithTitle:@"Alerta" andMessage:[self.jsonResponse.session_response mensaje]];
                    }
                    if ([self.jsonResponse.session_response estado] == 305){
                        [self showAlertViewWithTitle:@"Alerta" andMessage:[self.jsonResponse.session_response mensaje]];
                    }
                    if ([self.jsonResponse.session_response estado] == 306){
                        [self showAlertViewWithTitle:@"Alerta" andMessage:[self.jsonResponse.session_response mensaje]];
                    }
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [self showAlertViewWithTitle:@"Alerta" andMessage:@"Se ha producido un error de conexión, favor reintentar"];
                }];
            });
        }
    }
    @catch (NSException *exception) {
        [self showAlertViewWithTitle:@"Alerta" andMessage:@"Hubo un problema en el ingreso, intentalo de nuevo"];
    }
    @finally {
        NSLog(@"Try catch launched!");
    }
    
}


- (void)setupDatePicker {
    NSDateComponents *minDate = [[NSDateComponents alloc] init];
    [minDate setDay:1];
    [minDate setMonth:1];
    [minDate setYear:1900];
    
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeDate ;
    self.datePicker.minimumDate = [[NSCalendar currentCalendar] dateFromComponents:minDate];
    self.datePicker.maximumDate = [NSDate date];
    [self.datePicker setDate:[[NSCalendar currentCalendar] dateFromComponents:minDate]];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.barStyle   = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem *itemDone = [[UIBarButtonItem alloc]
                                 initWithTitle:@"Cerrar" style:UIBarButtonItemStylePlain target:self action:@selector(selectDate:)
                                 ];
    
    UIBarButtonItem *itemSpace = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                  target:nil action:nil];
    
    toolbar.items = @[itemSpace,itemDone];
    [self.textFechaNacimiento setInputAccessoryView: toolbar ];
    [self.textFechaNacimiento setInputView:self.datePicker];
}

- (void)setupPicker:(UITextField*) field Index:(NSInteger) index {
    
    self.gender = [[NSMutableArray alloc] init];
    [self.gender addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"1", @"Index" , @"Masculino" , @"Gender" , nil ]];
    [self.gender addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"2", @"Index" , @"Femenino"  , @"Gender" , nil ]];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem *itemDone;
    UIBarButtonItem *itemSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    if (index == 1) {
        
        itemDone = [[UIBarButtonItem alloc] initWithTitle:@"Cerrar"
                                                    style:UIBarButtonItemStylePlain
                                                   target:self
                                                   action:@selector(selectGender:)];
        
        self.genderPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
        self.genderPicker.tag = index;
        self.genderPicker.delegate = self ;
        self.genderPicker.dataSource = self ;
        [field setInputView:self.genderPicker];
    }
    
    toolbar.items = @[itemSpace,itemDone];
    [field setInputAccessoryView:toolbar];
}

- (void)selectGender:(id) sender {
    NSInteger row = [self.genderPicker selectedRowInComponent:0];
    
    [self.textSexo setText: [[self.gender objectAtIndex:row] objectForKey:@"Gender"]];
    self.selectedGender = [[self.gender objectAtIndex:row] objectForKey:@"Index"];
    [self.view endEditing:YES];
}

- (void)selectDate:(id) sender{
    [self.view endEditing:YES];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    NSString *formatedDate = [dateFormatter stringFromDate:self.datePicker.date];
    self.textFechaNacimiento.text = formatedDate;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark UIPicker delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"%ld",(long)row);
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView.tag == 1) {
        return [self.gender count];
    } else {
        return 0;
    }
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView.tag == 1 ) {
        return [[self.gender objectAtIndex: row] objectForKey:@"Gender"];
    } else {
        return @"null";
    }
}

- (IBAction) notisButton:(id)sender {
    RefsViewController *refs = [[RefsViewController alloc]init];
    [self presentViewController:refs animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)validatePhoneWithString:(NSString*)phoneNumber {
    //NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    NSString *phoneRegex = @"[0-9]{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phoneNumber];
}

- (BOOL)validateEmailWithString:(NSString*)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)validateNameWithString:(NSString*)text {
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    if ([[text stringByTrimmingCharactersInSet: set] length] == 0 || text == (id)[NSNull null] || text.length == 0 )
        return NO;
    else {
        NSString *regx = @"^[\\p{L} .'-]+$";
        NSPredicate *stringTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regx];
        return [stringTest evaluateWithObject:text];
    }
}


- (BOOL)validateTextWithString:(NSString*)text {
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    if ([[text stringByTrimmingCharactersInSet: set] length] == 0 || text == (id)[NSNull null] || text.length == 0 )
        return NO;
    else
        return YES;
}

-(BOOL) validateBornDateWithString:(NSString *) dateOfBirth
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateStyle:NSDateFormatterShortStyle];
    [format setDateFormat:@"dd/MM/yyyy"];
    NSDate *validateDOB = [format dateFromString:dateOfBirth];
    if (validateDOB != nil)
        return YES;
    else
        return NO;
}

- (void)showAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
