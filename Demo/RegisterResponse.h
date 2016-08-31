//
//  LoginResponse.h
//  Demo ObjetiveC
//
//  Created by Miguel Zapata on 31-08-16.
//  Copyright © 2016 Miguel A. Zapata. All rights reserved.
//

#import "JSONModel.h"

@protocol RegisterSessionResponse
@end

@interface RegisterSessionResponse : JSONModel
@property (assign, nonatomic) int estado;
@property (strong, nonatomic) NSString *mensaje;
@end

@implementation RegisterSessionResponse
@end

@interface RegisterResponse : JSONModel
@property (nonatomic, strong) RegisterSessionResponse *session_response;
@property (strong, nonatomic) NSString *TokenId;
@end

@implementation RegisterResponse
@end