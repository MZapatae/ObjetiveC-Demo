//
//  REFSElement.h
//  NailsCouture
//
//  Created by Javier Balboa on 07/07/13.
//  Copyright (c) 2013 Seeketing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface REFSElement : NSObject
-(id)initWithId:(long long)elementId name:(NSString*)name type:(NSString*)type params:(NSString*)params status:(int)status urgent:(int)urgent session:(int)session start:(long long)start end:(long long)end lat:(float)lat lon:(float)lon andRadio:(int)radio;
@property (nonatomic) long long elementId;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *params;
@property (nonatomic) int status;
@property (nonatomic) int urgent;
@property (nonatomic) int session;
@property (nonatomic) long long start;
@property (nonatomic) long long end;
@property (nonatomic) float lat;
@property (nonatomic) float lon;
@property (nonatomic) int radio;
@property (nonatomic) long long noty_id;
@property (nonatomic) long long ad_campaign_id;
@property (nonatomic) int trigger;
@property (nonatomic) int notified;
@property (nonatomic) int alreadysent;

@end