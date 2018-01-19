//
//  SKSwitch.h
//  CustomSwitchLibrary
//
//  Created by Suresh Kumar on 15/12/17.
//  Copyright © 2017 Suresh Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKSwitchDelegate<NSObject>

- (void)switchLeftItemSelected:(id)sender;
- (void)switchRightItemSelected:(id)sender;

@end

@interface SKSwitch : UIView

@property (nonatomic, assign)id<SKSwitchDelegate> posSwitchDelegate;

- (void)leftImage:(UIImage *)leftImage rightImage:(UIImage *)rightImage;
- (void)leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle;

@end
