//
//  ViewController.m
//  CustomSwitchLibrary
//
//  Created by Suresh Kumar on 19/12/17.
//  Copyright © 2017 Suresh Kumar. All rights reserved.
//

#import "ViewController.h"
#import "SKSwitch.h"

typedef NS_ENUM(NSUInteger, SKSwiftTag) {
    SKSwitchTagType1 = 100,
    SKSwitchTagType2,
    SKSwitchTagType3
};

@interface ViewController ()<SKSwitchDelegate>
@property (weak, nonatomic) IBOutlet SKSwitch *switch1;
@property (weak, nonatomic) IBOutlet SKSwitch *switch2;
@property (weak, nonatomic) IBOutlet SKSwitch *switch3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setUpSwitch2];
    [self setUpSwitch3];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpSwitch2 {
    _switch2.tag = SKSwitchTagType2;
    [_switch2 leftTitle:@"Left" rightTitle:@"Right"];
    [_switch2 leftImage:[UIImage imageNamed:@"switch_inner_off"] rightImage:[UIImage imageNamed:@"switch_inner_on"]];
}

- (void)setUpSwitch3 {
    _switch3.tag = SKSwitchTagType2;
    [_switch3 leftTitle:@"NO" rightTitle:@"YES"];
    [_switch3 leftImage:[UIImage imageNamed:@"switch_off"] rightImage:[UIImage imageNamed:@"switch_on"]];
}

#pragma mark - Switch Delegate

- (void)switchLeftItemSelected:(id)sender {
    
}
- (void)switchRightItemSelected:(id)sender{
    
}

@end
