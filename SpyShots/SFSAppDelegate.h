//
//  SFSAppDelegate.h
//  SpyShots
//
//  Created by pixelhacker on 3/4/14.
//  Copyright (c) 2014 Small Factory Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mixpanel.h"

@interface SFSAppDelegate : UIResponder <UIApplicationDelegate, MixpanelDelegate>

@property (strong, nonatomic) Mixpanel *mixpanel;
@property (strong, nonatomic) UIWindow *window;

@end
