//
//  DrillDownDataSource.h
//  RedBeaconPrototype
//
//  Created by DJ Mobile Inc on 3/4/13.
//  Copyright (c) 2013 DJ Mobile Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrillDownDataSource : NSObject <UITableViewDataSource>
@property (nonatomic,strong) NSMutableDictionary * jsonData;
@property (nonatomic,assign) int levelIndex;

@end
