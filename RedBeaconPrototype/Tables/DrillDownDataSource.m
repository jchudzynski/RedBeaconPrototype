//
//  DrillDownDataSource.m
//  RedBeaconPrototype
//
//  Created by DJ Mobile Inc on 3/4/13.
//  Copyright (c) 2013 DJ Mobile Inc. All rights reserved.
//

#import "DrillDownDataSource.h"

@implementation DrillDownDataSource
#pragma mark Table View
-(id)init{
    self = [super init];
    if(self)
    {
        self.levelIndex=0;
    }
    return self;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"drillDownCell" forIndexPath:indexPath];
    cell.textLabel.text = [[[[[self.jsonData objectForKey:@"nodes"] objectAtIndex:self.levelIndex]objectForKey:@"options"]objectAtIndex:indexPath.row]objectForKey:@"name"] ;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      return  [[[[self.jsonData objectForKey:@"nodes"] objectAtIndex:self.levelIndex]objectForKey:@"options"]count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [[[self.jsonData objectForKey:@"nodes"] objectAtIndex:self.levelIndex]objectForKey:@"title"];
}

@end
