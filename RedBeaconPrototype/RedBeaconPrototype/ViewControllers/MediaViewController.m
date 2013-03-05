//
//  MediaViewController.m
//  RedBeaconPrototype
//
//  Created by sadmin on 3/4/13.
//  Copyright (c) 2013 Janusz Chudzynski. All rights reserved.
//

#import "MediaViewController.h"
#import "NewServiceReviewViewController.h"
#import "CVHelper.h"
@interface UIImage (Extras)
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize ;
@end;
@implementation UIImage (Extras)
- (UIImage *)crop:(CGRect)rect {
    
    rect = CGRectMake(rect.origin.x*self.scale,
                      rect.origin.y*self.scale,
                      rect.size.width*self.scale,
                      rect.size.height*self.scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage *result = [UIImage imageWithCGImage:imageRef
                                          scale:self.scale
                                    orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return result;
}



+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize {
    
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        
        if (widthFactor < heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    
    // this is actually the interesting part:
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, 0.0);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    
    return newImage ;
}

@end;


@interface MediaViewController ()
@property (strong, nonatomic) IBOutlet UIButton *mediaButton;

- (IBAction)goBack:(id)sender;
@property (strong, nonatomic) IBOutlet UICollectionView *mediaCollectionView;
- (IBAction)addMediaAction:(id)sender;

@end

@implementation MediaViewController
CVHelper * cvHelper;
UIPopoverController * cameraPopoverController;


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
    cvHelper = [[CVHelper alloc]init];
	// Do any additional setup after loading the view.
    self.mediaCollectionView.dataSource=cvHelper;
    self.mediaCollectionView.delegate=cvHelper;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)goForward:(id)sender {
    NewServiceReviewViewController *v = [self.storyboard instantiateViewControllerWithIdentifier:@"kNewServiceReviewViewController"];
    [self.navigationController pushViewController:v animated:YES];
}

- (IBAction)addMediaAction:(id)sender {
    [self startCameraControllerPickerViewController:self usingDelegate:self];
    
}
#pragma mark Camera
#pragma mark camera methods
- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera] == NO))
    {   UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"We were not able to find a camera on this device" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeCamera];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = YES;
    cameraUI.delegate = self;
   
        if(!cameraPopoverController.isPopoverVisible){
            cameraPopoverController=[[UIPopoverController alloc]initWithContentViewController:cameraUI];
            [cameraPopoverController presentPopoverFromRect:self.mediaButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    return YES;
}

- (BOOL) startCameraControllerPickerViewController: (UIViewController*) controller
                                     usingDelegate: (id <UIImagePickerControllerDelegate,
                                                     UINavigationControllerDelegate>) delegate {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == NO )
    {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"We were not able to use photo album on this device" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:
                          UIImagePickerControllerSourceTypePhotoLibrary];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    cameraUI.delegate = self;
    if(!cameraPopoverController.isPopoverVisible){
        cameraPopoverController=[[UIPopoverController alloc]initWithContentViewController:cameraUI];
            
            [cameraPopoverController presentPopoverFromRect:self.mediaButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

    }
    return YES;
}



// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    //  NSLog(@"Did Finish Picking");
    UIImage *originalImage, *editedImage;
    UIImage * imageToUse;
    // Handle a still image capture
    if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        if (editedImage) {
            imageToUse = editedImage;
            
            
        } else {
            imageToUse = originalImage;
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    [cameraPopoverController dismissPopoverAnimated:YES];

}

- (void) image: (UIImage *) image
didFinishWithError: (NSError *) error
   contextInfo: (void *) contextInfo{
    if(error!=nil)
    {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Image couldn't be saved at this time." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
    }
    else{
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Image was successfully saved." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



@end
