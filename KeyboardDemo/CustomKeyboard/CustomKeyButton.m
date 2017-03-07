//
//  CustomKeyButton.m
//  KeyboardDemo
//
//  Created by vance on 2017/3/1.
//  Copyright © 2017年 Vancef. All rights reserved.
//

#import "CustomKeyButton.h"

@implementation CustomKeyButton

+ (instancetype)customKeyButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    CustomKeyButton *button = [[CustomKeyButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateSelected];
    [button setTintColor:[UIColor blackColor]];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}


@end
