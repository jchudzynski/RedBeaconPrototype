//
//  MediaViewController.m
//  RedBeaconPrototype
//
//  Created by sadmin on 3/4/13.
//  Copyright (c) 2013 Janusz Chudzynski. All rights reserved.
//

#import "MediaViewController.h"
#import "NewServiceReviewViewController.h"

@interface MediaViewController ()
- (IBAction)goBack:(id)sender;
@property (strong, nonatomic) IBOutlet UICollectionView *mediaCollectionView;

@end

@implementation MediaViewController

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

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"go back?");
}

- (IBAction)goForward:(id)sender {
    NewServiceReviewViewController *v = [self.storyboard instantiateViewControllerWithIdentifier:@"kNewServiceReviewViewController"];
    [self.navigationController pushViewController:v animated:YES];
    NSLog(@"go forward?");    
}
@end
