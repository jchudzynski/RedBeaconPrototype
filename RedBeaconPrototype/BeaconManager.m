//
//  BeaconManager.m
//  RedBeaconPrototype
//
//  Created by DJ Mobile Inc on 3/1/13.
//  Copyright (c) 2013 DJ Mobile Inc. All rights reserved.
//
//This file will serve as manager for networking operations and keeping constants 
#import "BeaconManager.h"
#include <SystemConfiguration/SCNetworkReachability.h>
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) 

@implementation BeaconManager

+ (id)sharedManager {
    static BeaconManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {

    }
    return self;
}

-

-(void) addUserChoice:(NSDictionary *)choice{
    
    if(!_userChoicesArray){
        _userChoicesArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    //checking if element is not already in the list
    NSString * qid = [choice objectForKey:@"id"];
    BOOL check = false;
    for (int i = 0; i<_userChoicesArray.count; i++) {
        NSDictionary * dict = [_userChoicesArray objectAtIndex:i];
        if([[dict objectForKey:@"id"] isEqualToString:qid])
        {
            [_userChoicesArray replaceObjectAtIndex:i withObject:choice];
            check = true;
            break;
        }
        else{
            
        }
    }
    if(check == false){
        [self.userChoicesArray addObject:choice];
    }
    [_delegate itemsUpdated:self.userChoicesArray];
}



#pragma mark networking
//Testing for available connection
- (BOOL) isConnectionAvailable
{
    NSURL *url = [[NSURL alloc] initWithString:@"http://www.google.com"];
                  
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        if ([NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil])
        {
            return TRUE;
        }
        else{
            return FALSE;
        }
}


//Network Calls - it can be used for getting data from local resources

-(void)getDataFor:(NSString *)urlString localFile:(BOOL)local forViewController:(id)viewController{
    dispatch_async(kBgQueue, ^{
    NSURL * fileURL;
    if(local)
    {
        NSString * filePath = [[NSBundle mainBundle]resourcePath];
        filePath= [filePath stringByAppendingPathComponent:urlString ];
        fileURL = [NSURL fileURLWithPath:filePath];
    }
    else{
        fileURL = [NSURL URLWithString:urlString];
    }
        NSData* data = [NSData dataWithContentsOfURL:fileURL];
        //making sure that the method exists
        if([viewController respondsToSelector:@selector(receivedData:)])
        {
            [viewController performSelectorOnMainThread:@selector(receivedData:)
                           withObject:data waitUntilDone:YES];
        }
        else{
            NSLog(@"Method doesn't exist");
        }
        });
}

//uploading request
-(void)sendRequest{
    
}







@end
