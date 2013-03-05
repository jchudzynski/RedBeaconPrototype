//
//  MainMenuDataSource.h
//  RedBeaconPrototype
//
//  Created by DJ Mobile Inc on 3/1/13.
//  Copyright (c) 2013 DJ Mobile Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainMenuDataSource : NSObject <UITableViewDataSource>
@property (nonatomic,strong) NSDictionary * jsonData;
@end
