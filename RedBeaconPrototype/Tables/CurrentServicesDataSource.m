//
//  MainMenuDataSource.m
//  RedBeaconPrototype
//
//  Created by DJ Mobile Inc on 3/1/13.
//  Copyright (c) 2013 DJ Mobile Inc. All rights reserved.
//

#import "CurrentServicesDataSource.h"
#import "BeaconManager.h"
#import "ServiceCell.h"


@implementation CurrentServicesDataSource


-(id)init{
    if(self=[super init])
    {
        //[self parseJSON];
      
        
    }
    return  self;
}

//takes data from json file.
// For now we are parsing local file. Json file might be eventually moved to the web

-(void)parseJSON{
/*
    NSString * jsonFileName = menuJSON;
    NSString * mainBundlePath = [[NSBundle mainBundle]resourcePath];
    NSString *jsonPath = [mainBundlePath stringByAppendingPathComponent:jsonFileName];
    NSData * data = [NSData dataWithContentsOfFile: jsonPath];
    [self updateUIWithData:data];
*/
 }


-(void)updateUIWithData:(NSData *)responseData{

    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    if(error!=nil)
    {
        //error occured.
        NSLog(@" ERROR ");
    
        
    }
    else{
        self.jsonData = json;
        
    }
}


#pragma mark datasource methods

#pragma mark Table View

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ServiceCell * cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"kCurrentServiceCell" forIndexPath:indexPath];
  /*
    NSString * text = [[[[[self.jsonData objectForKey:@"sections"]objectAtIndex:indexPath.section]objectForKey:@"cells"]objectAtIndex:indexPath.row]objectForKey:@"title"];
    
    cell.label.text = text;
    cell.imageView.image =[UIImage imageNamed:@"red"];
*/
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  4; //[[[[self.jsonData objectForKey:@"sections"]objectAtIndex:section]objectForKey:@"cells"]count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"Current Services";
}








@end
