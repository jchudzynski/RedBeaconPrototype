//
//  WebViewController.m
//  RedBeaconPrototype
//
//  Created by DJ Mobile Inc on 3/3/13.
//  Copyright (c) 2013 DJ Mobile Inc. All rights reserved.
//

#import "WebViewController.h"
#import "BeaconManager.h"
@interface WebViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webview;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation WebViewController

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
    self.webview.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if([[BeaconManager sharedManager]isConnectionAvailable]){
        if(self.videoURL)
        {
            [self displayGoogleVideo:self.videoURL];
        }
        if(self.url)
        {
            [self loadURL:self.url];
        }
    }
    else{
        //read local resources or display error message
        NSLog(@"No Internet");
    }
}

-(void)loadURL:(NSString *)url{
    NSURLRequest * request = [NSURLRequest requestWithURL:[[NSURL alloc]initWithString:url]];
    [self.webview loadRequest:request];
}

- (void) displayGoogleVideo:(NSString *)videoURL;
{
    CGRect webFrame = CGRectMake(0, self.toolbar.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height -  self.toolbar.frame.size.height);
    self.webview.frame = webFrame;
    
        
    NSString *htmlString = [NSString stringWithFormat:@"<html><head><meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = yes \"/></head><body style=\"background:#F00;margin-top:0px;margin-left:0px\"><div><object width=\"%d\" height=\"%d\"><param name=\"movie\" value=\"%@\"></param><param name=\"wmode\" value=\"transparent\"></param><embed src=\"%@\" type=\"application/x-shockwave-flash\" wmode=\"transparent\" width=\"%d\" height=\"%d\"></embed></object></div></body></html>",(int)self.webview.frame.size.width, (int)self.webview.frame.size.height, videoURL,videoURL,(int)self.webview.frame.size.width, (int)self.webview.frame.size.height];
    
    [self.webview loadHTMLString:htmlString baseURL:[NSURL URLWithString:@"http://www.youtube.com"]];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"Error while loading webView %@",[error debugDescription]);
    
}



@end
