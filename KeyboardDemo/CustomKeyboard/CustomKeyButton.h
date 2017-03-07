//
//  CustomKeyButton.h
//  KeyboardDemo
//
//  Created by vance on 2017/3/1.
//  Copyright © 2017年 Vancef. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomKeyButton : UIButton

+ (instancetype)customKeyButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
