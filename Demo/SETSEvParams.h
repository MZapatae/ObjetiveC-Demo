//
//  SETSEvParams.h
//  SETS + REFS
//
//  Created by Javier Balboa on 02/07/13.
//  Copyright (c) 2013 Seeketing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SETSEvParams : NSObject{
    
}
@property (nonatomic, retain) NSString *moreInfo;
@property (nonatomic, retain)NSString *text;
@property (nonatomic, retain)NSString *mediaUrl;
@property (nonatomic, retain)NSString *mediaId;
@property (nonatomic, retain)NSString *mediaType;
@property (nonatomic, retain)NSString *ecomUrl;
@property (nonatomic, retain)NSString *ecomId;
@property (nonatomic) int naviPercent;
- (id)initWithMoreInfo:(NSString*)info;
@end