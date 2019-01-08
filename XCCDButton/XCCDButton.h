//
//  SQhiChatAnimationView.h
//  CDa
//
//  Created by 孙西纯 on 2019/1/3.
//  Copyright © 2019 孙西纯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCCDButton : UIButton

- (instancetype)initWithFrame:(CGRect)frame
                      bgImage:(UIImage *)bgImage
                    maskImage:(UIImage *)maskImage
                     duration:(CGFloat)duration;

@end
