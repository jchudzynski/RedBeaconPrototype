//
//  NewServiceRequest.h
//  RedBeaconPrototype
//
//  Created by sadmin on 3/5/13.
//  Copyright (c) 2013 Janusz Chudzynski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewServiceRequest : NSObject
@property (nonatomic, strong) NSNumber * userId;
@property (nonatomic, strong) NSMutableArray * videoMedia;
@property (nonatomic, strong) NSMutableArray * photoMedia;
@property (nonatomic, strong) NSMutableArray * userChoices;
@property (nonatomic, strong) NSMutableArray * notes;


@end
