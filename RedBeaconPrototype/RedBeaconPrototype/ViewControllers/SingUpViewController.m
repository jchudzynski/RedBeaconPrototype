//
//  SingUpViewController.m
//  RedBeaconPrototype
//
//  Created by DJ Mobile Inc on 3/4/13.
//  Copyright (c) 2013 DJ Mobile Inc. All rights reserved.
//

#import "SingUpViewController.h"

@interface SingUpViewController ()

@end

@implementation SingUpViewController

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
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
      self.navigationController.navigationBarHidden = NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
