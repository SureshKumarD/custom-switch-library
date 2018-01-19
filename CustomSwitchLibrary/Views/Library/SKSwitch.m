//
//  SKSwitch.m
//  CustomSwitchLibrary
//
//  Created by Suresh Kumar on 15/12/17.
//  Copyright © 2017 Suresh Kumar. All rights reserved.
//

#import "SKSwitch.h"

@interface SKSwitch()

@property (nonatomic, strong) UIButton *leftButton, *rightButton;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *leftSelectedImage, *rightSelectedImage;
@property (nonatomic, assign) BOOL isON;

@end


@implementation SKSwitch

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupViews];
    
    _isON               = NO;
    _leftSelectedImage  = [UIImage imageNamed:@"switch_emoji_off"];
    _rightSelectedImage = [UIImage imageNamed:@"switch_emoji_on"];
    [_leftButton setTitle:@"OFF" forState:UIControlStateNormal];
    [_leftButton setUserInteractionEnabled:YES];
    
    [_rightButton setTitle:@"ON" forState:UIControlStateNormal];
    [_rightButton setUserInteractionEnabled:YES];
    
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
}

#pragma mark - PRIVATE METHODS
- (void)setupViews {
    
    [self setupImageView];
    [self setupLeftButton];
    [self setupRightButton];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_leftButton]-0-[_imageView]-0-[_rightButton]"
                                                                 options:0
                                                                 metrics:nil
                                                 views:NSDictionaryOfVariableBindings(_leftButton,_imageView,_rightButton)]];
   
}

- (void)setupImageView {
    _imageView       = [UIImageView new];
    _imageView.image = [UIImage imageNamed:@"switch_emoji_off"];
    
    [_imageView setBackgroundColor:[UIColor clearColor]];
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [_imageView addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:40]];
    [_imageView addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:80]];
    
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeGestureDetected:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    _imageView.userInteractionEnabled = YES;
    [_imageView addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeGestureDetected:)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [_imageView addGestureRecognizer:rightSwipeGesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchImageViewTapped:)];
    tapGesture.numberOfTapsRequired = 1;
    [_imageView addGestureRecognizer:tapGesture];
    [self addSubview:_imageView];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
}

- (void)setupLeftButton {
    _leftButton  = [UIButton new];
    _leftButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_leftButton setUserInteractionEnabled:YES];
    [_leftButton addTarget:self action:@selector(leftButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [_leftButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_leftButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-bold" size:16]];
    [_leftButton.titleLabel setTextAlignment:NSTextAlignmentRight];
    [_leftButton addConstraint:[NSLayoutConstraint constraintWithItem:_leftButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:40]];
    [_leftButton addConstraint:[NSLayoutConstraint constraintWithItem:_leftButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:68]];

    [self addSubview:_leftButton];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_leftButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

- (void)setupRightButton {
    _rightButton = [UIButton new];
    _rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_rightButton setUserInteractionEnabled:YES];
    [_rightButton addTarget:self action:@selector(rightButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_rightButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-bold" size:16]];
    [_rightButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    
    [_rightButton addConstraint:[NSLayoutConstraint constraintWithItem:_rightButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:40]];
    [_rightButton addConstraint:[NSLayoutConstraint constraintWithItem:_rightButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:68]];
   
    
    [self addSubview:_rightButton];
     [self addConstraint:[NSLayoutConstraint constraintWithItem:_rightButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}


- (void)leftButtonTapped:(id)sender {
    [self leftItemSelected];
    
}

- (void)rightButtonTapped:(id)sender {
    [self rightItemSelected];
}

- (void)leftSwipeGestureDetected:(id)sender {
    [self leftItemSelected];
}

- (void)rightSwipeGestureDetected:(id)sender {
    [self rightItemSelected];
}

- (void)switchImageViewTapped:(UITapGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:gestureRecognizer.view];
    CGFloat midPoint = _imageView.bounds.size.width/2.0;
    if(point.x< midPoint - 10) {
        [self leftItemSelected];
    }else if(point.x> midPoint + 10) {
        [self rightItemSelected];
    }else {
        //Do nothing.
    }
}


- (void)leftItemSelected {
    if(!_isON) {
        _isON            = YES;
        _imageView.image = _leftSelectedImage;
        if([self.posSwitchDelegate respondsToSelector:@selector(posSwitchLeftItemSelected:)]) {
            [self.posSwitchDelegate switchLeftItemSelected:self];
        }
        
       
    }
}
- (void)rightItemSelected {
    if(_isON) {
        _isON            = NO;
        _imageView.image = _rightSelectedImage;
        if([self.posSwitchDelegate respondsToSelector:@selector(posSwitchRightItemSelected:)]) {
            [self.posSwitchDelegate switchRightItemSelected:self];
        }
        
    }
}
#pragma mark - PUBLIC METHODS
#pragma mark - Customization.
- (void)leftImage:(UIImage *)leftImage rightImage:(UIImage *)rightImage{
    _leftSelectedImage  = leftImage;
    _rightSelectedImage = rightImage;
}

- (void)leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle {
    [_leftButton setTitle:leftTitle forState:UIControlStateNormal];
    [_rightButton setTitle:rightTitle forState:UIControlStateNormal];
}

@end
