//
//  NewServiceMenuViewController.m
//  RedBeaconPrototype
//
//  Created by DJ Mobile Inc on 3/4/13.
//  Copyright (c) 2013 DJ Mobile Inc. All rights reserved.
//

#import "NewServiceMenuViewController.h"
#import "StepsDataSource.h"

@interface NewServiceMenuViewController ()
@property (strong, nonatomic) IBOutlet UITableView *stepsTableView;
@property (strong, nonatomic) IBOutlet UIView *viewContainer;
@property (strong, nonatomic) StepsDataSource * datasource;
@end

@implementation NewServiceMenuViewController
BeaconManager * manager;

BOOL mediaReached =NO;
// this will indicate that the media can be uncovered
//



//Manager Delegate
-(void)itemsUpdated:(NSMutableArray *)items{
    NSLog(@"Updated Items delegate method %@ ",items);
    if(!_datasource){
        self.datasource =[[StepsDataSource alloc]init]; 
    }
    self.datasource.stepsData = items;
    [self.stepsTableView reloadData];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    manager = [BeaconManager sharedManager];
    manager.delegate = self;
    self.datasource = [[StepsDataSource alloc]init];
    self.stepsTableView.dataSource = self.datasource;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
