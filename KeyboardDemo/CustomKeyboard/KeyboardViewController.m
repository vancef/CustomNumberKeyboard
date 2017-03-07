//
//  KeyboardViewController.m
//  CustomKeyboard
//
//  Created by vance on 2017/3/1.
//  Copyright © 2017年 Vancef. All rights reserved.
//

#import "KeyboardViewController.h"
#import "CustomKeyButton.h"
#import "CustomKeyboardConfig.h"

@interface KeyboardViewController ()
@property (nonatomic, strong) NSArray *keyArray;
@end

@implementation KeyboardViewController

- (NSArray *)keyArray {
    if (!_keyArray) {
        _keyArray = cNumberTypeArray;
    }
    return _keyArray;
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

/**
 按钮布局
 */
- (void)setupView {
    //遍历定义好的二维数组，同时进行布局
    for (NSArray *array in self.keyArray) {
        //获取行的下标
        NSInteger index = [self.keyArray indexOfObject:array];
        for (NSString *title in array) {
            //获取每一行中的按钮的下标
            NSInteger detailIndex = [array indexOfObject:title];
            [self setKeyButtonWithTitle:title index:index detailIndex:detailIndex];
            
        }
    }
}

/**
 设置按钮

 @param title 标题
 @param index 数组的第一层下标
 @param detailIndex 数组的第二层下标
 */
- (void)setKeyButtonWithTitle:(NSString *)title index:(NSInteger)index detailIndex:(NSInteger)detailIndex {
    //按钮的宽高
    CGFloat width = cScreenWith / 3;
    CGFloat height = width / 2;
    
    CustomKeyButton *keyButton = [CustomKeyButton customKeyButtonWithTitle:title target:self action:@selector(touchKeyButton:)];
    [self.view addSubview:keyButton];
    keyButton.translatesAutoresizingMaskIntoConstraints = NO;
    //使用约束进行布局
    [keyButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:detailIndex * width].active = YES;
    [keyButton.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:height * index].active = YES;
    [keyButton.widthAnchor constraintEqualToConstant:width].active = YES;
    [keyButton.heightAnchor constraintEqualToConstant:height].active = YES;
    
    if (index == 0) {//第一行按钮，添加一个底部约束，控制整个键盘的高度
        [keyButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-height * 3].active = YES;
    }
}

/**
 触发按钮事件
 */
- (void)touchKeyButton:(UIButton *)sender {
    NSString *title = sender.titleLabel.text;
    //响应触摸事件的文本内容，这里可以使用tag来进行判断
    if ([title isEqualToString:@"del"]) {//删除按钮，执行删除
        [self.textDocumentProxy deleteBackward];
    } else if ([title isEqualToString:@""]) {//空白按钮，不做处理
        return;
    } else if ([title isEqualToString:@"next"]) {//切换按钮，切换输入法
        [self advanceToNextInputMode];
    } else {//数字按钮，将数字输入到输入框
        [self.textDocumentProxy insertText:title];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
}

@end
