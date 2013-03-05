//
//  ServicesMenuViewController.m
//  RedBeaconPrototype
//
//  Created by DJ Mobile Inc on 3/3/13.
//  Copyright (c) 2013 DJ Mobile Inc. All rights reserved.
//

#import "ServicesMenuViewController.h"
#import "CurrentServicesDataSource.h"
#import "BeaconManager.h"

@interface ServicesMenuViewController ()
@property (strong, nonatomic) IBOutlet UITableView *servicesTableView;

@end

@implementation ServicesMenuViewController
CurrentServicesDataSource  * currentServicesDataSource;
BeaconManager * manager;

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
    currentServicesDataSource = [[CurrentServicesDataSource alloc]init];
    self.servicesTableView.dataSource  = currentServicesDataSource;

    //Testing the connection
    manager = [BeaconManager sharedManager];
    //currently local file later it will be moved to the server
    [manager getDataFor:userServicesJSON localFile:YES forViewController:self];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Method resposible for networking
-(void)receivedData:(NSData *)responseData{
    //here we should parse JSON

    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    if(!error)
    {
        currentServicesDataSource.jsonData =json;
    }
    else{
        NSLog(@"Current Services Error %@ ", [error debugDescription]);
        //display meaningful error message to user
    }
    //refresh table
    [self.servicesTableView reloadData];
}

@end
