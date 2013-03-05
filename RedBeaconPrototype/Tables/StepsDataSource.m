//
//  StepsDataSource.m
//  RedBeaconPrototype
//
//  Created by DJ Mobile Inc on 3/4/13.
//  Copyright (c) 2013 DJ Mobile Inc. All rights reserved.
//

#import "StepsDataSource.h"

@implementation StepsDataSource
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell * cell;
    if(indexPath.section == 0){
      cell = [tableView dequeueReusableCellWithIdentifier:@"stepsCell" forIndexPath:indexPath];
        // Heder[cell viewWithTag:100];
        [(UILabel *) [cell viewWithTag:100] setText:[[self.stepsData objectAtIndex:indexPath.row]objectForKey:@"question"]];
        [(UILabel *) [cell viewWithTag:200] setText:[[self.stepsData objectAtIndex:indexPath.row]objectForKey:@"answer"]];
 
    
    }
    else{
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mediaCell"];
        cell.textLabel.text = @"Media";
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

//    return  [[[[self.jsonData objectForKey:@"nodes"] objectAtIndex:self.levelIndex]objectForKey:@"options"]count];
    if(section ==0){
        return self.stepsData.count;

    }
    return 0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray * array = @[@"Your Choices", @"Media",@"Location", @"Notes"];
    
    return [array objectAtIndex:section];
}


@end
