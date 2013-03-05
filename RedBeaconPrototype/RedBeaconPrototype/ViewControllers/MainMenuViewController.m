//
//  MainMenuViewController.m
//  RedBeaconPrototype
//
//  Created by DJ Mobile Inc on 3/1/13.
//  Copyright (c) 2013 DJ Mobile Inc. All rights reserved.
//

#import "MainMenuViewController.h"
#import "MainMenuDataSource.h"
#import "WebViewController.h"


@interface MainMenuViewController()

@property (strong, nonatomic) IBOutlet UITableView *menuTableView;
@property (strong, nonatomic) IBOutlet UIView *container;

@end

@implementation MainMenuViewController
MainMenuDataSource * datasource;
WebViewController * webViewController;

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
    
    //Since list will contain only few items we can disable scrolling.
    self.menuTableView.scrollEnabled = NO;
    datasource = [[MainMenuDataSource alloc]init];
    self.menuTableView.dataSource = datasource;
    self.menuTableView.delegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //we will have different actions depending on sections
    
    switch (indexPath.section) {
        case 0: //section 0 operations with current requests
        {
        
        }
            break;
        case 1: //help
        {
            if(indexPath.row == 0) // How does it work section - > it will be implemented later
            {
             
              
            }
            else{
                webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"kWebViewController"];
                if(indexPath.row == 1)
                {
                    //Load help
                    webViewController.videoURL =@"http://www.youtube.com/v/3gW0brxqpIE";
                }
                else if(indexPath.row == 2){
                    //Load YouTube Video
                    webViewController.url = @"http://www.redbeacon.com/about/faq/";
                
                }
                webViewController.view.frame = self.container.bounds;
                [self addChildViewController:webViewController];
                [self.container addSubview:webViewController.view];
                [webViewController didMoveToParentViewController:self];
                
                
                
            
            }
        }
            break;
        case 2: // user actions
        {
            
        }
            break;

            
            
        default:
            break;
    }
    

}




@end
