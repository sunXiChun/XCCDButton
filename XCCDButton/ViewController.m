//
//  ViewController.m
//  CDa
//
//  Created by 孙西纯 on 2019/1/3.
//  Copyright © 2019 孙西纯. All rights reserved.
//

#import "ViewController.h"
#import "XCCDButton.h"

@interface ViewController ()
{
    XCCDButton *v;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    v = [[XCCDButton alloc] initWithFrame:(CGRectMake(100, 100, 100, 100))
                                  bgImage:[UIImage imageNamed:@"button_bg"]
                                maskImage:[UIImage imageNamed:@"button_shadow"]
                                 duration:3];
    [self.view addSubview:v];
    
}

@end
