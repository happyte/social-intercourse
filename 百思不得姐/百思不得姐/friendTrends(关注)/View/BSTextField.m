//
//  BSTextField.m
//  百思不得姐
//
//  Created by 张树 on 16/5/17.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "BSTextField.h"
#import <objc/runtime.h>

@implementation BSTextField

static NSString *BSTextPlaceholder = @"_placeholderLabel.textColor";

//+ (void)initialize {
//    unsigned int count = 0;
//    Ivar *vars =  class_copyIvarList([UITextField class], &count);
//    for ( int i = 0; i < count; i++) {
//        Ivar var  = vars[i];
//        NSLog(@"%s",ivar_getName(var));
//    }
//}

- (void)awakeFromNib {
    self.tintColor = self.textColor;
    [self resignFirstResponder];
}

//成为第一响应者
- (BOOL)becomeFirstResponder {
    [self setValue:self.textColor forKeyPath:BSTextPlaceholder];
    return [super becomeFirstResponder];
}

//非第一响应者
- (BOOL)resignFirstResponder {
    [self setValue:[UIColor grayColor]forKeyPath:BSTextPlaceholder];
    return [super resignFirstResponder];
}

@end
