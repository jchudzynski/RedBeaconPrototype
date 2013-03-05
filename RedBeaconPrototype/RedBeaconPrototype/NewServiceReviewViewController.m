//
//  NewServiceReviewViewController.m
//  RedBeaconPrototype
//
//  Created by sadmin on 3/4/13.
//  Copyright (c) 2013 Janusz Chudzynski. All rights reserved.
//

#import "NewServiceReviewViewController.h"

@interface NewServiceReviewViewController ()
@property (strong, nonatomic) IBOutlet UITextField *zipCodeTextField;

@end

@implementation NewServiceReviewViewController

- (IBAction)cancel:(id)sender {
    NSLog(@"TO DO cancel button");
}

- (IBAction)useMyLocation:(id)sender {
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitRequest:(id)sender {
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
