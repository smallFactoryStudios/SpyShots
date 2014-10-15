//
//  SFSViewController.m
//  SpyShots
//
//  Created by pixelhacker on 3/4/14.
//  Copyright (c) 2014 Small Factory Studios. All rights reserved.
//

#import "SFSViewController.h"
#import "Mixpanel.h"

@interface SFSViewController ()

@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) UIBarButtonItem *cameraIconBtn;
@property (strong, nonatomic) UIBarButtonItem *closeOutBtn;
@property (strong, nonatomic) UIButton *shutterButton;

@property (strong, nonatomic) UIButton *testButton;

@end

@implementation SFSViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    _cameraIconBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                                                   target:self
                                                                   action:@selector(showStealthCamera)];
    
    _closeOutBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                 target:self
                                                                 action:@selector(hideStealthMode)];
    self.navigationItem.leftBarButtonItem = _cameraIconBtn;
    
    _shutterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _shutterButton.frame = CGRectMake(6, 255, 147, 107);
    [_shutterButton setBackgroundImage:[UIImage imageNamed:@"buttonOverlay.png"] forState:UIControlStateNormal];
    [_shutterButton addTarget:self action:@selector(capturePhotos) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shutterButton];
    _shutterButton.hidden = YES;
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        // There is not a camera on this device, so don't show the camera button and alert the user
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Camera Not Available!"
                                                     message:@"This device is only meant for use with a camera"
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
        self.navigationItem.leftBarButtonItem = nil;
        
        Mixpanel *mixpanel = [Mixpanel sharedInstance];
        [mixpanel track:@"NoCameraAvailable"];
        
        [av show];
    }
}

-(void)hideStealthMode{
    self.navigationItem.leftBarButtonItem = _cameraIconBtn;
    self.navigationItem.rightBarButtonItem = nil;
    _shutterButton.hidden = YES;
    [self.imagePicker.view removeFromSuperview];
    self.imagePicker = nil;
    
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel track:@"HideStealthMode"];
}

- (void)showStealthCamera{
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel track:@"ShowStealthMode"];
    
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = _closeOutBtn;
    
    self.imagePicker = nil;
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePicker.delegate = self;
    
    self.imagePicker.allowsEditing = NO;
    self.imagePicker.showsCameraControls = NO;
    self.imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    [self.imagePicker.view setFrame:CGRectMake(166, 259, 148, 101)];
    [self.view addSubview:self.imagePicker.view];
    
    _shutterButton.hidden = NO;
    
    
}

-(void)capturePhotos{
    [self.imagePicker takePicture];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel track:@"TookPhoto"];
    
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(thisImage:hasBeenSavedInPhotoAlbumWithError:usingContextInfo:), NULL);
}

- (void)thisImage:(UIImage *)image hasBeenSavedInPhotoAlbumWithError:(NSError *)error usingContextInfo:(void*)ctxInfo {
    if (error) {
        //
    } else {
        //
    }
}

#pragma mark - iAd Delegate Methods
-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    [UIView commitAnimations];
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
