//
//  BeaconManager.h
//  RedBeaconPrototype
//
//  Created by DJ Mobile Inc on 3/1/13.
//  Copyright (c) 2013 DJ Mobile Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewServiceRequest.h"
//default menu in 
#define menuJSON @"mainmenu.json"
#define userServicesJSON @"userservices.json"
#define availableServicesJSON @"availableservices.json"

//delegate will be updating table view with steps
@protocol ManagerDelegate
-(void)itemsUpdated:(NSMutableArray *)item;
@end

@interface BeaconManager : NSObject
+ (id)sharedManager;
//checking for available connection
- (BOOL) isConnectionAvailable;
//getting data from local or network locations
- (void)getDataFor:(NSString *)urlString localFile:(BOOL)local forViewController:(id)viewController;

//updating user choices when placing new order
-(void) addUserChoice:(NSDictionary *)choice;


@property (nonatomic,strong) NSString * userId;
@property (nonatomic,strong) NSMutableArray * userChoicesArray;
@property (nonatomic,assign) id<ManagerDelegate> delegate;
@property (nonatomic,strong) NewServiceRequest * serviceRequest;




@end
