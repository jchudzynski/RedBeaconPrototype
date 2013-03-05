//
//  ServiceDrillDownViewController.m
//  RedBeaconPrototype
//
//  Created by DJ Mobile Inc on 3/4/13.
//  Copyright (c) 2013 DJ Mobile Inc. All rights reserved.
//

#import "ServiceDrillDownViewController.h"
#import "DrillDownDataSource.h"
#import "BeaconManager.h"
#import "MediaViewController.h"

@interface ServiceDrillDownViewController ()
@property (strong, nonatomic) IBOutlet UITableView *optionsTableView;
@property (strong, nonatomic)DrillDownDataSource * datasource;
- (IBAction)goBack:(id)sender;
- (IBAction)forward:(id)sender;

@end

@implementation ServiceDrillDownViewController

BeaconManager * manager;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _datasource = [[DrillDownDataSource alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if(!manager){
        manager = [BeaconManager sharedManager];
    }
    _datasource = [[DrillDownDataSource alloc]init];
    self.optionsTableView.dataSource = self.datasource;
    self.optionsTableView.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
	// Do any additional setup after loading the view.
    _datasource = [[DrillDownDataSource alloc]init];
    self.optionsTableView.dataSource = self.datasource;
    self.optionsTableView.scrollEnabled = NO;
    [self.optionsTableView setBackgroundView:nil];
    self.optionsTableView.backgroundColor = [UIColor clearColor];
    
    if(!manager){
        manager = [BeaconManager sharedManager];
    }
    [manager getDataFor:availableServicesJSON localFile:YES forViewController:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)receivedData:(NSData *)responseData{
    //here we should parse JSON
    
    NSError* error;
    NSMutableDictionary* json = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error]];
    
    if(!error)
    {

        self.datasource.jsonData =json;
        NSLog(@"Received data");
    }
    else{
        NSLog(@"Service Drill Down JSON Error %@ ", [error debugDescription]);
        //display meaningful error message to user
    }
    //refresh table
    [self.optionsTableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
    //add this option to a main table
   }


- (IBAction)goBack:(id)sender {
    self.datasource.levelIndex--;
    if(self.datasource.levelIndex >=0)
    {
       [self.optionsTableView reloadData]; 
    }
    else{
        [[[self parentViewController]navigationController]popViewControllerAnimated:YES];
    }
}

- (IBAction)forward:(id)sender {
    if(self.optionsTableView.indexPathForSelectedRow)
    {
        NSIndexPath *indexPath = self.optionsTableView.indexPathForSelectedRow;
        
        NSMutableDictionary * userAnswer = [[NSMutableDictionary alloc]initWithCapacity:0];
        //Setting answer
        NSString * answer= [[[[[self.datasource.jsonData objectForKey:@"nodes"] objectAtIndex:self.datasource.levelIndex]objectForKey:@"options"]objectAtIndex:indexPath.row]objectForKey:@"name"];
        
        NSString * question =[[[self.datasource.jsonData objectForKey:@"nodes"] objectAtIndex:self.datasource.levelIndex]objectForKey:@"title"];
        
        [userAnswer setValue:[NSString stringWithFormat:@"%d",self.datasource.levelIndex] forKey:@"id"];
        [userAnswer setValue:question forKey:@"question"];
        [userAnswer setValue:answer forKey:@"answer" ];
        [manager addUserChoice: userAnswer];
        
        //check if exists
        if([[[[[_datasource.jsonData objectForKey:@"nodes"] objectAtIndex:_datasource.levelIndex]objectForKey:@"options"]objectAtIndex:indexPath.row]objectForKey:@"childNode"]!= [NSNull null])
        {
            
            NSString * childNodeIndexString =[[[[[_datasource.jsonData objectForKey:@"nodes"] objectAtIndex:_datasource.levelIndex]objectForKey:@"options"]objectAtIndex:indexPath.row]objectForKey:@"childNode"];
            
            int childNodeIndex = [childNodeIndexString  intValue];
            _datasource.levelIndex = childNodeIndex;
            [self.optionsTableView reloadData];
        }
        else {
            //if it doesn't show media controller.
           MediaViewController * mediaController = [self.parentViewController.storyboard instantiateViewControllerWithIdentifier:@"kMediaController"];
            [[[self parentViewController]navigationController]pushViewController:mediaController animated:YES];
            
        }
    }
    else{
        NSLog(@"Show Message to the user");
    }

}

@end
